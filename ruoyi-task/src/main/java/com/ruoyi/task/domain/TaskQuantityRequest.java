package com.ruoyi.task.domain;

import java.io.Serializable;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

/**
 * Quick completed quantity update request.
 */
public class TaskQuantityRequest implements Serializable
{
    private static final long serialVersionUID = 1L;

    @NotNull(message = "已完成数量不能为空")
    @Min(value = 0, message = "已完成数量不能小于0")
    private Integer completedQuantity;

    public Integer getCompletedQuantity()
    {
        return completedQuantity;
    }

    public void setCompletedQuantity(Integer completedQuantity)
    {
        this.completedQuantity = completedQuantity;
    }
}
