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
import com.ruoyi.blog.domain.CmsFriendLink;
import com.ruoyi.blog.service.ICmsFriendLinkService;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;

/**
 * Friend link admin API.
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/cms/link")
public class CmsFriendLinkController extends BaseController
{
    @Autowired
    private ICmsFriendLinkService friendLinkService;

    /**
     * Paged list.
     */
    @PreAuthorize("@ss.hasPermi('cms:link:list')")
    @GetMapping("/list")
    public TableDataInfo list(CmsFriendLink link)
    {
        startPage();
        List<CmsFriendLink> list = friendLinkService.selectFriendLinkList(link);
        return getDataTable(list);
    }

    /**
     * Detail by id.
     */
    @PreAuthorize("@ss.hasPermi('cms:link:query')")
    @GetMapping("/{linkId}")
    public AjaxResult getInfo(@PathVariable Long linkId)
    {
        return success(friendLinkService.selectFriendLinkById(linkId));
    }

    /**
     * Create.
     */
    @PreAuthorize("@ss.hasPermi('cms:link:add')")
    @Log(title = "\u535a\u5ba2\u53cb\u94fe", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody CmsFriendLink link)
    {
        link.setCreateBy(getUsername());
        return toAjax(friendLinkService.insertFriendLink(link));
    }

    /**
     * Update.
     */
    @PreAuthorize("@ss.hasPermi('cms:link:edit')")
    @Log(title = "\u535a\u5ba2\u53cb\u94fe", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody CmsFriendLink link)
    {
        link.setUpdateBy(getUsername());
        return toAjax(friendLinkService.updateFriendLink(link));
    }

    /**
     * Delete.
     */
    @PreAuthorize("@ss.hasPermi('cms:link:remove')")
    @Log(title = "\u535a\u5ba2\u53cb\u94fe", businessType = BusinessType.DELETE)
    @DeleteMapping("/{linkIds}")
    public AjaxResult remove(@PathVariable Long[] linkIds)
    {
        return toAjax(friendLinkService.deleteFriendLinkByIds(linkIds));
    }
}
