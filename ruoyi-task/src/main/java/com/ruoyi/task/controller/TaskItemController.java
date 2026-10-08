package com.ruoyi.task.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.task.domain.TaskItem;
import com.ruoyi.task.domain.TaskProgressRequest;
import com.ruoyi.task.domain.TaskQuantityRequest;
import com.ruoyi.task.service.ITaskItemService;

/**
 * Personal task management.
 */
@RestController
@RequestMapping("/task/item")
public class TaskItemController extends BaseController
{
    @Autowired
    private ITaskItemService taskItemService;

    @PreAuthorize("@ss.hasPermi('task:item:list')")
    @GetMapping("/list")
    public TableDataInfo list(TaskItem query)
    {
        query.setOwnerUserId(getUserId());
        startPage();
        List<TaskItem> list = taskItemService.selectTaskList(query);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('task:item:query')")
    @GetMapping("/statistics")
    public AjaxResult statistics()
    {
        return success(taskItemService.selectStatistics(getUserId()));
    }

    @PreAuthorize("@ss.hasPermi('task:item:query')")
    @GetMapping("/root-options")
    public AjaxResult rootOptions(@RequestParam(required = false) Long excludeTaskId)
    {
        return success(taskItemService.selectRootOptions(getUserId(), excludeTaskId));
    }

    @PreAuthorize("@ss.hasPermi('task:item:query')")
    @GetMapping("/{taskId}")
    public AjaxResult getInfo(@PathVariable Long taskId)
    {
        return success(taskItemService.selectTaskById(taskId, getUserId()));
    }

    @PreAuthorize("@ss.hasPermi('task:item:add')")
    @Log(title = "Personal Task", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody TaskItem task)
    {
        task.setOwnerUserId(getUserId());
        task.setCreateBy(getUsername());
        return toAjax(taskItemService.insertTask(task));
    }

    @PreAuthorize("@ss.hasPermi('task:item:edit')")
    @Log(title = "Personal Task", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody TaskItem task)
    {
        task.setOwnerUserId(getUserId());
        task.setUpdateBy(getUsername());
        return toAjax(taskItemService.updateTask(task));
    }

    @PreAuthorize("@ss.hasPermi('task:item:edit')")
    @Log(title = "Personal Task Progress", businessType = BusinessType.UPDATE)
    @PutMapping("/{taskId}/progress")
    public AjaxResult updateProgress(@PathVariable Long taskId,
            @Validated @RequestBody TaskProgressRequest request)
    {
        return toAjax(taskItemService.updateProgress(taskId, request.getProgress(), getUserId(), getUsername()));
    }

    @PreAuthorize("@ss.hasPermi('task:item:edit')")
    @Log(title = "Personal Task Quantity", businessType = BusinessType.UPDATE)
    @PutMapping("/{taskId}/quantity")
    public AjaxResult updateQuantity(@PathVariable Long taskId,
            @Validated @RequestBody TaskQuantityRequest request)
    {
        return toAjax(taskItemService.updateQuantity(taskId, request.getCompletedQuantity(), getUserId(), getUsername()));
    }

    @PreAuthorize("@ss.hasPermi('task:item:remove')")
    @Log(title = "Personal Task", businessType = BusinessType.DELETE)
    @DeleteMapping("/{taskIds}")
    public AjaxResult remove(@PathVariable Long[] taskIds)
    {
        return toAjax(taskItemService.deleteTasks(taskIds, getUserId(), getUsername()));
    }
}
