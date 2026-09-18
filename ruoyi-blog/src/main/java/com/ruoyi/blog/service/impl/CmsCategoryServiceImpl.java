package com.ruoyi.blog.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.blog.constant.CmsConstants;
import com.ruoyi.blog.domain.CmsCategory;
import com.ruoyi.blog.mapper.CmsCategoryMapper;
import com.ruoyi.blog.service.ICmsCategoryService;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;

/**
 * 博客分类服务实现
 *
 * @author ruoyi
 */
@Service
public class CmsCategoryServiceImpl implements ICmsCategoryService
{
    @Autowired
    private CmsCategoryMapper categoryMapper;

    /**
     * 按ID查询分类
     */
    @Override
    public CmsCategory selectCategoryById(Long categoryId)
    {
        return categoryMapper.selectCategoryById(categoryId);
    }

    /**
     * 查询分类列表
     */
    @Override
    public List<CmsCategory> selectCategoryList(CmsCategory category)
    {
        return categoryMapper.selectCategoryList(category);
    }

    /**
     * 新增分类，补齐父级、状态、排序默认值
     */
    @Override
    public int insertCategory(CmsCategory category)
    {
        prepare(category, null);
        if (category.getParentId() == null)
        {
            category.setParentId(0L);
        }
        if (StringUtils.isEmpty(category.getStatus()))
        {
            category.setStatus(CmsConstants.STATUS_OK);
        }
        if (category.getSort() == null)
        {
            category.setSort(0);
        }
        return categoryMapper.insertCategory(category);
    }

    /**
     * 修改分类
     */
    @Override
    public int updateCategory(CmsCategory category)
    {
        prepare(category, category.getCategoryId());
        return categoryMapper.updateCategory(category);
    }

    /**
     * 删除分类；仍有文章则拒绝
     */
    @Override
    public int deleteCategoryByIds(Long[] categoryIds)
    {
        for (Long id : categoryIds)
        {
            if (categoryMapper.countArticleByCategoryId(id) > 0)
            {
                CmsCategory category = categoryMapper.selectCategoryById(id);
                String name = category == null ? String.valueOf(id) : category.getName();
                throw new ServiceException("分类「" + name + "」已有文章，无法删除");
            }
        }
        return categoryMapper.deleteCategoryByIds(categoryIds);
    }

    /**
     * 规范化 slug 并校验唯一
     */
    private void prepare(CmsCategory category, Long excludeId)
    {
        category.setSlug(blankToNull(category.getSlug()));
        if (category.getSlug() != null && categoryMapper.checkSlugUnique(category.getSlug(), excludeId) != null)
        {
            throw new ServiceException("分类访问标识已存在");
        }
    }

    /**
     * 空白 slug 存 null
     */
    private String blankToNull(String slug)
    {
        return StringUtils.isEmpty(slug) ? null : slug.trim();
    }
}
