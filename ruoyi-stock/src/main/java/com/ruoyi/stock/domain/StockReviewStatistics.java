package com.ruoyi.stock.domain;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Monthly summary for the current user.
 */
public class StockReviewStatistics implements Serializable
{
    private static final long serialVersionUID = 1L;

    private Long reviewDays;

    private Long tradeDays;

    private BigDecimal profitLoss;

    private String topResultTag;

    public Long getReviewDays()
    {
        return reviewDays;
    }

    public void setReviewDays(Long reviewDays)
    {
        this.reviewDays = reviewDays;
    }

    public Long getTradeDays()
    {
        return tradeDays;
    }

    public void setTradeDays(Long tradeDays)
    {
        this.tradeDays = tradeDays;
    }

    public BigDecimal getProfitLoss()
    {
        return profitLoss;
    }

    public void setProfitLoss(BigDecimal profitLoss)
    {
        this.profitLoss = profitLoss;
    }

    public String getTopResultTag()
    {
        return topResultTag;
    }

    public void setTopResultTag(String topResultTag)
    {
        this.topResultTag = topResultTag;
    }
}
