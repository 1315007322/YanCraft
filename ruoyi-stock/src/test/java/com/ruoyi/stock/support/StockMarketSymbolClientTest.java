package com.ruoyi.stock.support;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.List;
import org.junit.Test;
import com.ruoyi.stock.domain.StockSymbol;

public class StockMarketSymbolClientTest
{
    @Test
    public void shouldParseEastMoneySuggestPayload()
    {
        String json = "{\"QuotationCodeTable\":{\"Data\":["
                + "{\"Code\":\"600519\",\"Name\":\"Kweichow Moutai\"},"
                + "{\"Code\":\"AAPL\",\"Name\":\"Apple\"},"
                + "{\"Code\":\"000001\",\"Name\":\"Ping An Bank\"}"
                + "]}}";
        List<StockSymbol> rows = new StockMarketSymbolClient().parse(json);
        assertEquals(2, rows.size());
        assertEquals("600519", rows.get(0).getStockCode());
        assertEquals("000001", rows.get(1).getStockCode());
    }

    @Test
    public void shouldReturnEmptyWhenPayloadIsBroken()
    {
        assertTrue(new StockMarketSymbolClient().parse("{").isEmpty());
        assertTrue(new StockMarketSymbolClient().parse("").isEmpty());
    }
}
