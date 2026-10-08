package com.ruoyi.blog.controller.admin;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.blog.domain.CmsLabProject;
import com.ruoyi.blog.service.ICmsLabProjectService;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;

/**
 * 实验室项目管理
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/cms/lab")
public class CmsLabProjectController extends BaseController
{
    @Autowired
    private ICmsLabProjectService labProjectService;

    @PreAuthorize("@ss.hasPermi('cms:lab:list')")
    @GetMapping("/list")
    public TableDataInfo list(CmsLabProject project)
    {
        startPage();
        List<CmsLabProject> list = labProjectService.selectLabProjectList(project);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('cms:lab:query')")
    @GetMapping("/{projectId}")
    public AjaxResult getInfo(@PathVariable Long projectId)
    {
        return success(labProjectService.selectLabProjectById(projectId));
    }

    @PreAuthorize("@ss.hasPermi('cms:lab:add')")
    @Log(title = "实验室项目", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody CmsLabProject project)
    {
        project.setCreateBy(getUsername());
        return toAjax(labProjectService.insertLabProject(project));
    }

    @PreAuthorize("@ss.hasPermi('cms:lab:edit')")
    @Log(title = "实验室项目", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody CmsLabProject project)
    {
        project.setUpdateBy(getUsername());
        return toAjax(labProjectService.updateLabProject(project));
    }

    @PreAuthorize("@ss.hasPermi('cms:lab:remove')")
    @Log(title = "实验室项目", businessType = BusinessType.DELETE)
    @DeleteMapping("/{projectIds}")
    public AjaxResult remove(@PathVariable Long[] projectIds)
    {
        return toAjax(labProjectService.deleteLabProjectByIds(projectIds));
    }
}
