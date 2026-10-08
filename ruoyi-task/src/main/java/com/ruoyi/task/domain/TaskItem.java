package com.ruoyi.task.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.common.xss.Xss;

/**
 * Personal task item.
 */
public class TaskItem extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long taskId;

    private Long parentId;

    private Long ownerUserId;

    private String taskName;

    private String description;

    /** 0 todo, 1 in progress, 2 completed, 3 canceled */
    private String status;

    /** 0 low, 1 normal, 2 high, 3 urgent */
    private String priority;

    private Integer progress;

    private Integer totalQuantity;

    private Integer completedQuantity;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date planStartDate;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date dueDate;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date completedTime;

    private Integer sort;

    private String delFlag;

    private String keyword;

    private Boolean overdue;

    private Boolean hasChildren;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private List<TaskItem> children = new ArrayList<TaskItem>();

    public Long getTaskId()
    {
        return taskId;
    }

    public void setTaskId(Long taskId)
    {
        this.taskId = taskId;
    }

    public Long getParentId()
    {
        return parentId;
    }

    public void setParentId(Long parentId)
    {
        this.parentId = parentId;
    }

    public Long getOwnerUserId()
    {
        return ownerUserId;
    }

    public void setOwnerUserId(Long ownerUserId)
    {
        this.ownerUserId = ownerUserId;
    }

    @Xss(message = "任务名称不能包含脚本字符")
    @NotBlank(message = "任务名称不能为空")
    @Size(max = 120, message = "任务名称不能超过120个字符")
    public String getTaskName()
    {
        return taskName;
    }

    public void setTaskName(String taskName)
    {
        this.taskName = taskName;
    }

    @Xss(message = "任务描述不能包含脚本字符")
    @Size(max = 1000, message = "任务描述不能超过1000个字符")
    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    @Pattern(regexp = "^[0-3]$", message = "任务状态不正确")
    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    @Pattern(regexp = "^[0-3]$", message = "任务优先级不正确")
    public String getPriority()
    {
        return priority;
    }

    public void setPriority(String priority)
    {
        this.priority = priority;
    }

    @Min(value = 0, message = "任务进度不能小于0")
    @Max(value = 100, message = "任务进度不能大于100")
    public Integer getProgress()
    {
        return progress;
    }

    public void setProgress(Integer progress)
    {
        this.progress = progress;
    }

    @Min(value = 0, message = "任务总数量不能小于0")
    public Integer getTotalQuantity()
    {
        return totalQuantity;
    }

    public void setTotalQuantity(Integer totalQuantity)
    {
        this.totalQuantity = totalQuantity;
    }

    @Min(value = 0, message = "已完成数量不能小于0")
    public Integer getCompletedQuantity()
    {
        return completedQuantity;
    }

    public void setCompletedQuantity(Integer completedQuantity)
    {
        this.completedQuantity = completedQuantity;
    }

    public Date getPlanStartDate()
    {
        return planStartDate;
    }

    public void setPlanStartDate(Date planStartDate)
    {
        this.planStartDate = planStartDate;
    }

    public Date getDueDate()
    {
        return dueDate;
    }

    public void setDueDate(Date dueDate)
    {
        this.dueDate = dueDate;
    }

    public Date getCompletedTime()
    {
        return completedTime;
    }

    public void setCompletedTime(Date completedTime)
    {
        this.completedTime = completedTime;
    }

    public Integer getSort()
    {
        return sort;
    }

    public void setSort(Integer sort)
    {
        this.sort = sort;
    }

    public String getDelFlag()
    {
        return delFlag;
    }

    public void setDelFlag(String delFlag)
    {
        this.delFlag = delFlag;
    }

    public String getKeyword()
    {
        return keyword;
    }

    public void setKeyword(String keyword)
    {
        this.keyword = keyword;
    }

    public Boolean getOverdue()
    {
        return overdue;
    }

    public void setOverdue(Boolean overdue)
    {
        this.overdue = overdue;
    }

    public Boolean getHasChildren()
    {
        return hasChildren;
    }

    public void setHasChildren(Boolean hasChildren)
    {
        this.hasChildren = hasChildren;
    }

    public List<TaskItem> getChildren()
    {
        return children;
    }

    public void setChildren(List<TaskItem> children)
    {
        this.children = children;
    }
}
