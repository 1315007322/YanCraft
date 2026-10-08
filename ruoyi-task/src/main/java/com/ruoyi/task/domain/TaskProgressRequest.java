package com.ruoyi.task.domain;

import java.io.Serializable;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

/**
 * Quick task progress update request.
 */
public class TaskProgressRequest implements Serializable
{
    private static final long serialVersionUID = 1L;

    @NotNull(message = "任务进度不能为空")
    @Min(value = 0, message = "任务进度不能小于0")
    @Max(value = 100, message = "任务进度不能大于100")
    private Integer progress;

    public Integer getProgress()
    {
        return progress;
    }

    public void setProgress(Integer progress)
    {
        this.progress = progress;
    }
}
