package com.ruoyi.stock.support;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.stock.domain.StockSymbol;

/**
 * Best-effort A-share name lookup. Failures return empty so history still works.
 */
@Component
public class StockMarketSymbolClient
{
    private static final Logger log = LoggerFactory.getLogger(StockMarketSymbolClient.class);

    private static final String LOOKUP_URL = "https://searchapi.eastmoney.com/api/suggest/get";

    private static final String LOOKUP_TOKEN = "D43BF722C8E33BDC906FB84D85E326E8";

    private final ObjectMapper objectMapper = new ObjectMapper();

    public List<StockSymbol> search(String keyword)
    {
        if (StringUtils.isEmpty(keyword))
        {
            return Collections.emptyList();
        }
        HttpURLConnection connection = null;
        try
        {
            String query = "input=" + URLEncoder.encode(keyword, "UTF-8")
                    + "&type=14&token=" + LOOKUP_TOKEN + "&count=12";
            URL url = new URL(LOOKUP_URL + "?" + query);
            connection = (HttpURLConnection) url.openConnection();
            connection.setConnectTimeout(2000);
            connection.setReadTimeout(2500);
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Accept", "application/json");
            connection.setRequestProperty("User-Agent", "Mozilla/5.0");
            if (connection.getResponseCode() != 200)
            {
                return Collections.emptyList();
            }
            StringBuilder body = new StringBuilder();
            BufferedReader reader = new BufferedReader(
                    new InputStreamReader(connection.getInputStream(), StandardCharsets.UTF_8));
            try
            {
                String line;
                while ((line = reader.readLine()) != null)
                {
                    body.append(line);
                }
            }
            finally
            {
                reader.close();
            }
            return parse(body.toString());
        }
        catch (Exception ex)
        {
            log.warn("Stock symbol lookup skipped: {}", ex.getMessage());
            return Collections.emptyList();
        }
        finally
        {
            if (connection != null)
            {
                connection.disconnect();
            }
        }
    }

    List<StockSymbol> parse(String json)
    {
        if (StringUtils.isEmpty(json))
        {
            return Collections.emptyList();
        }
        try
        {
            JsonNode data = objectMapper.readTree(json).path("QuotationCodeTable").path("Data");
            if (!data.isArray())
            {
                return Collections.emptyList();
            }
            List<StockSymbol> rows = new ArrayList<StockSymbol>();
            for (JsonNode node : data)
            {
                String code = text(node, "Code");
                String name = text(node, "Name");
                if (StringUtils.isEmpty(code) || StringUtils.isEmpty(name))
                {
                    continue;
                }
                if (!code.matches("\\d{5,6}"))
                {
                    continue;
                }
                rows.add(new StockSymbol(code, name));
            }
            return rows;
        }
        catch (Exception ex)
        {
            log.warn("Stock symbol parse skipped: {}", ex.getMessage());
            return Collections.emptyList();
        }
    }

    private String text(JsonNode node, String field)
    {
        JsonNode value = node.path(field);
        return value.isMissingNode() || value.isNull() ? "" : value.asText("").trim();
    }
}
