package com.ruoyi.blog.domain;

import java.util.Date;
import java.util.List;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.common.xss.Xss;

/**
 * 博客文章 cms_article
 *
 * @author ruoyi
 */
public class CmsArticle extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 文章ID */
    private Long articleId;

    /** 标题 */
    private String title;

    /** 访问标识，空则存 null */
    private String slug;

    /** 摘要 */
    private String summary;

    /** 封面路径 */
    private String cover;

    /** Markdown 正文 */
    private String content;

    /** 分类ID */
    private Long categoryId;

    /** 分类名称（联表查询） */
    private String categoryName;

    /** 作者展示名 */
    private String author;

    /** 状态（0草稿 1已发布 2下线） */
    private String status;

    /** 是否置顶（0否 1是） */
    private String isTop;

    /** 浏览量 */
    private Integer viewCount;

    /** 字数（中文按字，英文按词） */
    private Integer wordCount;

    /** 预计阅读分钟数 */
    private Integer readingTime;

    /** 首次发布时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date publishTime;

    /** 删除标志（0存在 2删除） */
    private String delFlag;

    /** 绑定的标签ID（保存用） */
    private Long[] tagIds;

    /** 绑定的标签（详情回显） */
    private List<CmsTag> tags;

    /** 前台查询：分类 slug */
    private String categorySlug;

    /** 前台查询：标签 slug */
    private String tagSlug;

    /** 前台查询：标题关键字 */
    private String keyword;

    public Long getArticleId()
    {
        return articleId;
    }

    public void setArticleId(Long articleId)
    {
        this.articleId = articleId;
    }

    @Xss(message = "标题不能包含脚本字符")
    @NotBlank(message = "标题不能为空")
    @Size(min = 0, max = 200, message = "标题不能超过200个字符")
    public String getTitle()
    {
        return title;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    @Size(min = 0, max = 120, message = "访问标识不能超过120个字符")
    public String getSlug()
    {
        return slug;
    }

    public void setSlug(String slug)
    {
        this.slug = slug;
    }

    @Size(min = 0, max = 500, message = "摘要不能超过500个字符")
    public String getSummary()
    {
        return summary;
    }

    public void setSummary(String summary)
    {
        this.summary = summary;
    }

    public String getCover()
    {
        return cover;
    }

    public void setCover(String cover)
    {
        this.cover = cover;
    }

    public String getContent()
    {
        return content;
    }

    public void setContent(String content)
    {
        this.content = content;
    }

    public Long getCategoryId()
    {
        return categoryId;
    }

    public void setCategoryId(Long categoryId)
    {
        this.categoryId = categoryId;
    }

    public String getCategoryName()
    {
        return categoryName;
    }

    public void setCategoryName(String categoryName)
    {
        this.categoryName = categoryName;
    }

    public String getAuthor()
    {
        return author;
    }

    public void setAuthor(String author)
    {
        this.author = author;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getIsTop()
    {
        return isTop;
    }

    public void setIsTop(String isTop)
    {
        this.isTop = isTop;
    }

    public Integer getViewCount()
    {
        return viewCount;
    }

    public void setViewCount(Integer viewCount)
    {
        this.viewCount = viewCount;
    }

    public Integer getWordCount()
    {
        return wordCount;
    }

    public void setWordCount(Integer wordCount)
    {
        this.wordCount = wordCount;
    }

    public Integer getReadingTime()
    {
        return readingTime;
    }

    public void setReadingTime(Integer readingTime)
    {
        this.readingTime = readingTime;
    }

    public Date getPublishTime()
    {
        return publishTime;
    }

    public void setPublishTime(Date publishTime)
    {
        this.publishTime = publishTime;
    }

    public String getDelFlag()
    {
        return delFlag;
    }

    public void setDelFlag(String delFlag)
    {
        this.delFlag = delFlag;
    }

    public Long[] getTagIds()
    {
        return tagIds;
    }

    public void setTagIds(Long[] tagIds)
    {
        this.tagIds = tagIds;
    }

    public List<CmsTag> getTags()
    {
        return tags;
    }

    public void setTags(List<CmsTag> tags)
    {
        this.tags = tags;
    }

    public String getCategorySlug()
    {
        return categorySlug;
    }

    public void setCategorySlug(String categorySlug)
    {
        this.categorySlug = categorySlug;
    }

    public String getTagSlug()
    {
        return tagSlug;
    }

    public void setTagSlug(String tagSlug)
    {
        this.tagSlug = tagSlug;
    }

    public String getKeyword()
    {
        return keyword;
    }

    public void setKeyword(String keyword)
    {
        this.keyword = keyword;
    }
}
