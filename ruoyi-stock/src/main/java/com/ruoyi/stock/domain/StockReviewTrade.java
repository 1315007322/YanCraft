package com.ruoyi.stock.domain;

import java.math.BigDecimal;
import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.common.xss.Xss;

/**
 * One trade or watch item under a daily review.
 */
public class StockReviewTrade extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long tradeId;

    private Long reviewId;

    private Long ownerUserId;

    private String stockCode;

    private String stockName;

    /** 0 buy, 1 sell, 2 watch */
    private String direction;

    private BigDecimal quantity;

    private BigDecimal price;

    private BigDecimal profitLoss;

    /** 0 planned, 1 chase, 2 hold, 3 take-profit, 4 stop-loss, 5 watch */
    private String resultTag;

    private String note;

    private Integer sort;

    private String delFlag;

    public Long getTradeId()
    {
        return tradeId;
    }

    public void setTradeId(Long tradeId)
    {
        this.tradeId = tradeId;
    }

    public Long getReviewId()
    {
        return reviewId;
    }

    public void setReviewId(Long reviewId)
    {
        this.reviewId = reviewId;
    }

    public Long getOwnerUserId()
    {
        return ownerUserId;
    }

    public void setOwnerUserId(Long ownerUserId)
    {
        this.ownerUserId = ownerUserId;
    }

    @Xss(message = "Stock code cannot contain script")
    public String getStockCode()
    {
        return stockCode;
    }

    public void setStockCode(String stockCode)
    {
        this.stockCode = stockCode;
    }

    @Xss(message = "Stock name cannot contain script")
    public String getStockName()
    {
        return stockName;
    }

    public void setStockName(String stockName)
    {
        this.stockName = stockName;
    }

    public String getDirection()
    {
        return direction;
    }

    public void setDirection(String direction)
    {
        this.direction = direction;
    }

    public BigDecimal getQuantity()
    {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity)
    {
        this.quantity = quantity;
    }

    public BigDecimal getPrice()
    {
        return price;
    }

    public void setPrice(BigDecimal price)
    {
        this.price = price;
    }

    public BigDecimal getProfitLoss()
    {
        return profitLoss;
    }

    public void setProfitLoss(BigDecimal profitLoss)
    {
        this.profitLoss = profitLoss;
    }

    public String getResultTag()
    {
        return resultTag;
    }

    public void setResultTag(String resultTag)
    {
        this.resultTag = resultTag;
    }

    public String getNote()
    {
        return note;
    }

    public void setNote(String note)
    {
        this.note = note;
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
}
