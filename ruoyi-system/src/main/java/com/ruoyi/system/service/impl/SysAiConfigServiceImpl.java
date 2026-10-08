package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.SysAiConfig;
import com.ruoyi.system.mapper.SysAiConfigMapper;
import com.ruoyi.system.service.ISysAiConfigService;

/**
 * Persist OpenAI-compatible AI profiles. API keys never leave this layer.
 */
@Service
public class SysAiConfigServiceImpl implements ISysAiConfigService
{
    @Autowired
    private SysAiConfigMapper aiConfigMapper;

    @Override
    public List<SysAiConfig> selectAiConfigList(SysAiConfig query)
    {
        List<SysAiConfig> list = aiConfigMapper.selectAiConfigList(query);
        for (SysAiConfig item : list)
        {
            hideSecret(item);
        }
        return list;
    }

    @Override
    public SysAiConfig selectAiConfigById(Long configId)
    {
        SysAiConfig row = aiConfigMapper.selectAiConfigById(configId);
        hideSecret(row);
        return row;
    }

    @Override
    public SysAiConfig selectAiConfigSecretById(Long configId)
    {
        return aiConfigMapper.selectAiConfigById(configId);
    }

    @Override
    public List<SysAiConfig> selectEnabledOptions(String purpose)
    {
        return aiConfigMapper.selectEnabledOptions(purpose);
    }

    @Override
    public boolean checkConfigNameUnique(SysAiConfig config)
    {
        Long id = StringUtils.isNull(config.getConfigId()) ? -1L : config.getConfigId();
        SysAiConfig info = aiConfigMapper.checkConfigNameUnique(config.getConfigName());
        if (StringUtils.isNotNull(info) && info.getConfigId().longValue() != id.longValue())
        {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    @Override
    @Transactional
    public int insertAiConfig(SysAiConfig config)
    {
        normalize(config);
        if (StringUtils.isEmpty(config.getApiKey()))
        {
            throw new ServiceException("API Key\u4e0d\u80fd\u4e3a\u7a7a");
        }
        int rows = aiConfigMapper.insertAiConfig(config);
        syncDefault(config);
        return rows;
    }

    @Override
    @Transactional
    public int updateAiConfig(SysAiConfig config)
    {
        normalize(config);
        int rows = aiConfigMapper.updateAiConfig(config);
        syncDefault(config);
        return rows;
    }

    @Override
    public int deleteAiConfigByIds(Long[] configIds)
    {
        return aiConfigMapper.deleteAiConfigByIds(configIds);
    }

    private void normalize(SysAiConfig config)
    {
        if (config.getConfigName() != null)
        {
            config.setConfigName(config.getConfigName().trim());
        }
        if (config.getBaseUrl() != null)
        {
            String url = config.getBaseUrl().trim();
            while (url.endsWith("/"))
            {
                url = url.substring(0, url.length() - 1);
            }
            config.setBaseUrl(url);
        }
        if (config.getModelName() != null)
        {
            config.setModelName(config.getModelName().trim());
        }
        String purpose = config.getPurpose() == null ? "" : config.getPurpose().trim();
        if (!SysAiConfig.PURPOSE_CHAT.equals(purpose) && !SysAiConfig.PURPOSE_IMAGE.equals(purpose))
        {
            throw new ServiceException("\u7528\u9014\u53ea\u80fd\u662f\u5bf9\u8bdd\u6216\u51fa\u56fe");
        }
        config.setPurpose(purpose);
        if (config.getTimeoutSeconds() == null)
        {
            config.setTimeoutSeconds(Integer.valueOf(60));
        }
        if (config.getMaxTokens() == null)
        {
            config.setMaxTokens(Integer.valueOf(4096));
        }
        if (StringUtils.isEmpty(config.getImageSize()))
        {
            config.setImageSize("1024x1024");
        }
        if (StringUtils.isEmpty(config.getIsDefault()))
        {
            config.setIsDefault("N");
        }
        if (StringUtils.isEmpty(config.getStatus()))
        {
            config.setStatus(UserConstants.NORMAL);
        }
        if (config.getSort() == null)
        {
            config.setSort(Integer.valueOf(0));
        }
    }

    private void syncDefault(SysAiConfig config)
    {
        if ("Y".equals(config.getIsDefault()) && config.getConfigId() != null)
        {
            aiConfigMapper.clearDefaultByPurpose(config.getPurpose(), config.getConfigId());
        }
    }

    private void hideSecret(SysAiConfig row)
    {
        if (row == null)
        {
            return;
        }
        row.setHasApiKey(StringUtils.isEmpty(row.getApiKey()) ? "N" : "Y");
        row.setApiKey(null);
    }
}
