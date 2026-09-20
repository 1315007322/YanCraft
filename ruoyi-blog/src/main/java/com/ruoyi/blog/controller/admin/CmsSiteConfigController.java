package com.ruoyi.blog.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.blog.domain.CmsSiteSetting;
import com.ruoyi.blog.service.ICmsSiteConfigService;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;

/**
 * Site setting admin API. Single form, no list.
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/cms/site")
public class CmsSiteConfigController extends BaseController
{
    @Autowired
    private ICmsSiteConfigService siteConfigService;

    /**
     * Load the aggregated form.
     */
    @PreAuthorize("@ss.hasPermi('cms:site:query')")
    @GetMapping
    public AjaxResult getInfo()
    {
        return success(siteConfigService.getSetting());
    }

    /**
     * Save the aggregated form.
     */
    @PreAuthorize("@ss.hasPermi('cms:site:edit')")
    @Log(title = "\u7ad9\u70b9\u914d\u7f6e", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody CmsSiteSetting setting)
    {
        return toAjax(siteConfigService.saveSetting(setting));
    }
}
