package com.ruoyi.task.service;

import java.util.List;
import com.ruoyi.task.domain.TaskItem;
import com.ruoyi.task.domain.TaskStatistics;

/**
 * Personal task service.
 */
public interface ITaskItemService
{
    List<TaskItem> selectTaskList(TaskItem query);

    TaskItem selectTaskById(Long taskId, Long ownerUserId);

    List<TaskItem> selectRootOptions(Long ownerUserId, Long excludeTaskId);

    TaskStatistics selectStatistics(Long ownerUserId);

    int insertTask(TaskItem task);

    int updateTask(TaskItem task);

    int updateProgress(Long taskId, Integer progress, Long ownerUserId, String updateBy);

    int updateQuantity(Long taskId, Integer completedQuantity, Long ownerUserId, String updateBy);

    int deleteTasks(Long[] taskIds, Long ownerUserId, String updateBy);
}
