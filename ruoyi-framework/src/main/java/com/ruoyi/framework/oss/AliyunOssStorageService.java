package com.ruoyi.framework.oss;

import java.io.InputStream;
import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;
import com.aliyun.oss.ClientBuilderConfiguration;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectRequest;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.utils.file.MimeTypeUtils;

/**
 * ????÷???????????????? OSS????????? /common/upload??
 */
public class AliyunOssStorageService
{
    private static final Logger log = LoggerFactory.getLogger(AliyunOssStorageService.class);

    private final CdnOssProperties properties;

    private OSS ossClient;

    public AliyunOssStorageService(CdnOssProperties properties)
    {
        this.properties = properties;
    }

    @PostConstruct
    public void init()
    {
        if (!isEnabled())
        {
            log.info("OSS inactive, keep local disk upload");
            return;
        }
        ClientBuilderConfiguration conf = new ClientBuilderConfiguration();
        int timeout = properties.getTimeout() > 0 ? properties.getTimeout() : 60000;
        conf.setConnectionTimeout(timeout);
        conf.setSocketTimeout(timeout);
        String endpoint = withScheme(properties.getUploadUrl());
        ossClient = new OSSClientBuilder().build(endpoint, properties.getAccessKeyId(), properties.getAccessKeySecret(), conf);
        log.info("OSS client ready, bucket={}, endpoint={}", properties.getBucket(), endpoint);
    }

    @PreDestroy
    public void destroy()
    {
        if (ossClient != null)
        {
            ossClient.shutdown();
        }
    }

    public boolean isEnabled()
    {
        return properties.isActive()
                && StringUtils.isNotEmpty(properties.getBucket())
                && StringUtils.isNotEmpty(properties.getUploadUrl())
                && StringUtils.isNotEmpty(properties.getAccessKeyId())
                && StringUtils.isNotEmpty(properties.getAccessKeySecret());
    }

    public String upload(MultipartFile file) throws Exception
    {
        return upload(file, MimeTypeUtils.DEFAULT_ALLOWED_EXTENSION);
    }

    public String upload(MultipartFile file, String[] allowedExtension) throws Exception
    {
        if (!isEnabled() || ossClient == null)
        {
            throw new IllegalStateException("OSS δ????????δ????");
        }
        FileUploadUtils.assertAllowed(file, allowedExtension);
        String objectKey = buildObjectKey(FileUploadUtils.extractFilename(file));
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(file.getSize());
        if (StringUtils.isNotEmpty(file.getContentType()))
        {
            metadata.setContentType(file.getContentType());
        }
        try (InputStream in = file.getInputStream())
        {
            ossClient.putObject(new PutObjectRequest(properties.getBucket(), objectKey, in, metadata));
        }
        return publicUrl(objectKey);
    }

    private String buildObjectKey(String relativeName)
    {
        String dir = properties.getMainDir();
        if (StringUtils.isEmpty(dir))
        {
            dir = "upload/";
        }
        if (dir.startsWith("/"))
        {
            dir = dir.substring(1);
        }
        if (!dir.endsWith("/"))
        {
            dir = dir + "/";
        }
        return dir + relativeName.replace('\\', '/');
    }

    private String publicUrl(String objectKey)
    {
        String host = StringUtils.isNotEmpty(properties.getDownloadUrl()) ? properties.getDownloadUrl() : properties.getUploadUrl();
        host = host.replaceFirst("^https?://", "").replaceAll("/+$", "");
        String bucket = properties.getBucket();
        if (host.startsWith(bucket + "."))
        {
            return "https://" + host + "/" + objectKey;
        }
        if (host.contains("aliyuncs.com"))
        {
            return "https://" + bucket + "." + host + "/" + objectKey;
        }
        return "https://" + host + "/" + objectKey;
    }

    private String withScheme(String host)
    {
        if (host.startsWith("http://") || host.startsWith("https://"))
        {
            return host;
        }
        return "https://" + host;
    }
}
