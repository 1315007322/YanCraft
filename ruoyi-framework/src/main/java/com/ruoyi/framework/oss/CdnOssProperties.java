package com.ruoyi.framework.oss;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * 对象存储配置，对应 yml 中 cdn.oss
 */
@ConfigurationProperties(prefix = "cdn.oss")
public class CdnOssProperties
{
    private String name;

    private String type;

    private String bucket;

    private String uploadUrl;

    private String downloadUrl;

    private String accessKeyId;

    private String accessKeySecret;

    /** 对象前缀，例如 upload/ */
    private String mainDir = "upload/";

    /** 预签名有效期（毫秒） */
    private long validTime = 3600000L;

    /** 连接/读写超时（毫秒） */
    private int timeout = 600000;

    private boolean active;

    private String referer;

    private String localFolderUrl;

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public String getBucket()
    {
        return bucket;
    }

    public void setBucket(String bucket)
    {
        this.bucket = bucket;
    }

    public String getUploadUrl()
    {
        return uploadUrl;
    }

    public void setUploadUrl(String uploadUrl)
    {
        this.uploadUrl = uploadUrl;
    }

    public String getDownloadUrl()
    {
        return downloadUrl;
    }

    public void setDownloadUrl(String downloadUrl)
    {
        this.downloadUrl = downloadUrl;
    }

    public String getAccessKeyId()
    {
        return accessKeyId;
    }

    public void setAccessKeyId(String accessKeyId)
    {
        this.accessKeyId = accessKeyId;
    }

    public String getAccessKeySecret()
    {
        return accessKeySecret;
    }

    public void setAccessKeySecret(String accessKeySecret)
    {
        this.accessKeySecret = accessKeySecret;
    }

    public String getMainDir()
    {
        return mainDir;
    }

    public void setMainDir(String mainDir)
    {
        this.mainDir = mainDir;
    }

    public long getValidTime()
    {
        return validTime;
    }

    public void setValidTime(long validTime)
    {
        this.validTime = validTime;
    }

    public int getTimeout()
    {
        return timeout;
    }

    public void setTimeout(int timeout)
    {
        this.timeout = timeout;
    }

    public boolean isActive()
    {
        return active;
    }

    public void setActive(boolean active)
    {
        this.active = active;
    }

    public String getReferer()
    {
        return referer;
    }

    public void setReferer(String referer)
    {
        this.referer = referer;
    }

    public String getLocalFolderUrl()
    {
        return localFolderUrl;
    }

    public void setLocalFolderUrl(String localFolderUrl)
    {
        this.localFolderUrl = localFolderUrl;
    }
}
