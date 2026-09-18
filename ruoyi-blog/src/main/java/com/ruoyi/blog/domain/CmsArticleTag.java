package com.ruoyi.blog.domain;

/**
 * 文章-标签关联 cms_article_tag
 *
 * @author ruoyi
 */
public class CmsArticleTag
{
    /** 文章ID */
    private Long articleId;

    /** 标签ID */
    private Long tagId;

    public Long getArticleId()
    {
        return articleId;
    }

    public void setArticleId(Long articleId)
    {
        this.articleId = articleId;
    }

    public Long getTagId()
    {
        return tagId;
    }

    public void setTagId(Long tagId)
    {
        this.tagId = tagId;
    }
}
