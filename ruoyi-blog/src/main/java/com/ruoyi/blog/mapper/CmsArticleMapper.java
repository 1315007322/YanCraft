package com.ruoyi.blog.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.blog.domain.CmsArticle;

/**
 * 文章数据层
 *
 * @author ruoyi
 */
public interface CmsArticleMapper
{
    /**
     * 按ID查询（含正文）
     *
     * @param articleId 文章ID
     * @return 文章
     */
    CmsArticle selectArticleById(Long articleId);

    /**
     * 按 slug 查询（含正文）
     *
     * @param slug 访问标识
     * @return 文章
     */
    CmsArticle selectArticleBySlug(String slug);

    /**
     * 查询文章列表（不含正文）
     *
     * @param article 查询条件
     * @return 文章集合
     */
    List<CmsArticle> selectArticleList(CmsArticle article);

    /**
     * 已发布热门列表
     *
     * @param limit 条数
     * @return 文章集合
     */
    List<CmsArticle> selectHotArticleList(@Param("limit") int limit);

    /**
     * 新增文章
     *
     * @param article 文章
     * @return 影响行数
     */
    int insertArticle(CmsArticle article);

    /**
     * 修改文章（全量业务字段，用于后台保存）
     *
     * @param article 文章
     * @return 影响行数
     */
    int updateArticle(CmsArticle article);

    /**
     * 仅更新状态（及可选的首次发布时间），避免发布/下线时清空其它字段
     *
     * @param article 需包含 articleId、status
     * @return 影响行数
     */
    int updateArticleStatus(CmsArticle article);

    /**
     * 逻辑删除
     *
     * @param articleIds 文章ID数组
     * @return 影响行数
     */
    int deleteArticleByIds(Long[] articleIds);

    /**
     * 浏览量加一
     *
     * @param articleId 文章ID
     * @return 影响行数
     */
    int incrementViewCount(Long articleId);

    /**
     * 校验 slug 是否已被其它未删除文章占用
     *
     * @param slug 访问标识
     * @param articleId 排除的文章ID，新增传 null
     * @return 冲突记录；无冲突则 null
     */
    CmsArticle checkSlugUnique(@Param("slug") String slug, @Param("articleId") Long articleId);
}
