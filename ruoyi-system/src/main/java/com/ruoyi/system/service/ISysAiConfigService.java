package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.SysAiConfig;

/**
 * AI config service.
 */
public interface ISysAiConfigService
{
    List<SysAiConfig> selectAiConfigList(SysAiConfig query);

    SysAiConfig selectAiConfigById(Long configId);

    /**
     * Internal use only: includes apiKey. Do not return this to the browser.
     */
    SysAiConfig selectAiConfigSecretById(Long configId);

    List<SysAiConfig> selectEnabledOptions(String purpose);

    boolean checkConfigNameUnique(SysAiConfig config);

    int insertAiConfig(SysAiConfig config);

    int updateAiConfig(SysAiConfig config);

    int deleteAiConfigByIds(Long[] configIds);
}
