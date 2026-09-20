package com.ruoyi.blog.domain;

/**
 * Extra top-level nav item stored in site setting JSON.
 *
 * @author ruoyi
 */
public class CmsNavLink
{
    private String name;
    private String url;
    /** 0 new window, 1 same tab */
    private String openInNew;
    private Integer sort;
    /** 0 show, 1 hide */
    private String enabled;

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getUrl()
    {
        return url;
    }

    public void setUrl(String url)
    {
        this.url = url;
    }

    public String getOpenInNew()
    {
        return openInNew;
    }

    public void setOpenInNew(String openInNew)
    {
        this.openInNew = openInNew;
    }

    public Integer getSort()
    {
        return sort;
    }

    public void setSort(Integer sort)
    {
        this.sort = sort;
    }

    public String getEnabled()
    {
        return enabled;
    }

    public void setEnabled(String enabled)
    {
        this.enabled = enabled;
    }
}
