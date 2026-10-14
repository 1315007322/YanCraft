package com.ruoyi.exam.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * One verbal distinction the owner wants to recall.
 */
public class ExamVerbalCard extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long cardId;

    private Long ownerUserId;

    /** 0 word, 1 linker, 2 gist */
    private String cardType;

    private String prompt;

    private String difference;

    private String collocation;

    private String confusion;

    private String ownSentence;

    private Integer intervalDays;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date dueDate;

    private Integer reviewCount;

    private String delFlag;

    private String keyword;

    /** 1 when pushed back from today's deck */
    private String missed;

    public String getMissed()
    {
        return missed;
    }

    public void setMissed(String missed)
    {
        this.missed = missed;
    }

    public Long getCardId()
    {
        return cardId;
    }

    public void setCardId(Long cardId)
    {
        this.cardId = cardId;
    }

    public Long getOwnerUserId()
    {
        return ownerUserId;
    }

    public void setOwnerUserId(Long ownerUserId)
    {
        this.ownerUserId = ownerUserId;
    }

    public String getCardType()
    {
        return cardType;
    }

    public void setCardType(String cardType)
    {
        this.cardType = cardType;
    }

    public String getPrompt()
    {
        return prompt;
    }

    public void setPrompt(String prompt)
    {
        this.prompt = prompt;
    }

    public String getDifference()
    {
        return difference;
    }

    public void setDifference(String difference)
    {
        this.difference = difference;
    }

    public String getCollocation()
    {
        return collocation;
    }

    public void setCollocation(String collocation)
    {
        this.collocation = collocation;
    }

    public String getConfusion()
    {
        return confusion;
    }

    public void setConfusion(String confusion)
    {
        this.confusion = confusion;
    }

    public String getOwnSentence()
    {
        return ownSentence;
    }

    public void setOwnSentence(String ownSentence)
    {
        this.ownSentence = ownSentence;
    }

    public Integer getIntervalDays()
    {
        return intervalDays;
    }

    public void setIntervalDays(Integer intervalDays)
    {
        this.intervalDays = intervalDays;
    }

    public Date getDueDate()
    {
        return dueDate;
    }

    public void setDueDate(Date dueDate)
    {
        this.dueDate = dueDate;
    }

    public Integer getReviewCount()
    {
        return reviewCount;
    }

    public void setReviewCount(Integer reviewCount)
    {
        this.reviewCount = reviewCount;
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
}
