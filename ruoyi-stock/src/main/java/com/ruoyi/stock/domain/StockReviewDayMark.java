package com.ruoyi.stock.domain;

import java.io.Serializable;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * Calendar mark for a day that already has a review.
 */
public class StockReviewDayMark implements Serializable
{
    private static final long serialVersionUID = 1L;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date reviewDate;

    private Integer tradeCount;

    public Date getReviewDate()
    {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate)
    {
        this.reviewDate = reviewDate;
    }

    public Integer getTradeCount()
    {
        return tradeCount;
    }

    public void setTradeCount(Integer tradeCount)
    {
        this.tradeCount = tradeCount;
    }
}
