package com.ruoyi.blog.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.blog.domain.CmsCategory;

/**
 * 分类数据层
 *
 * @author ruoyi
 */
public interface CmsCategoryMapper
{
    /**
     * 按ID查询未删除分类
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
     * 逻辑删除分类
     *
     * @param categoryIds 分类ID数组
     * @return 影响行数
     */
    int deleteCategoryByIds(Long[] categoryIds);

    /**
     * 校验 slug 是否已被其它未删除分类占用
     *
     * @param slug 访问标识
     * @param categoryId 排除的分类ID，新增传 null
     * @return 冲突记录；无冲突则 null
     */
    CmsCategory checkSlugUnique(@Param("slug") String slug, @Param("categoryId") Long categoryId);

    /**
     * 统计分类下未删除文章数量
     *
     * @param categoryId 分类ID
     * @return 文章数
     */
    int countArticleByCategoryId(Long categoryId);
}
