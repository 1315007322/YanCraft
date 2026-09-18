package com.ruoyi.blog.service;

import java.util.List;
import com.ruoyi.blog.domain.CmsCategory;

/**
 * 博客分类服务
 *
 * @author ruoyi
 */
public interface ICmsCategoryService
{
    /**
     * 按ID查询分类
     *
     * @param categoryId 分类ID
     * @return 分类
     */
    CmsCategory selectCategoryById(Long categoryId);

    /**
     * 查询分类列表
     *
     * @param category 查询条件
     * @return 分类集合
     */
    List<CmsCategory> selectCategoryList(CmsCategory category);

    /**
     * 新增分类
     *
     * @param category 分类
     * @return 影响行数
     */
    int insertCategory(CmsCategory category);

    /**
     * 修改分类
     *
     * @param category 分类
     * @return 影响行数
     */
    int updateCategory(CmsCategory category);

    /**
     * 删除分类。仍有文章时抛出业务异常。
     *
     * @param categoryIds 分类ID数组
     * @return 影响行数
     */
    int deleteCategoryByIds(Long[] categoryIds);
}
