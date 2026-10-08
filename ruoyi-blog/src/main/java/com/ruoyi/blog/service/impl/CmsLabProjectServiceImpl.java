package com.ruoyi.blog.service.impl;

import java.util.List;
import com.ruoyi.blog.constant.CmsConstants;
import com.ruoyi.blog.domain.CmsLabProject;
import com.ruoyi.blog.mapper.CmsLabProjectMapper;
import com.ruoyi.blog.service.ICmsLabProjectService;
import com.ruoyi.common.utils.StringUtils;

/**
 * 实验室项目
 *
 * @author ruoyi
 */
public class CmsLabProjectServiceImpl implements ICmsLabProjectService
{
    private final CmsLabProjectMapper labProjectMapper;

    public CmsLabProjectServiceImpl(CmsLabProjectMapper labProjectMapper)
    {
        this.labProjectMapper = labProjectMapper;
    }

    @Override
    public CmsLabProject selectLabProjectById(Long projectId)
    {
        return labProjectMapper.selectLabProjectById(projectId);
    }

    @Override
    public List<CmsLabProject> selectLabProjectList(CmsLabProject project)
    {
        return labProjectMapper.selectLabProjectList(project);
    }

    @Override
    public int insertLabProject(CmsLabProject project)
    {
        prepare(project);
        if (StringUtils.isEmpty(project.getStatus()))
        {
            project.setStatus(CmsConstants.STATUS_OK);
        }
        if (project.getSort() == null)
        {
            project.setSort(0);
        }
        return labProjectMapper.insertLabProject(project);
    }

    @Override
    public int updateLabProject(CmsLabProject project)
    {
        prepare(project);
        return labProjectMapper.updateLabProject(project);
    }

    @Override
    public int deleteLabProjectByIds(Long[] projectIds)
    {
        return labProjectMapper.deleteLabProjectByIds(projectIds);
    }

    private void prepare(CmsLabProject project)
    {
        if (StringUtils.isNotEmpty(project.getProjectName()))
        {
            project.setProjectName(project.getProjectName().trim());
        }
        if (StringUtils.isNotEmpty(project.getDescription()))
        {
            project.setDescription(project.getDescription().trim());
        }
        else
        {
            project.setDescription(null);
        }
        if (StringUtils.isNotEmpty(project.getRepoUrl()))
        {
            project.setRepoUrl(project.getRepoUrl().trim());
        }
        if (StringUtils.isNotEmpty(project.getPreviewUrl()))
        {
            project.setPreviewUrl(project.getPreviewUrl().trim());
        }
        else
        {
            project.setPreviewUrl(null);
        }
        if (StringUtils.isEmpty(project.getCover()))
        {
            project.setCover(null);
        }
    }
}
