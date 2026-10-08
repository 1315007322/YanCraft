package com.ruoyi.system.support;

import java.util.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.SysAiConfig;

/**
 * OpenAI-compatible /images/generations caller.
 */
@Component
public class SysAiImageClient
{
    private static final Logger log = LoggerFactory.getLogger(SysAiImageClient.class);

    public byte[] generate(SysAiConfig config, String prompt)
    {
        return generate(config, prompt, null);
    }

    public byte[] generate(SysAiConfig config, String prompt, String size)
    {
        if (config == null || StringUtils.isEmpty(config.getApiKey()))
        {
            throw new ServiceException("AI\u914d\u7f6e\u4e0d\u5b58\u5728\u6216\u672a\u586b API Key");
        }
        if (StringUtils.isEmpty(prompt))
        {
            throw new ServiceException("\u8bf7\u5148\u586b\u5199\u5c01\u9762\u63d0\u793a\u8bcd");
        }
        String text = prompt.trim();
        if (StringUtils.isNotEmpty(config.getSystemPrompt()))
        {
            text = config.getSystemPrompt().trim() + "\n" + text;
        }
        String imageSize = StringUtils.isNotEmpty(size) ? size.trim() : config.getImageSize();
        JSONObject body = new JSONObject();
        body.put("model", config.getModelName());
        body.put("prompt", text);
        body.put("n", Integer.valueOf(1));
        if (StringUtils.isNotEmpty(imageSize))
        {
            body.put("size", imageSize);
        }
        body.put("response_format", "b64_json");
        JSONObject json = post(config, body);
        byte[] image = readImage(config, json);
        if (image == null || image.length == 0)
        {
            throw new ServiceException("AI \u672a\u8fd4\u56de\u56fe\u7247\u6570\u636e");
        }
        return image;
    }

    private JSONObject post(SysAiConfig config, JSONObject body)
    {
        String url = imagesUrl(config.getBaseUrl());
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(config.getApiKey());
        RestTemplate rest = restTemplate(config);
        try
        {
            ResponseEntity<String> response = rest.exchange(url, HttpMethod.POST,
                    new HttpEntity<String>(body.toJSONString(), headers), String.class);
            if (response.getBody() == null)
            {
                throw new ServiceException("AI \u63a5\u53e3\u8fd4\u56de\u7a7a\u5185\u5bb9");
            }
            JSONObject json = JSON.parseObject(response.getBody());
            if (json != null && json.get("error") != null)
            {
                throw new ServiceException(errorMessage(json));
            }
            return json;
        }
        catch (ServiceException ex)
        {
            throw ex;
        }
        catch (HttpStatusCodeException ex)
        {
            log.warn("AI image HTTP {} from {}", Integer.valueOf(ex.getRawStatusCode()), url);
            String raw = ex.getResponseBodyAsString();
            JSONObject json = null;
            try
            {
                json = StringUtils.isEmpty(raw) ? null : JSON.parseObject(raw);
            }
            catch (Exception ignore)
            {
                json = null;
            }
            if (json != null)
            {
                throw new ServiceException(errorMessage(json));
            }
            throw new ServiceException("AI \u51fa\u56fe\u5931\u8d25\uff1aHTTP " + ex.getRawStatusCode());
        }
        catch (Exception ex)
        {
            log.warn("AI image call failed: {}", ex.getMessage());
            throw new ServiceException("AI \u51fa\u56fe\u5931\u8d25\uff1a" + ex.getMessage());
        }
    }

    private byte[] readImage(SysAiConfig config, JSONObject json)
    {
        JSONArray data = json.getJSONArray("data");
        if (data == null || data.isEmpty())
        {
            return null;
        }
        JSONObject first = data.getJSONObject(0);
        String b64 = first.getString("b64_json");
        if (StringUtils.isEmpty(b64))
        {
            b64 = first.getString("b64Json");
        }
        if (StringUtils.isNotEmpty(b64))
        {
            return Base64.getDecoder().decode(b64);
        }
        String imageUrl = first.getString("url");
        if (StringUtils.isEmpty(imageUrl))
        {
            return null;
        }
        RestTemplate rest = restTemplate(config);
        return rest.getForObject(imageUrl, byte[].class);
    }

    private String imagesUrl(String baseUrl)
    {
        String base = baseUrl.trim();
        while (base.endsWith("/"))
        {
            base = base.substring(0, base.length() - 1);
        }
        if (base.endsWith("/v1"))
        {
            return base + "/images/generations";
        }
        return base + "/v1/images/generations";
    }

    private RestTemplate restTemplate(SysAiConfig config)
    {
        int timeout = config.getTimeoutSeconds() == null ? 60 : config.getTimeoutSeconds().intValue();
        if (timeout < 5)
        {
            timeout = 5;
        }
        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
        factory.setConnectTimeout(15000);
        factory.setReadTimeout(timeout * 1000);
        return new RestTemplate(factory);
    }

    private String errorMessage(JSONObject json)
    {
        Object err = json.get("error");
        if (err instanceof JSONObject)
        {
            String msg = ((JSONObject) err).getString("message");
            if (StringUtils.isNotEmpty(msg))
            {
                return msg;
            }
        }
        String msg = json.getString("msg");
        if (StringUtils.isNotEmpty(msg))
        {
            return msg;
        }
        return "AI \u51fa\u56fe\u5931\u8d25";
    }
}
