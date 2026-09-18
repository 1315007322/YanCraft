package com.ruoyi.blog.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;

/**
 * 文章-标签关联数据层
 *
 * @author ruoyi
 */
public interface CmsArticleTagMapper
{
    /**
     * 删除某篇文章的全部标签关联
     *
     * @param articleId 文章ID
     * @return 影响行数
     */
    int deleteByArticleId(Long articleId);

    /**
     * 批量删除文章的标签关联
     *
     * @param articleIds 文章ID数组
     * @return 影响行数
     */
    int deleteByArticleIds(Long[] articleIds);

    /**
     * 批量为文章绑定标签
     *
     * @param articleId 文章ID
     * @param tagIds 标签ID数组，调用方保证非空
     * @return 影响行数
     */
    int batchInsert(@Param("articleId") Long articleId, @Param("tagIds") Long[] tagIds);

    /**
     * 查询文章已绑定的标签ID
     *
     * @param articleId 文章ID
     * @return 标签ID列表
     */
    List<Long> selectTagIdsByArticleId(Long articleId);
}
