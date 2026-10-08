package com.ruoyi.blog.mapper;

import java.util.List;
import com.ruoyi.blog.domain.CmsLabProject;

/**
 * 实验室项目 Mapper
 *
 * @author ruoyi
 */
public interface CmsLabProjectMapper
{
    CmsLabProject selectLabProjectById(Long projectId);

    List<CmsLabProject> selectLabProjectList(CmsLabProject project);

    int insertLabProject(CmsLabProject project);

    int updateLabProject(CmsLabProject project);

    int deleteLabProjectByIds(Long[] projectIds);
}
