package com.ruoyi.blog.domain;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.common.xss.Xss;

/**
 * 博客分类 cms_category
 *
 * @author ruoyi
 */
public class CmsCategory extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 分类ID */
    private Long categoryId;

    /** 父分类ID，首版扁平使用 0 */
    private Long parentId;

    /** 分类名称 */
    private String name;

    /** 访问标识 */
    private String slug;

    /** 显示顺序 */
    private Integer sort;

    /** 状态（0正常 1停用） */
    private String status;

    /** 删除标志（0存在 2删除） */
    private String delFlag;

    public Long getCategoryId()
    {
        return categoryId;
    }

    public void setCategoryId(Long categoryId)
    {
        this.categoryId = categoryId;
    }

    public Long getParentId()
    {
        return parentId;
    }

    public void setParentId(Long parentId)
    {
        this.parentId = parentId;
    }

    @Xss(message = "分类名称不能包含脚本字符")
    @NotBlank(message = "分类名称不能为空")
    @Size(min = 0, max = 50, message = "分类名称不能超过50个字符")
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
