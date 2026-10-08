package com.ruoyi.task.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.task.domain.TaskItem;
import com.ruoyi.task.domain.TaskStatistics;
import com.ruoyi.task.mapper.TaskItemMapper;
import com.ruoyi.task.service.ITaskItemService;

/**
 * Personal task service implementation.
 */
@Service
public class TaskItemServiceImpl implements ITaskItemService
{
    private static final Long ROOT_ID = 0L;

    private static final String STATUS_TODO = "0";
    private static final String STATUS_IN_PROGRESS = "1";
    private static final String STATUS_COMPLETED = "2";
    private static final String STATUS_CANCELED = "3";

    @Autowired
    private TaskItemMapper taskItemMapper;

    @Override
    public List<TaskItem> selectTaskList(TaskItem query)
    {
        List<TaskItem> roots = taskItemMapper.selectRootTaskList(query);
        if (roots.isEmpty())
        {
            return roots;
        }

        List<Long> rootIds = new ArrayList<Long>();
        for (TaskItem root : roots)
        {
            rootIds.add(root.getTaskId());
        }

        List<TaskItem> children = taskItemMapper.selectChildrenByParentIds(query.getOwnerUserId(), rootIds);
        Map<Long, List<TaskItem>> childrenByParent = new HashMap<Long, List<TaskItem>>();
        for (TaskItem child : children)
        {
            List<TaskItem> items = childrenByParent.get(child.getParentId());
            if (items == null)
            {
                items = new ArrayList<TaskItem>();
                childrenByParent.put(child.getParentId(), items);
            }
            items.add(child);
        }
        for (TaskItem root : roots)
        {
            List<TaskItem> items = childrenByParent.get(root.getTaskId());
            root.setChildren(items == null ? Collections.<TaskItem>emptyList() : items);
            root.setHasChildren(items != null && !items.isEmpty());
        }
        return roots;
    }

    @Override
    public TaskItem selectTaskById(Long taskId, Long ownerUserId)
    {
        TaskItem task = taskItemMapper.selectTaskById(taskId, ownerUserId);
        if (task == null)
        {
            throw new ServiceException("任务不存在或无权访问");
        }
        return task;
    }

    @Override
    public List<TaskItem> selectRootOptions(Long ownerUserId, Long excludeTaskId)
    {
        return taskItemMapper.selectRootOptions(ownerUserId, excludeTaskId);
    }

    @Override
    public TaskStatistics selectStatistics(Long ownerUserId)
    {
        TaskStatistics statistics = taskItemMapper.selectStatistics(ownerUserId, 7);
        return statistics == null ? new TaskStatistics() : statistics;
    }

    @Override
    @Transactional
    public int insertTask(TaskItem task)
    {
        normalizeAndValidate(task, null);
        int rows = taskItemMapper.insertTask(task);
        if (!ROOT_ID.equals(task.getParentId()))
        {
            recalculateParent(task.getParentId(), task.getOwnerUserId(), task.getCreateBy());
        }
        return rows;
    }

    @Override
    @Transactional
    public int updateTask(TaskItem task)
    {
        TaskItem existing = selectTaskById(task.getTaskId(), task.getOwnerUserId());
        Long oldParentId = existing.getParentId();
        normalizeAndValidate(task, existing);
        int rows = taskItemMapper.updateTask(task);

        if (!ROOT_ID.equals(oldParentId))
        {
            recalculateParent(oldParentId, task.getOwnerUserId(), task.getUpdateBy());
        }
        if (!ROOT_ID.equals(task.getParentId()) && !task.getParentId().equals(oldParentId))
        {
            recalculateParent(task.getParentId(), task.getOwnerUserId(), task.getUpdateBy());
        }
        if (ROOT_ID.equals(task.getParentId()) && taskItemMapper.countChildren(task.getTaskId(), task.getOwnerUserId()) > 0)
        {
            recalculateParent(task.getTaskId(), task.getOwnerUserId(), task.getUpdateBy());
        }
        return rows;
    }

    @Override
    @Transactional
    public int updateProgress(Long taskId, Integer progress, Long ownerUserId, String updateBy)
    {
        if (progress == null || progress < 0 || progress > 100)
        {
            throw new ServiceException("任务进度必须在0到100之间");
        }
        TaskItem task = selectTaskById(taskId, ownerUserId);
        if (taskItemMapper.countChildren(taskId, ownerUserId) > 0)
        {
            throw new ServiceException("存在未删除子任务时，进度由子任务自动汇总");
        }
        if (task.getTotalQuantity() != null && task.getTotalQuantity() > 0)
        {
            throw new ServiceException("已填写任务数量时，请修改已完成数量");
        }
        task.setProgress(progress);
        task.setUpdateBy(updateBy);
        normalizeStatus(task);
        int rows = taskItemMapper.updateTask(task);
        if (!ROOT_ID.equals(task.getParentId()))
        {
            recalculateParent(task.getParentId(), ownerUserId, updateBy);
        }
        return rows;
    }

    @Override
    @Transactional
    public int updateQuantity(Long taskId, Integer completedQuantity, Long ownerUserId, String updateBy)
    {
        if (completedQuantity == null || completedQuantity < 0)
        {
            throw new ServiceException("已完成数量不能小于0");
        }
        TaskItem task = selectTaskById(taskId, ownerUserId);
        if (taskItemMapper.countChildren(taskId, ownerUserId) > 0)
        {
            throw new ServiceException("存在未删除子任务时，进度由子任务自动汇总");
        }
        if (task.getTotalQuantity() == null || task.getTotalQuantity() <= 0)
        {
            throw new ServiceException("当前任务未设置任务总数量");
        }
        task.setCompletedQuantity(completedQuantity);
        task.setUpdateBy(updateBy);
        normalizeQuantity(task);
        normalizeStatus(task);
        int rows = taskItemMapper.updateTask(task);
        if (!ROOT_ID.equals(task.getParentId()))
        {
            recalculateParent(task.getParentId(), ownerUserId, updateBy);
        }
        return rows;
    }

    @Override
    @Transactional
    public int deleteTasks(Long[] taskIds, Long ownerUserId, String updateBy)
    {
        if (taskIds == null || taskIds.length == 0)
        {
            return 0;
        }
        List<TaskItem> tasks = taskItemMapper.selectTaskByIds(taskIds, ownerUserId);
        if (tasks.size() != taskIds.length)
        {
            throw new ServiceException("部分任务不存在或无权删除");
        }
        Set<Long> affectedParents = new HashSet<Long>();
        for (TaskItem task : tasks)
        {
            if (!ROOT_ID.equals(task.getParentId()))
            {
                affectedParents.add(task.getParentId());
            }
        }
        int rows = taskItemMapper.deleteTasks(taskIds, ownerUserId, updateBy);
        for (Long parentId : affectedParents)
        {
            recalculateParent(parentId, ownerUserId, updateBy);
        }
        return rows;
    }

    private void normalizeAndValidate(TaskItem task, TaskItem existing)
    {
        task.setParentId(task.getParentId() == null ? ROOT_ID : task.getParentId());
        if (task.getTaskId() != null && task.getTaskId().equals(task.getParentId()))
        {
            throw new ServiceException("上级任务不能选择自己");
        }
        if (!ROOT_ID.equals(task.getParentId()))
        {
            TaskItem parent = taskItemMapper.selectTaskById(task.getParentId(), task.getOwnerUserId());
            if (parent == null || !ROOT_ID.equals(parent.getParentId()))
            {
                throw new ServiceException("上级任务不存在或不能再挂子任务");
            }
            if (existing != null && ROOT_ID.equals(existing.getParentId())
                    && taskItemMapper.countChildren(existing.getTaskId(), task.getOwnerUserId()) > 0)
            {
                throw new ServiceException("已有子任务的主任务不能改为子任务");
            }
        }
        if (task.getPlanStartDate() != null && task.getDueDate() != null
                && task.getPlanStartDate().after(task.getDueDate()))
        {
            throw new ServiceException("截止日期不能早于计划开始日期");
        }
        task.setTaskName(task.getTaskName().trim());
        task.setDescription(StringUtils.isEmpty(task.getDescription()) ? null : task.getDescription().trim());
        task.setPriority(StringUtils.isEmpty(task.getPriority()) ? "1" : task.getPriority());
        task.setStatus(StringUtils.isEmpty(task.getStatus()) ? STATUS_TODO : task.getStatus());
        task.setProgress(task.getProgress() == null ? 0 : task.getProgress());
        task.setSort(task.getSort() == null ? 0 : task.getSort());
        normalizeQuantity(task);
        normalizeStatus(task);
    }

    private void normalizeQuantity(TaskItem task)
    {
        if (task.getTotalQuantity() == null || task.getTotalQuantity() <= 0)
        {
            task.setTotalQuantity(null);
            task.setCompletedQuantity(null);
            return;
        }
        int completed = task.getCompletedQuantity() == null ? 0 : task.getCompletedQuantity();
        if (completed > task.getTotalQuantity())
        {
            throw new ServiceException("已完成数量不能大于任务总数量");
        }
        task.setCompletedQuantity(completed);
        task.setProgress((int) Math.round(completed * 100.0D / task.getTotalQuantity()));
    }

    private void normalizeStatus(TaskItem task)
    {
        if (STATUS_CANCELED.equals(task.getStatus()))
        {
            task.setCompletedTime(null);
            return;
        }
        if (STATUS_COMPLETED.equals(task.getStatus()) || task.getProgress() >= 100)
        {
            task.setProgress(100);
            task.setStatus(STATUS_COMPLETED);
            if (task.getCompletedTime() == null)
            {
                task.setCompletedTime(DateUtils.getNowDate());
            }
            return;
        }
        task.setCompletedTime(null);
        if (task.getProgress() > 0 || STATUS_IN_PROGRESS.equals(task.getStatus()))
        {
            task.setStatus(STATUS_IN_PROGRESS);
        }
        else
        {
            task.setStatus(STATUS_TODO);
        }
    }

    private void recalculateParent(Long parentId, Long ownerUserId, String updateBy)
    {
        TaskItem parent = taskItemMapper.selectTaskById(parentId, ownerUserId);
        if (parent == null)
        {
            return;
        }
        Integer average = taskItemMapper.selectAverageChildProgress(parentId, ownerUserId);
        if (average == null)
        {
            return;
        }
        parent.setProgress(average);
        parent.setUpdateBy(updateBy);
        if (!STATUS_CANCELED.equals(parent.getStatus()))
        {
            normalizeStatus(parent);
        }
        taskItemMapper.updateCalculatedProgress(parent);
    }
}
