package com.ruoyi.task.domain;

import java.io.Serializable;

/**
 * Current user's task summary.
 */
public class TaskStatistics implements Serializable
{
    private static final long serialVersionUID = 1L;

    private Long total;

    private Long inProgress;

    private Long upcoming;

    private Long overdue;

    private Long completed;

    public Long getTotal()
    {
        return total;
    }

    public void setTotal(Long total)
    {
        this.total = total;
    }

    public Long getInProgress()
    {
        return inProgress;
    }

    public void setInProgress(Long inProgress)
    {
        this.inProgress = inProgress;
    }

    public Long getUpcoming()
    {
        return upcoming;
    }

    public void setUpcoming(Long upcoming)
    {
        this.upcoming = upcoming;
    }

    public Long getOverdue()
    {
        return overdue;
    }

    public void setOverdue(Long overdue)
    {
        this.overdue = overdue;
    }

    public Long getCompleted()
    {
        return completed;
    }

    public void setCompleted(Long completed)
    {
        this.completed = completed;
    }
}
