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
import com.ruoyi.blog.domain.CmsTag;
import com.ruoyi.blog.service.ICmsTagService;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;

/**
 * 博客标签后台接口
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/cms/tag")
public class CmsTagController extends BaseController
{
    @Autowired
    private ICmsTagService tagService;

    /**
     * 分页查询标签
     */
    @PreAuthorize("@ss.hasPermi('cms:tag:list')")
    @GetMapping("/list")
    public TableDataInfo list(CmsTag tag)
    {
        startPage();
        List<CmsTag> list = tagService.selectTagList(tag);
        return getDataTable(list);
    }

    /**
     * 根据标签ID获取详情
     */
    @PreAuthorize("@ss.hasPermi('cms:tag:query')")
    @GetMapping("/{tagId}")
    public AjaxResult getInfo(@PathVariable Long tagId)
    {
        return success(tagService.selectTagById(tagId));
    }

    /**
     * 新增标签
     */
    @PreAuthorize("@ss.hasPermi('cms:tag:add')")
    @Log(title = "博客标签", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody CmsTag tag)
    {
        tag.setCreateBy(getUsername());
        return toAjax(tagService.insertTag(tag));
    }

    /**
     * 修改标签
     */
    @PreAuthorize("@ss.hasPermi('cms:tag:edit')")
    @Log(title = "博客标签", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody CmsTag tag)
    {
        tag.setUpdateBy(getUsername());
        return toAjax(tagService.updateTag(tag));
    }

    /**
     * 删除标签。仍被文章引用时拒绝删除。
     */
    @PreAuthorize("@ss.hasPermi('cms:tag:remove')")
    @Log(title = "博客标签", businessType = BusinessType.DELETE)
    @DeleteMapping("/{tagIds}")
    public AjaxResult remove(@PathVariable Long[] tagIds)
    {
        return toAjax(tagService.deleteTagByIds(tagIds));
    }
}
