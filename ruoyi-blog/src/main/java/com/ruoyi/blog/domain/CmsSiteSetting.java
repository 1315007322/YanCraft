package com.ruoyi.blog.domain;

import java.util.List;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

/**
 * Aggregated site settings for the admin form and portal.
 *
 * @author ruoyi
 */
public class CmsSiteSetting
{
    @NotBlank(message = "\u7ad9\u70b9\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a")
    @Size(max = 50)
    private String siteName;

    @Size(max = 40)
    private String logoPrefix;

    @Size(max = 40)
    private String logoHighlight;

    @Size(max = 200)
    private String tagline;

    @Size(max = 64)
    private String author;

    @Size(max = 200)
    private String authorSignature;

    @Size(max = 255)
    private String avatarUrl;

    @Size(max = 8)
    private String avatarLetter;

    @Size(max = 200)
    private String footerText;

    @Size(max = 100)
    private String beianText;

    @Size(max = 255)
    private String beianUrl;

    @Size(max = 255)
    private String siteUrl;

    @Size(max = 50)
    private String aboutTitle;

    private String aboutContent;

    /** 0 show, 1 hide */
    private String aboutEnabled;

    private String searchEnabled;

    private String categoryEnabled;

    private String friendLinkEnabled;

    private String labEnabled;

    @Min(1)
    @Max(50)
    private Integer hotLimit;

    @Min(1)
    @Max(50)
    private Integer homePageSize;

    private List<CmsNavLink> extraNavLinks;

    @Size(max = 32)
    private String themeId;

    public String getSiteName()
    {
        return siteName;
    }

    public void setSiteName(String siteName)
    {
        this.siteName = siteName;
    }

    public String getLogoPrefix()
    {
        return logoPrefix;
    }

    public void setLogoPrefix(String logoPrefix)
    {
        this.logoPrefix = logoPrefix;
    }

    public String getLogoHighlight()
    {
        return logoHighlight;
    }

    public void setLogoHighlight(String logoHighlight)
    {
        this.logoHighlight = logoHighlight;
    }

    public String getTagline()
    {
        return tagline;
    }

    public void setTagline(String tagline)
    {
        this.tagline = tagline;
    }

    public String getAuthor()
    {
        return author;
    }

    public void setAuthor(String author)
    {
        this.author = author;
    }

    public String getAuthorSignature()
    {
        return authorSignature;
    }

    public void setAuthorSignature(String authorSignature)
    {
        this.authorSignature = authorSignature;
    }

    public String getAvatarUrl()
    {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl)
    {
        this.avatarUrl = avatarUrl;
    }

    public String getAvatarLetter()
    {
        return avatarLetter;
    }

    public void setAvatarLetter(String avatarLetter)
    {
        this.avatarLetter = avatarLetter;
    }

    public String getFooterText()
    {
        return footerText;
    }

    public void setFooterText(String footerText)
    {
        this.footerText = footerText;
    }

    public String getBeianText()
    {
        return beianText;
    }

    public void setBeianText(String beianText)
    {
        this.beianText = beianText;
    }

    public String getBeianUrl()
    {
        return beianUrl;
    }

    public void setBeianUrl(String beianUrl)
    {
        this.beianUrl = beianUrl;
    }

    public String getSiteUrl()
    {
        return siteUrl;
    }

    public void setSiteUrl(String siteUrl)
    {
        this.siteUrl = siteUrl;
    }

    public String getAboutTitle()
    {
        return aboutTitle;
    }

    public void setAboutTitle(String aboutTitle)
    {
        this.aboutTitle = aboutTitle;
    }

    public String getAboutContent()
    {
        return aboutContent;
    }

    public void setAboutContent(String aboutContent)
    {
        this.aboutContent = aboutContent;
    }

    public String getAboutEnabled()
    {
        return aboutEnabled;
    }

    public void setAboutEnabled(String aboutEnabled)
    {
        this.aboutEnabled = aboutEnabled;
    }

    public String getSearchEnabled()
    {
        return searchEnabled;
    }

    public void setSearchEnabled(String searchEnabled)
    {
        this.searchEnabled = searchEnabled;
    }

    public String getCategoryEnabled()
    {
        return categoryEnabled;
    }

    public void setCategoryEnabled(String categoryEnabled)
    {
        this.categoryEnabled = categoryEnabled;
    }

    public String getFriendLinkEnabled()
    {
        return friendLinkEnabled;
    }

    public void setFriendLinkEnabled(String friendLinkEnabled)
    {
        this.friendLinkEnabled = friendLinkEnabled;
    }

    public String getLabEnabled()
    {
        return labEnabled;
    }

    public void setLabEnabled(String labEnabled)
    {
        this.labEnabled = labEnabled;
    }

    public Integer getHotLimit()
    {
        return hotLimit;
    }

    public void setHotLimit(Integer hotLimit)
    {
        this.hotLimit = hotLimit;
    }

    public Integer getHomePageSize()
    {
        return homePageSize;
    }

    public void setHomePageSize(Integer homePageSize)
    {
        this.homePageSize = homePageSize;
    }

    public List<CmsNavLink> getExtraNavLinks()
    {
        return extraNavLinks;
    }

    public void setExtraNavLinks(List<CmsNavLink> extraNavLinks)
    {
        this.extraNavLinks = extraNavLinks;
    }

    public String getThemeId()
    {
        return themeId;
    }

    public void setThemeId(String themeId)
    {
        this.themeId = themeId;
    }
}
