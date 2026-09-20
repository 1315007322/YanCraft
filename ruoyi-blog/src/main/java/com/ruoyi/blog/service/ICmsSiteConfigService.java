package com.ruoyi.blog.service;

import com.ruoyi.blog.domain.CmsSiteSetting;

/**
 * Site setting service.
 *
 * @author ruoyi
 */
public interface ICmsSiteConfigService
{
    /**
     * Load settings with SuperYan defaults for missing keys.
     *
     * @return settings
     */
    CmsSiteSetting getSetting();

    /**
     * Upsert all first-version keys.
     *
     * @param setting form
     * @return rows written
     */
    int saveSetting(CmsSiteSetting setting);
}
