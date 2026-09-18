package com.ruoyi.blog.service;

import java.util.List;
import com.ruoyi.blog.domain.CmsArticle;

/**
 * 博客文章服务
 *
 * @author ruoyi
 */
public interface ICmsArticleService
{
    /**
     * 按ID查询文章（后台，含草稿），并填充标签
     *
     * @param articleId 文章ID
     * @return 文章；不存在则 null
     */
    CmsArticle selectArticleById(Long articleId);

    /**
     * 按ID查询已发布文章，成功时浏览量加一
     *
     * @param articleId 文章ID
     * @return 已发布文章；草稿/下线/不存在则 null
     */
    CmsArticle selectPublishedById(Long articleId);

    /**
     * 按 slug 查询已发布文章，成功时浏览量加一
     *
     * @param slug 访问标识
     * @return 已发布文章；否则 null
     */
    CmsArticle selectPublishedBySlug(String slug);

    /**
     * 后台文章列表（不含正文）
     *
     * @param article 查询条件
     * @return 文章集合
     */
    List<CmsArticle> selectArticleList(CmsArticle article);

    /**
     * 前台已发布文章列表（不含正文）
     *
     * @param article 查询条件（会强制 status=已发布）
     * @return 文章集合
     */
    List<CmsArticle> selectPublishedList(CmsArticle article);

    /**
     * 热门已发布文章
     *
     * @param limit 条数，超出范围时截断到 1~50
     * @return 文章集合
     */
    List<CmsArticle> selectHotList(int limit);

    /**
     * 新增文章，计算字数/阅读时长并写入标签关联
     *
     * @param article 文章
     * @return 影响行数
     */
    int insertArticle(CmsArticle article);

    /**
     * 修改文章，重算字数/阅读时长并覆盖标签关联
     *
     * @param article 文章
     * @return 影响行数
     */
    int updateArticle(CmsArticle article);

    /**
     * 逻辑删除文章并清理标签关联
     *
     * @param articleIds 文章ID数组
     * @return 影响行数
     */
    int deleteArticleByIds(Long[] articleIds);

    /**
     * 发布文章；首次发布写入发布时间
     *
     * @param articleId 文章ID
     * @param updateBy 操作人
     * @return 影响行数
     */
    int publish(Long articleId, String updateBy);

    /**
     * 下线文章
     *
     * @param articleId 文章ID
     * @param updateBy 操作人
     * @return 影响行数
     */
    int offline(Long articleId, String updateBy);
}
