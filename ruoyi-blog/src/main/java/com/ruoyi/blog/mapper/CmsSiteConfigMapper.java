package com.ruoyi.blog.mapper;

import java.util.List;
import com.ruoyi.blog.domain.CmsSiteConfig;

/**
 * Site config mapper.
 *
 * @author ruoyi
 */
public interface CmsSiteConfigMapper
{
    /**
     * All rows.
     *
     * @return rows
     */
    List<CmsSiteConfig> selectSiteConfigList();

    /**
     * Insert one key.
     *
     * @param config row
     * @return rows
     */
    int insertSiteConfig(CmsSiteConfig config);

    /**
     * Update value by key.
     *
     * @param config row
     * @return rows
     */
    int updateSiteConfigByKey(CmsSiteConfig config);
}
