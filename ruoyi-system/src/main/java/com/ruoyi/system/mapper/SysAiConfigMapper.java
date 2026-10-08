package com.ruoyi.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.SysAiConfig;

/**
 * AI config mapper.
 */
public interface SysAiConfigMapper
{
    List<SysAiConfig> selectAiConfigList(SysAiConfig query);

    SysAiConfig selectAiConfigById(Long configId);

    SysAiConfig checkConfigNameUnique(String configName);

    List<SysAiConfig> selectEnabledOptions(@Param("purpose") String purpose);

    int insertAiConfig(SysAiConfig config);

    int updateAiConfig(SysAiConfig config);

    int clearDefaultByPurpose(@Param("purpose") String purpose, @Param("excludeId") Long excludeId);

    int deleteAiConfigById(Long configId);

    int deleteAiConfigByIds(Long[] configIds);
}
