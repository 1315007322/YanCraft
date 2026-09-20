package com.ruoyi.blog.domain;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.common.xss.Xss;

/**
 * Blog friend link cms_friend_link
 *
 * @author ruoyi
 */
public class CmsFriendLink extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long linkId;

    private String nickname;

    private String description;

    private String siteUrl;

    private Integer sort;

    /** 0 enabled, 1 disabled */
    private String status;

    private String delFlag;

    public Long getLinkId()
    {
        return linkId;
    }

    public void setLinkId(Long linkId)
    {
        this.linkId = linkId;
    }

    @Xss(message = "\u6635\u79f0\u4e0d\u80fd\u5305\u542b\u811a\u672c\u5b57\u7b26")
    @NotBlank(message = "\u6635\u79f0\u4e0d\u80fd\u4e3a\u7a7a")
    @Size(min = 0, max = 50, message = "\u6635\u79f0\u4e0d\u80fd\u8d85\u8fc750\u4e2a\u5b57\u7b26")
    public String getNickname()
    {
        return nickname;
    }

    public void setNickname(String nickname)
    {
        this.nickname = nickname;
    }

    @Xss(message = "\u63cf\u8ff0\u4e0d\u80fd\u5305\u542b\u811a\u672c\u5b57\u7b26")
    @Size(min = 0, max = 200, message = "\u63cf\u8ff0\u4e0d\u80fd\u8d85\u8fc7200\u4e2a\u5b57\u7b26")
    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    @NotBlank(message = "\u7f51\u7ad9\u5730\u5740\u4e0d\u80fd\u4e3a\u7a7a")
    @Size(min = 0, max = 255, message = "\u7f51\u7ad9\u5730\u5740\u4e0d\u80fd\u8d85\u8fc7255\u4e2a\u5b57\u7b26")
    @Pattern(regexp = "^https?://.+$", message = "\u7f51\u7ad9\u5730\u5740\u9700\u4ee5 http:// \u6216 https:// \u5f00\u5934")
    public String getSiteUrl()
    {
        return siteUrl;
    }

    public void setSiteUrl(String siteUrl)
    {
        this.siteUrl = siteUrl;
    }

    public Integer getSort()
    {
        return sort;
    }

    public void setSort(Integer sort)
    {
        this.sort = sort;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
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
