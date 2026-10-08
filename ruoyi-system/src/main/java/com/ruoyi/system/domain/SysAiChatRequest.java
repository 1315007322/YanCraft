package com.ruoyi.system.domain;

/**
 * Complete a chat prompt with a stored AI profile.
 */
public class SysAiChatRequest
{
    private Long configId;

    private String prompt;

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
}
