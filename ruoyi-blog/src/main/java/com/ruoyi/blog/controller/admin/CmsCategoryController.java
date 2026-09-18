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
import com.ruoyi.blog.domain.CmsCategory;
import com.ruoyi.blog.service.ICmsCategoryService;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;

/**
 * 博客分类后台接口
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/cms/category")
public class CmsCategoryController extends BaseController
{
    @Autowired
    private ICmsCategoryService categoryService;

    /**
     * 分页查询分类
     */
    @PreAuthorize("@ss.hasPermi('cms:category:list')")
    @GetMapping("/list")
    public TableDataInfo list(CmsCategory category)
    {
        startPage();
        List<CmsCategory> list = categoryService.selectCategoryList(category);
        return getDataTable(list);
    }

    /**
     * 根据分类ID获取详情
     */
    @PreAuthorize("@ss.hasPermi('cms:category:query')")
    @GetMapping("/{categoryId}")
    public AjaxResult getInfo(@PathVariable Long categoryId)
    {
        return success(categoryService.selectCategoryById(categoryId));
    }

    /**
     * 新增分类
     */
    @PreAuthorize("@ss.hasPermi('cms:category:add')")
    @Log(title = "博客分类", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody CmsCategory category)
    {
        category.setCreateBy(getUsername());
        return toAjax(categoryService.insertCategory(category));
    }

    /**
     * 修改分类
     */
    @PreAuthorize("@ss.hasPermi('cms:category:edit')")
    @Log(title = "博客分类", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody CmsCategory category)
    {
        category.setUpdateBy(getUsername());
        return toAjax(categoryService.updateCategory(category));
    }

    /**
     * 删除分类。分类下仍有文章时拒绝删除。
     */
    @PreAuthorize("@ss.hasPermi('cms:category:remove')")
    @Log(title = "博客分类", businessType = BusinessType.DELETE)
    @DeleteMapping("/{categoryIds}")
    public AjaxResult remove(@PathVariable Long[] categoryIds)
    {
        return toAjax(categoryService.deleteCategoryByIds(categoryIds));
    }
}
