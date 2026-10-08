package com.ruoyi.blog.domain;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.common.xss.Xss;

/**
 * 实验室项目 cms_lab_project
 *
 * @author ruoyi
 */
public class CmsLabProject extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long projectId;

    private String projectName;

    private String description;

    private String repoUrl;

    private String previewUrl;

    private String cover;

    private Integer sort;

    /** 0 启用 1 停用 */
    private String status;

    private String delFlag;

    public Long getProjectId()
    {
        return projectId;
    }

    public void setProjectId(Long projectId)
    {
        this.projectId = projectId;
    }

    @Xss(message = "项目名称不能包含脚本字符")
    @NotBlank(message = "项目名称不能为空")
    @Size(min = 0, max = 100, message = "项目名称不能超过100个字符")
    public String getProjectName()
    {
        return projectName;
    }

    public void setProjectName(String projectName)
    {
        this.projectName = projectName;
    }

    @Xss(message = "项目描述不能包含脚本字符")
    @Size(min = 0, max = 500, message = "项目描述不能超过500个字符")
    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    @NotBlank(message = "仓库地址不能为空")
    @Size(min = 0, max = 500, message = "仓库地址不能超过500个字符")
    @Pattern(regexp = "^https?://.+$", message = "仓库地址需以 http:// 或 https:// 开头")
    public String getRepoUrl()
    {
        return repoUrl;
    }

    public void setRepoUrl(String repoUrl)
    {
        this.repoUrl = repoUrl;
    }

    @Size(min = 0, max = 500, message = "预览地址不能超过500个字符")
    @Pattern(regexp = "^$|^https?://.+$", message = "预览地址需以 http:// 或 https:// 开头")
    public String getPreviewUrl()
    {
        return previewUrl;
    }

    public void setPreviewUrl(String previewUrl)
    {
        this.previewUrl = previewUrl;
    }

    @Size(min = 0, max = 500, message = "封面地址不能超过500个字符")
    public String getCover()
    {
        return cover;
    }

    public void setCover(String cover)
    {
        this.cover = cover;
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
