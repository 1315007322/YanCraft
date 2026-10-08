package com.ruoyi.task.service;

import static org.junit.Assert.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.task.domain.TaskItem;
import com.ruoyi.task.mapper.TaskItemMapper;
import com.ruoyi.task.service.impl.TaskItemServiceImpl;

/**
 * Core task hierarchy and progress rules.
 */
@RunWith(MockitoJUnitRunner.class)
public class TaskItemServiceImplTest
{
    @Mock
    private TaskItemMapper taskItemMapper;

    @InjectMocks
    private TaskItemServiceImpl taskItemService;

    private TaskItem root;

    @Before
    public void setUp()
    {
        root = task(10L, 0L, 1L, 0);
    }

    @Test
    public void shouldRecalculateParentAfterChildInsert()
    {
        TaskItem child = task(null, 10L, 1L, 60);
        child.setCreateBy("admin");
        when(taskItemMapper.selectTaskById(10L, 1L)).thenReturn(root);
        when(taskItemMapper.insertTask(any(TaskItem.class))).thenReturn(1);
        when(taskItemMapper.selectAverageChildProgress(10L, 1L)).thenReturn(60);

        assertEquals(1, taskItemService.insertTask(child));

        ArgumentCaptor<TaskItem> captor = ArgumentCaptor.forClass(TaskItem.class);
        verify(taskItemMapper).updateCalculatedProgress(captor.capture());
        assertEquals(Integer.valueOf(60), captor.getValue().getProgress());
        assertEquals("1", captor.getValue().getStatus());
    }

    @Test(expected = ServiceException.class)
    public void shouldRejectGrandchild()
    {
        TaskItem nonRootParent = task(20L, 10L, 1L, 0);
        TaskItem child = task(null, 20L, 1L, 0);
        when(taskItemMapper.selectTaskById(20L, 1L)).thenReturn(nonRootParent);

        taskItemService.insertTask(child);
    }

    @Test(expected = ServiceException.class)
    public void shouldRejectManualProgressForParentWithChildren()
    {
        when(taskItemMapper.selectTaskById(10L, 1L)).thenReturn(root);
        when(taskItemMapper.countChildren(10L, 1L)).thenReturn(2);

        taskItemService.updateProgress(10L, 50, 1L, "admin");
    }

    @Test
    public void shouldDeriveProgressFromQuantity()
    {
        TaskItem course = task(null, 0L, 1L, 0);
        course.setTaskName("Course");
        course.setCreateBy("admin");
        course.setTotalQuantity(100);
        course.setCompletedQuantity(21);
        when(taskItemMapper.insertTask(any(TaskItem.class))).thenReturn(1);

        assertEquals(1, taskItemService.insertTask(course));
        assertEquals(Integer.valueOf(21), course.getProgress());
        assertEquals("1", course.getStatus());
    }

    @Test(expected = ServiceException.class)
    public void shouldRejectManualProgressWhenQuantityExists()
    {
        root.setTotalQuantity(100);
        root.setCompletedQuantity(21);
        when(taskItemMapper.selectTaskById(10L, 1L)).thenReturn(root);
        when(taskItemMapper.countChildren(10L, 1L)).thenReturn(0);

        taskItemService.updateProgress(10L, 50, 1L, "admin");
    }

    @Test(expected = ServiceException.class)
    public void shouldRejectCompletedGreaterThanTotal()
    {
        TaskItem course = task(null, 0L, 1L, 0);
        course.setTotalQuantity(10);
        course.setCompletedQuantity(21);
        taskItemService.insertTask(course);
    }

    private TaskItem task(Long taskId, Long parentId, Long ownerUserId, int progress)
    {
        TaskItem task = new TaskItem();
        task.setTaskId(taskId);
        task.setParentId(parentId);
        task.setOwnerUserId(ownerUserId);
        task.setTaskName("Task");
        task.setStatus("0");
        task.setPriority("1");
        task.setProgress(progress);
        task.setSort(0);
        return task;
    }
}
