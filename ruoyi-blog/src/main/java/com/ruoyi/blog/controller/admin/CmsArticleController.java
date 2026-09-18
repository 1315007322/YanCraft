package com.ruoyi.blog.controller.admin;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.blog.domain.CmsArticle;
import com.ruoyi.blog.service.ICmsArticleService;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;

/**
 * 博客文章后台接口
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/cms/article")
public class CmsArticleController extends BaseController
{
    @Autowired
    private ICmsArticleService articleService;

    /**
     * 分页查询文章（含草稿、已发布、下线）
     */
    @PreAuthorize("@ss.hasPermi('cms:article:list')")
    @GetMapping("/list")
    public TableDataInfo list(CmsArticle article)
    {
        startPage();
        List<CmsArticle> list = articleService.selectArticleList(article);
        return getDataTable(list);
    }

    /**
     * 根据文章ID获取详情（含正文和标签）
     */
    @PreAuthorize("@ss.hasPermi('cms:article:query')")
    @GetMapping("/{articleId}")
    public AjaxResult getInfo(@PathVariable Long articleId)
    {
        return success(articleService.selectArticleById(articleId));
    }

    /**
     * 新增文章。字数、阅读时长由服务端根据正文计算；作者为空时取当前登录用户。
     */
    @PreAuthorize("@ss.hasPermi('cms:article:add')")
    @Log(title = "博客文章", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody CmsArticle article)
    {
        article.setCreateBy(getUsername());
        if (StringUtils.isEmpty(article.getAuthor()))
        {
            article.setAuthor(getUsername());
        }
        return toAjax(articleService.insertArticle(article));
    }

    /**
     * 修改文章。保存时重算字数与阅读时长，并覆盖标签关联。
     */
    @PreAuthorize("@ss.hasPermi('cms:article:edit')")
    @Log(title = "博客文章", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody CmsArticle article)
    {
        article.setUpdateBy(getUsername());
        return toAjax(articleService.updateArticle(article));
    }

    /**
     * 逻辑删除文章，同时清理文章-标签关系
     */
    @PreAuthorize("@ss.hasPermi('cms:article:remove')")
    @Log(title = "博客文章", businessType = BusinessType.DELETE)
    @DeleteMapping("/{articleIds}")
    public AjaxResult remove(@PathVariable Long[] articleIds)
    {
        return toAjax(articleService.deleteArticleByIds(articleIds));
    }

    /**
     * 发布文章。首次发布写入 publishTime，之后改稿不刷新该时间。
     */
    @PreAuthorize("@ss.hasPermi('cms:article:publish')")
    @Log(title = "博客文章", businessType = BusinessType.UPDATE)
    @PutMapping("/publish/{articleId}")
    public AjaxResult publish(@PathVariable Long articleId)
    {
        return toAjax(articleService.publish(articleId, getUsername()));
    }

    /**
     * 下线已发布文章，前台将不可见
     */
    @PreAuthorize("@ss.hasPermi('cms:article:offline')")
    @Log(title = "博客文章", businessType = BusinessType.UPDATE)
    @PutMapping("/offline/{articleId}")
    public AjaxResult offline(@PathVariable Long articleId)
    {
        return toAjax(articleService.offline(articleId, getUsername()));
    }
}
