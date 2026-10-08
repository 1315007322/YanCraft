package com.ruoyi.stock.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.common.xss.Xss;

/**
 * Review markdown template. ownerUserId 0 is system-wide.
 */
public class StockReviewTemplate extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    public static final Long SYSTEM_OWNER_ID = 0L;

    private Long templateId;

    private Long ownerUserId;

    private String templateCode;

    private String templateName;

    private String summary;

    private String mood;

    private Integer score;

    private String conclusion;

    private String mistake;

    private String nextPlan;

    private Integer sort;

    private String delFlag;

    private Boolean systemTemplate;

    public Long getTemplateId()
    {
        return templateId;
    }

    public void setTemplateId(Long templateId)
    {
        this.templateId = templateId;
    }

    public Long getOwnerUserId()
    {
        return ownerUserId;
    }

    public void setOwnerUserId(Long ownerUserId)
    {
        this.ownerUserId = ownerUserId;
    }

    public String getTemplateCode()
    {
        return templateCode;
    }

    public void setTemplateCode(String templateCode)
    {
        this.templateCode = templateCode;
    }

    @Xss(message = "Template name cannot contain script")
    public String getTemplateName()
    {
        return templateName;
    }

    public void setTemplateName(String templateName)
    {
        this.templateName = templateName;
    }

    public String getSummary()
    {
        return summary;
    }

    public void setSummary(String summary)
    {
        this.summary = summary;
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

    public Boolean getSystemTemplate()
    {
        if (systemTemplate != null)
        {
            return systemTemplate;
        }
        return SYSTEM_OWNER_ID.equals(ownerUserId);
    }

    public void setSystemTemplate(Boolean systemTemplate)
    {
        this.systemTemplate = systemTemplate;
    }
}
