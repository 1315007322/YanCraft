package com.ruoyi.stock.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.validation.Valid;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * One daily review for the current user.
 */
public class StockReview extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long reviewId;

    private Long ownerUserId;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date reviewDate;

    /** 0 calm, 1 optimistic, 2 cautious, 3 chase, 4 panic */
    private String mood;

    private Integer score;

    private String conclusion;

    private String mistake;

    private String nextPlan;

    private String delFlag;

    private String keyword;

    private String resultTag;

    private Integer tradeCount;

    @Valid
    private List<StockReviewTrade> trades = new ArrayList<StockReviewTrade>();

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

    public Date getReviewDate()
    {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate)
    {
        this.reviewDate = reviewDate;
    }

    public String getMood()
    {
        return mood;
    }

    public void setMood(String mood)
    {
        this.mood = mood;
    }

    public Integer getScore()
    {
        return score;
    }

    public void setScore(Integer score)
    {
        this.score = score;
    }

    public String getConclusion()
    {
        return conclusion;
    }

    public void setConclusion(String conclusion)
    {
        this.conclusion = conclusion;
    }

    public String getMistake()
    {
        return mistake;
    }

    public void setMistake(String mistake)
    {
        this.mistake = mistake;
    }

    public String getNextPlan()
    {
        return nextPlan;
    }

    public void setNextPlan(String nextPlan)
    {
        this.nextPlan = nextPlan;
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

    public String getResultTag()
    {
        return resultTag;
    }

    public void setResultTag(String resultTag)
    {
        this.resultTag = resultTag;
    }

    public Integer getTradeCount()
    {
        return tradeCount;
    }

    public void setTradeCount(Integer tradeCount)
    {
        this.tradeCount = tradeCount;
    }

    public List<StockReviewTrade> getTrades()
    {
        return trades;
    }

    public void setTrades(List<StockReviewTrade> trades)
    {
        this.trades = trades;
    }
}
