package com.ruoyi.blog.domain;

/**
 * Site config row cms_site_config.
 *
 * @author ruoyi
 */
public class CmsSiteConfig
{
    private Long configId;
    private String configKey;
    private String configValue;

    public Long getConfigId()
    {
        return configId;
    }

    public void setConfigId(Long configId)
    {
        this.configId = configId;
    }

    public String getConfigKey()
    {
        return configKey;
    }

    public void setConfigKey(String configKey)
    {
        this.configKey = configKey;
    }

    public String getConfigValue()
    {
        return configValue;
    }

    public void setConfigValue(String configValue)
    {
        this.configValue = configValue;
    }
}
