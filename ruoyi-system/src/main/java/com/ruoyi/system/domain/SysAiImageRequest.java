package com.ruoyi.system.domain;

/**
 * Generate an image with a stored AI profile.
 */
public class SysAiImageRequest
{
    private Long configId;

    private String prompt;

    private String size;

    public Long getConfigId()
    {
        return configId;
    }

    public void setConfigId(Long configId)
    {
        this.configId = configId;
    }

    public String getPrompt()
    {
        return prompt;
    }

    public void setPrompt(String prompt)
    {
        this.prompt = prompt;
    }

    public String getSize()
    {
        return size;
    }

    public void setSize(String size)
    {
        this.size = size;
    }
}
