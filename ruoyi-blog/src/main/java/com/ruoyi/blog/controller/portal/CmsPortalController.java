package com.ruoyi.blog.controller.portal;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.blog.constant.CmsConstants;
import com.ruoyi.blog.domain.CmsArticle;
import com.ruoyi.blog.domain.CmsCategory;
import com.ruoyi.blog.domain.CmsTag;
import com.ruoyi.blog.service.ICmsArticleService;
import com.ruoyi.blog.service.ICmsCategoryService;
import com.ruoyi.blog.service.ICmsTagService;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 博客前台只读接口。匿名可访问，仅返回已发布且未删除的内容。
 *
 * @author ruoyi
 */
@Anonymous
@RestController
@RequestMapping("/portal/cms")
public class CmsPortalController extends BaseController
{
    @Autowired
    private ICmsArticleService articleService;

    @Autowired
    private ICmsCategoryService categoryService;

    @Autowired
    private ICmsTagService tagService;

    /**
     * 分页查询已发布文章列表（不含正文）。可按 keyword、categorySlug、tagSlug 过滤。
     */
    @GetMapping("/article/list")
    public TableDataInfo articleList(CmsArticle article)
    {
        startPage();
        List<CmsArticle> list = articleService.selectPublishedList(article);
        return getDataTable(list);
    }

    /**
     * 按ID获取已发布文章详情，并累加浏览量
     */
    @GetMapping("/article/{articleId}")
    public AjaxResult article(@PathVariable Long articleId)
    {
        CmsArticle article = articleService.selectPublishedById(articleId);
        return article == null ? error("文章不存在或未发布") : success(article);
    }

    /**
     * 按 slug 获取已发布文章详情，并累加浏览量
     */
    @GetMapping("/article/slug/{slug}")
    public AjaxResult articleBySlug(@PathVariable String slug)
    {
        CmsArticle article = articleService.selectPublishedBySlug(slug);
        return article == null ? error("文章不存在或未发布") : success(article);
    }

    /**
     * 按浏览量取热门已发布文章，limit 默认 10、最大 50
     */
    @GetMapping("/article/hot")
    public AjaxResult hot(@RequestParam(value = "limit", defaultValue = "10") int limit)
    {
        return success(articleService.selectHotList(limit));
    }

    /**
     * 启用中的分类列表（不分页）
     */
    @GetMapping("/category/list")
    public AjaxResult categoryList()
    {
        CmsCategory query = new CmsCategory();
        query.setStatus(CmsConstants.STATUS_OK);
        return success(categoryService.selectCategoryList(query));
    }

    /**
     * 标签列表（不分页）
     */
    @GetMapping("/tag/list")
    public AjaxResult tagList()
    {
        return success(tagService.selectTagList(new CmsTag()));
    }
}
