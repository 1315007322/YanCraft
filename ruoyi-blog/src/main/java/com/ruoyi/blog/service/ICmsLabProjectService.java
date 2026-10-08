package com.ruoyi.blog.service;

import java.util.List;
import com.ruoyi.blog.domain.CmsLabProject;

/**
 * 实验室项目
 *
 * @author ruoyi
 */
public interface ICmsLabProjectService
{
    CmsLabProject selectLabProjectById(Long projectId);

    List<CmsLabProject> selectLabProjectList(CmsLabProject project);

    int insertLabProject(CmsLabProject project);

    int updateLabProject(CmsLabProject project);

    int deleteLabProjectByIds(Long[] projectIds);
}
