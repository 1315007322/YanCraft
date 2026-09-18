package com.ruoyi.blog.domain;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.common.xss.Xss;

/**
 * 博客标签 cms_tag
 *
 * @author ruoyi
 */
public class CmsTag extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 标签ID */
    private Long tagId;

    /** 标签名称 */
    private String name;

    /** 访问标识 */
    private String slug;

    /** 删除标志（0存在 2删除） */
    private String delFlag;

    public Long getTagId()
    {
        return tagId;
    }

    public void setTagId(Long tagId)
    {
        this.tagId = tagId;
    }

    @Xss(message = "标签名称不能包含脚本字符")
    @NotBlank(message = "标签名称不能为空")
    @Size(min = 0, max = 50, message = "标签名称不能超过50个字符")
    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    @Size(min = 0, max = 80, message = "访问标识不能超过80个字符")
    public String getSlug()
    {
        return slug;
    }

    public void setSlug(String slug)
    {
        this.slug = slug;
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
