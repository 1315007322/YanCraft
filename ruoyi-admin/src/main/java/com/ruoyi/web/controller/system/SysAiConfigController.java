package com.ruoyi.web.controller.system;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.file.ByteArrayMultipartFile;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.utils.file.FileUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.framework.config.ServerConfig;
import com.ruoyi.framework.oss.AliyunOssStorageService;
import com.ruoyi.system.domain.SysAiChatRequest;
import com.ruoyi.system.domain.SysAiConfig;
import com.ruoyi.system.domain.SysAiImageRequest;
import com.ruoyi.system.service.ISysAiConfigService;
import com.ruoyi.system.support.SysAiChatClient;
import com.ruoyi.system.support.SysAiImageClient;

/**
 * AI config CRUD for system module.
 */
@RestController
@RequestMapping("/system/ai")
public class SysAiConfigController extends BaseController
{
    private static final Logger log = LoggerFactory.getLogger(SysAiConfigController.class);

    @Autowired
    private ISysAiConfigService aiConfigService;

    @Autowired
    private SysAiImageClient aiImageClient;

    @Autowired
    private SysAiChatClient aiChatClient;

    @Autowired
    private AliyunOssStorageService ossStorage;

    @Autowired
    private ServerConfig serverConfig;

    @PreAuthorize("@ss.hasPermi('system:ai:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysAiConfig query)
    {
        startPage();
        List<SysAiConfig> list = aiConfigService.selectAiConfigList(query);
        return getDataTable(list);
    }

    /**
     * Enabled profiles for later business pickers (cover, writing, etc).
     */
    @PreAuthorize("@ss.hasAnyPermi('system:ai:query,cms:article:add,cms:article:edit')")
    @GetMapping("/options")
    public AjaxResult options(@RequestParam(value = "purpose", required = false) String purpose)
    {
        return success(aiConfigService.selectEnabledOptions(purpose));
    }

    /**
     * Generate an image with a stored profile and upload it like /common/upload.
     */
    @PreAuthorize("@ss.hasAnyPermi('system:ai:query,cms:article:add,cms:article:edit')")
    @PostMapping("/image")
    public AjaxResult generateImage(@RequestBody SysAiImageRequest request)
    {
        if (request == null || StringUtils.isEmpty(request.getPrompt()))
        {
            return error("\u8bf7\u5148\u586b\u5199\u5c01\u9762\u63d0\u793a\u8bcd");
        }
        SysAiConfig config = resolveConfig(request.getConfigId(), SysAiConfig.PURPOSE_IMAGE);
        byte[] bytes = aiImageClient.generate(config, request.getPrompt(), request.getSize());
        try
        {
            String ext = isPng(bytes) ? "png" : "jpg";
            String contentType = isPng(bytes) ? "image/png" : "image/jpeg";
            MultipartFile file = new ByteArrayMultipartFile("file",
                    "ai-cover-" + IdUtils.fastSimpleUUID() + "." + ext, contentType, bytes);
            String stored = storeFile(file);
            String url = isHttpUrl(stored) ? stored : serverConfig.getUrl() + stored;
            AjaxResult ajax = AjaxResult.success();
            ajax.put("url", url);
            ajax.put("fileName", stored);
            ajax.put("newFileName", FileUtils.getName(stored));
            return ajax;
        }
        catch (ServiceException ex)
        {
            throw ex;
        }
        catch (Exception ex)
        {
            log.error("store AI cover failed", ex);
            return error("\u56fe\u7247\u4e0a\u4f20\u5931\u8d25\uff1a" + ex.getMessage());
        }
    }

    /**
     * Complete a chat prompt with a stored profile (article summary, etc).
     */
    @PreAuthorize("@ss.hasAnyPermi('system:ai:query,cms:article:add,cms:article:edit')")
    @PostMapping("/chat")
    public AjaxResult generateChat(@RequestBody SysAiChatRequest request)
    {
        if (request == null || StringUtils.isEmpty(request.getPrompt()))
        {
            return error("\u8bf7\u5148\u586b\u5199\u6b63\u6587");
        }
        SysAiConfig config = resolveConfig(request.getConfigId(), SysAiConfig.PURPOSE_CHAT);
        String text = aiChatClient.complete(config, request.getPrompt());
        return AjaxResult.success("\u64cd\u4f5c\u6210\u529f", text);
    }

    private SysAiConfig resolveConfig(Long configId, String purpose)
    {
        SysAiConfig config;
        if (configId != null)
        {
            config = aiConfigService.selectAiConfigSecretById(configId);
        }
        else
        {
            List<SysAiConfig> options = aiConfigService.selectEnabledOptions(purpose);
            if (options == null || options.isEmpty())
            {
                String tip = SysAiConfig.PURPOSE_IMAGE.equals(purpose)
                        ? "\u8bf7\u5148\u5728\u7cfb\u7edf\u7ba1\u7406-\u300cAI\u914d\u7f6e\u300d\u4e2d\u65b0\u589e\u51fa\u56fe\u914d\u7f6e"
                        : "\u8bf7\u5148\u5728\u7cfb\u7edf\u7ba1\u7406-\u300cAI\u914d\u7f6e\u300d\u4e2d\u65b0\u589e\u5bf9\u8bdd\u914d\u7f6e";
                throw new ServiceException(tip);
            }
            config = aiConfigService.selectAiConfigSecretById(options.get(0).getConfigId());
        }
        if (config == null)
        {
            throw new ServiceException("AI \u914d\u7f6e\u4e0d\u5b58\u5728");
        }
        if (!purpose.equals(config.getPurpose()))
        {
            String tip = SysAiConfig.PURPOSE_IMAGE.equals(purpose)
                    ? "\u8bf7\u9009\u62e9\u7528\u9014\u4e3a\u300c\u51fa\u56fe\u300d\u7684\u914d\u7f6e"
                    : "\u8bf7\u9009\u62e9\u7528\u9014\u4e3a\u300c\u5bf9\u8bdd\u300d\u7684\u914d\u7f6e";
            throw new ServiceException(tip);
        }
        if (!"0".equals(config.getStatus()))
        {
            throw new ServiceException("\u8be5 AI \u914d\u7f6e\u5df2\u505c\u7528");
        }
        return config;
    }

    private String storeFile(MultipartFile file) throws Exception
    {
        if (ossStorage.isEnabled())
        {
            return ossStorage.upload(file);
        }
        return FileUploadUtils.upload(RuoYiConfig.getUploadPath(), file);
    }

    private boolean isHttpUrl(String path)
    {
        return StringUtils.startsWithIgnoreCase(path, "http://") || StringUtils.startsWithIgnoreCase(path, "https://");
    }

    private boolean isPng(byte[] bytes)
    {
        return bytes != null && bytes.length > 8
                && (bytes[0] & 0xFF) == 0x89
                && bytes[1] == 0x50
                && bytes[2] == 0x4E
                && bytes[3] == 0x47;
    }

    @PreAuthorize("@ss.hasPermi('system:ai:query')")
    @GetMapping("/{configId}")
    public AjaxResult getInfo(@PathVariable Long configId)
    {
        return success(aiConfigService.selectAiConfigById(configId));
    }

    @PreAuthorize("@ss.hasPermi('system:ai:add')")
    @Log(title = "AI\u914d\u7f6e", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysAiConfig config)
    {
        if (!aiConfigService.checkConfigNameUnique(config))
        {
            return error("\u65b0\u589e\u914d\u7f6e'" + config.getConfigName() + "'\u5931\u8d25\uff0c\u540d\u79f0\u5df2\u5b58\u5728");
        }
        config.setCreateBy(getUsername());
        return toAjax(aiConfigService.insertAiConfig(config));
    }

    @PreAuthorize("@ss.hasPermi('system:ai:edit')")
    @Log(title = "AI\u914d\u7f6e", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody SysAiConfig config)
    {
        if (!aiConfigService.checkConfigNameUnique(config))
        {
            return error("\u4fee\u6539\u914d\u7f6e'" + config.getConfigName() + "'\u5931\u8d25\uff0c\u540d\u79f0\u5df2\u5b58\u5728");
        }
        config.setUpdateBy(getUsername());
        return toAjax(aiConfigService.updateAiConfig(config));
    }

    @PreAuthorize("@ss.hasPermi('system:ai:remove')")
    @Log(title = "AI\u914d\u7f6e", businessType = BusinessType.DELETE)
    @DeleteMapping("/{configIds}")
    public AjaxResult remove(@PathVariable Long[] configIds)
    {
        return toAjax(aiConfigService.deleteAiConfigByIds(configIds));
    }
}
