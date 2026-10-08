package com.ruoyi.task.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.task.domain.TaskItem;
import com.ruoyi.task.domain.TaskStatistics;

/**
 * Personal task mapper.
 */
public interface TaskItemMapper
{
    List<TaskItem> selectRootTaskList(TaskItem query);

    List<TaskItem> selectChildrenByParentIds(@Param("ownerUserId") Long ownerUserId,
            @Param("parentIds") List<Long> parentIds);

    TaskItem selectTaskById(@Param("taskId") Long taskId, @Param("ownerUserId") Long ownerUserId);

    List<TaskItem> selectTaskByIds(@Param("taskIds") Long[] taskIds, @Param("ownerUserId") Long ownerUserId);

    List<TaskItem> selectRootOptions(@Param("ownerUserId") Long ownerUserId, @Param("excludeTaskId") Long excludeTaskId);

    int countChildren(@Param("taskId") Long taskId, @Param("ownerUserId") Long ownerUserId);

    Integer selectAverageChildProgress(@Param("taskId") Long taskId, @Param("ownerUserId") Long ownerUserId);

    int insertTask(TaskItem task);

    int updateTask(TaskItem task);

    int updateCalculatedProgress(TaskItem task);

    int deleteTasks(@Param("taskIds") Long[] taskIds, @Param("ownerUserId") Long ownerUserId,
            @Param("updateBy") String updateBy);

    TaskStatistics selectStatistics(@Param("ownerUserId") Long ownerUserId,
            @Param("upcomingDays") Integer upcomingDays);
}
