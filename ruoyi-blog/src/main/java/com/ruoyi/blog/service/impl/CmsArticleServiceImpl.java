package com.ruoyi.blog.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.blog.constant.CmsConstants;
import com.ruoyi.blog.domain.CmsArticle;
import com.ruoyi.blog.mapper.CmsArticleMapper;
import com.ruoyi.blog.mapper.CmsArticleTagMapper;
import com.ruoyi.blog.mapper.CmsTagMapper;
import com.ruoyi.blog.service.ICmsArticleService;
import com.ruoyi.blog.util.ArticleReadingStats;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;

/**
 * 博客文章服务实现
 *
 * @author ruoyi
 */
@Service
public class CmsArticleServiceImpl implements ICmsArticleService
{
    @Autowired
    private CmsArticleMapper articleMapper;

    @Autowired
    private CmsArticleTagMapper articleTagMapper;

    @Autowired
    private CmsTagMapper tagMapper;

    /**
     * 按ID查询文章（后台）并填充标签
     */
    @Override
    public CmsArticle selectArticleById(Long articleId)
    {
        CmsArticle article = articleMapper.selectArticleById(articleId);
        fillTags(article);
        return article;
    }

    /**
     * 按ID取已发布文章并增加浏览量
     */
    @Override
    public CmsArticle selectPublishedById(Long articleId)
    {
        CmsArticle article = articleMapper.selectArticleById(articleId);
        return publishedOrNull(article, true);
    }

    /**
     * 按 slug 取已发布文章并增加浏览量
     */
    @Override
    public CmsArticle selectPublishedBySlug(String slug)
    {
        CmsArticle article = articleMapper.selectArticleBySlug(slug);
        return publishedOrNull(article, true);
    }

    /**
     * 后台文章列表
     */
    @Override
    public List<CmsArticle> selectArticleList(CmsArticle article)
    {
        return articleMapper.selectArticleList(article);
    }

    /**
     * 前台已发布列表
     */
    @Override
    public List<CmsArticle> selectPublishedList(CmsArticle article)
    {
        article.setStatus(CmsConstants.ARTICLE_PUBLISHED);
        return articleMapper.selectArticleList(article);
    }

    /**
     * 热门列表，limit 限制在 1~50
     */
    @Override
    public List<CmsArticle> selectHotList(int limit)
    {
        if (limit <= 0)
        {
            limit = 10;
        }
        if (limit > 50)
        {
            limit = 50;
        }
        return articleMapper.selectHotArticleList(limit);
    }

    /**
     * 新增文章：校验 slug、统计字数、首次发布写时间、绑定标签
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertArticle(CmsArticle article)
    {
        prepareSave(article, null);
        applyPublishTimeOnCreate(article);
        int rows = articleMapper.insertArticle(article);
        replaceTags(article.getArticleId(), article.getTagIds());
        return rows;
    }

    /**
     * 修改文章：保留首次发布时间，覆盖标签关联
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateArticle(CmsArticle article)
    {
        CmsArticle db = requireArticle(article.getArticleId());
        prepareSave(article, article.getArticleId());
        applyPublishTimeOnUpdate(article, db);
        int rows = articleMapper.updateArticle(article);
        replaceTags(article.getArticleId(), article.getTagIds());
        return rows;
    }

    /**
     * 逻辑删除文章并删除标签关系
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteArticleByIds(Long[] articleIds)
    {
        articleTagMapper.deleteByArticleIds(articleIds);
        return articleMapper.deleteArticleByIds(articleIds);
    }

    /**
     * 发布；库中尚无 publishTime 时写入当前时间
     */
    @Override
    public int publish(Long articleId, String updateBy)
    {
        CmsArticle db = requireArticle(articleId);
        CmsArticle patch = new CmsArticle();
        patch.setArticleId(articleId);
        patch.setStatus(CmsConstants.ARTICLE_PUBLISHED);
        patch.setUpdateBy(updateBy);
        if (db.getPublishTime() == null)
        {
            patch.setPublishTime(DateUtils.getNowDate());
        }
        return articleMapper.updateArticleStatus(patch);
    }

    /**
     * 下线，不改 publishTime
     */
    @Override
    public int offline(Long articleId, String updateBy)
    {
        requireArticle(articleId);
        CmsArticle patch = new CmsArticle();
        patch.setArticleId(articleId);
        patch.setStatus(CmsConstants.ARTICLE_OFFLINE);
        patch.setUpdateBy(updateBy);
        return articleMapper.updateArticleStatus(patch);
    }

    /**
     * 非已发布返回 null；需要时累加浏览量并填充标签
     */
    private CmsArticle publishedOrNull(CmsArticle article, boolean increaseView)
    {
        if (article == null || !CmsConstants.ARTICLE_PUBLISHED.equals(article.getStatus()))
        {
            return null;
        }
        fillTags(article);
        if (increaseView)
        {
            articleMapper.incrementViewCount(article.getArticleId());
            Integer views = article.getViewCount();
            article.setViewCount(views == null ? 1 : views + 1);
        }
        return article;
    }

    /**
     * 填充 tags 与 tagIds
     */
    private void fillTags(CmsArticle article)
    {
        if (article == null)
        {
            return;
        }
        article.setTags(tagMapper.selectTagsByArticleId(article.getArticleId()));
        List<Long> ids = articleTagMapper.selectTagIdsByArticleId(article.getArticleId());
        article.setTagIds(ids.toArray(new Long[0]));
    }

    /**
     * 规范化 slug、校验唯一、默认状态，并按正文重算字数与阅读时长（忽略前端传入值）
     */
    private void prepareSave(CmsArticle article, Long excludeId)
    {
        article.setSlug(blankToNull(article.getSlug()));
        if (article.getSlug() != null && articleMapper.checkSlugUnique(article.getSlug(), excludeId) != null)
        {
            throw new ServiceException("文章访问标识已存在");
        }
        if (StringUtils.isEmpty(article.getStatus()))
        {
            article.setStatus(CmsConstants.ARTICLE_DRAFT);
        }
        if (StringUtils.isEmpty(article.getIsTop()))
        {
            article.setIsTop(CmsConstants.NOT_TOP);
        }
        ArticleReadingStats stats = ArticleReadingStats.of(article.getContent());
        article.setWordCount(stats.getWordCount());
        article.setReadingTime(stats.getReadingTime());
    }

    /**
     * 新增时若直接发布则写入发布时间
     */
    private void applyPublishTimeOnCreate(CmsArticle article)
    {
        if (CmsConstants.ARTICLE_PUBLISHED.equals(article.getStatus()))
        {
            article.setPublishTime(DateUtils.getNowDate());
        }
    }

    /**
     * 修改为已发布且历史上未发布过时写入发布时间
     */
    private void applyPublishTimeOnUpdate(CmsArticle article, CmsArticle db)
    {
        if (CmsConstants.ARTICLE_PUBLISHED.equals(article.getStatus()) && db.getPublishTime() == null)
        {
            article.setPublishTime(DateUtils.getNowDate());
        }
    }

    /**
     * 先删后插，重建文章标签
     */
    private void replaceTags(Long articleId, Long[] tagIds)
    {
        articleTagMapper.deleteByArticleId(articleId);
        if (tagIds != null && tagIds.length > 0)
        {
            articleTagMapper.batchInsert(articleId, tagIds);
        }
    }

    /**
     * 文章必须存在，否则抛业务异常
     */
    private CmsArticle requireArticle(Long articleId)
    {
        CmsArticle article = articleMapper.selectArticleById(articleId);
        if (article == null)
        {
            throw new ServiceException("文章不存在");
        }
        return article;
    }

    /**
     * 空白 slug 存 null，避免唯一索引把空串当成重复
     */
    private String blankToNull(String slug)
    {
        return StringUtils.isEmpty(slug) ? null : slug.trim();
    }
}
