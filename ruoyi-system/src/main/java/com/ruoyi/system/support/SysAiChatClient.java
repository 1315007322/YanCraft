package com.ruoyi.system.support;

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
 * OpenAI-compatible /chat/completions caller.
 */
@Component
public class SysAiChatClient
{
    private static final Logger log = LoggerFactory.getLogger(SysAiChatClient.class);

    public String complete(SysAiConfig config, String prompt)
    {
        if (config == null || StringUtils.isEmpty(config.getApiKey()))
        {
            throw new ServiceException("AI\u914d\u7f6e\u4e0d\u5b58\u5728\u6216\u672a\u586b API Key");
        }
        if (StringUtils.isEmpty(prompt))
        {
            throw new ServiceException("\u8bf7\u5148\u586b\u5199\u6b63\u6587");
        }
        JSONObject body = new JSONObject();
        body.put("model", config.getModelName());
        JSONArray messages = new JSONArray();
        if (StringUtils.isNotEmpty(config.getSystemPrompt()))
        {
            JSONObject system = new JSONObject();
            system.put("role", "system");
            system.put("content", config.getSystemPrompt().trim());
            messages.add(system);
        }
        JSONObject user = new JSONObject();
        user.put("role", "user");
        user.put("content", prompt.trim());
        messages.add(user);
        body.put("messages", messages);
        if (config.getMaxTokens() != null)
        {
            body.put("max_tokens", config.getMaxTokens());
        }
        JSONObject json = post(config, body);
        String text = readText(json);
        if (StringUtils.isEmpty(text))
        {
            throw new ServiceException("AI \u672a\u8fd4\u56de\u6587\u672c");
        }
        return text.trim();
    }

    private JSONObject post(SysAiConfig config, JSONObject body)
    {
        String url = chatUrl(config.getBaseUrl());
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
            log.warn("AI chat HTTP {} from {}", Integer.valueOf(ex.getRawStatusCode()), url);
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
            throw new ServiceException("AI \u5bf9\u8bdd\u5931\u8d25\uff1aHTTP " + ex.getRawStatusCode());
        }
        catch (Exception ex)
        {
            log.warn("AI chat call failed: {}", ex.getMessage());
            throw new ServiceException("AI \u5bf9\u8bdd\u5931\u8d25\uff1a" + ex.getMessage());
        }
    }

    private String readText(JSONObject json)
    {
        JSONArray choices = json.getJSONArray("choices");
        if (choices == null || choices.isEmpty())
        {
            return null;
        }
        JSONObject first = choices.getJSONObject(0);
        JSONObject message = first.getJSONObject("message");
        if (message != null)
        {
            String content = message.getString("content");
            if (StringUtils.isNotEmpty(content))
            {
                return content;
            }
        }
        return first.getString("text");
    }

    private String chatUrl(String baseUrl)
    {
        String base = baseUrl.trim();
        while (base.endsWith("/"))
        {
            base = base.substring(0, base.length() - 1);
        }
        if (base.endsWith("/v1"))
        {
            return base + "/chat/completions";
        }
        return base + "/v1/chat/completions";
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
        return "AI \u5bf9\u8bdd\u5931\u8d25";
    }
}
