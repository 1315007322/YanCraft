package com.ruoyi.system.domain;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * AI provider profile, OpenAI-compatible. Table sys_ai_config.
 */
public class SysAiConfig extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    public static final String PURPOSE_CHAT = "chat";

    public static final String PURPOSE_IMAGE = "image";

    private Long configId;

    private String configName;

    private String purpose;

    private String baseUrl;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String apiKey;

    /** Y if a key is stored; never the real key */
    private String hasApiKey;

    private String modelName;

    private Integer timeoutSeconds;

    private Integer maxTokens;

    private String imageSize;

    private String systemPrompt;

    /** Y default for this purpose, N otherwise */
    private String isDefault;

    /** 0 enabled, 1 disabled */
    private String status;

    private Integer sort;

    public Long getConfigId()
    {
        return configId;
    }

    public void setConfigId(Long configId)
    {
        this.configId = configId;
    }

    @NotBlank(message = "\u914d\u7f6e\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a")
    @Size(max = 50, message = "\u914d\u7f6e\u540d\u79f0\u4e0d\u80fd\u8d85\u8fc750\u4e2a\u5b57\u7b26")
    public String getConfigName()
    {
        return configName;
    }

    public void setConfigName(String configName)
    {
        this.configName = configName;
    }

    @NotBlank(message = "\u7528\u9014\u4e0d\u80fd\u4e3a\u7a7a")
    @Size(max = 16)
    public String getPurpose()
    {
        return purpose;
    }

    public void setPurpose(String purpose)
    {
        this.purpose = purpose;
    }

    @NotBlank(message = "\u63a5\u53e3\u5730\u5740\u4e0d\u80fd\u4e3a\u7a7a")
    @Size(max = 255, message = "\u63a5\u53e3\u5730\u5740\u4e0d\u80fd\u8d85\u8fc7255\u4e2a\u5b57\u7b26")
    public String getBaseUrl()
    {
        return baseUrl;
    }

    public void setBaseUrl(String baseUrl)
    {
        this.baseUrl = baseUrl;
    }

    @Size(max = 512)
    public String getApiKey()
    {
        return apiKey;
    }

    public void setApiKey(String apiKey)
    {
        this.apiKey = apiKey;
    }

    public String getHasApiKey()
    {
        return hasApiKey;
    }

    public void setHasApiKey(String hasApiKey)
    {
        this.hasApiKey = hasApiKey;
    }

    @NotBlank(message = "\u6a21\u578b\u540d\u4e0d\u80fd\u4e3a\u7a7a")
    @Size(max = 100, message = "\u6a21\u578b\u540d\u4e0d\u80fd\u8d85\u8fc7100\u4e2a\u5b57\u7b26")
    public String getModelName()
    {
        return modelName;
    }

    public void setModelName(String modelName)
    {
        this.modelName = modelName;
    }

    @Min(5)
    @Max(300)
    public Integer getTimeoutSeconds()
    {
        return timeoutSeconds;
    }

    public void setTimeoutSeconds(Integer timeoutSeconds)
    {
        this.timeoutSeconds = timeoutSeconds;
    }

    @Min(1)
    @Max(128000)
    public Integer getMaxTokens()
    {
        return maxTokens;
    }

    public void setMaxTokens(Integer maxTokens)
    {
        this.maxTokens = maxTokens;
    }

    @Size(max = 32)
    public String getImageSize()
    {
        return imageSize;
    }

    public void setImageSize(String imageSize)
    {
        this.imageSize = imageSize;
    }

    @Size(max = 2000)
    public String getSystemPrompt()
    {
        return systemPrompt;
    }

    public void setSystemPrompt(String systemPrompt)
    {
        this.systemPrompt = systemPrompt;
    }

    public String getIsDefault()
    {
        return isDefault;
    }

    public void setIsDefault(String isDefault)
    {
        this.isDefault = isDefault;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public Integer getSort()
    {
        return sort;
    }

    public void setSort(Integer sort)
    {
        this.sort = sort;
    }
}
