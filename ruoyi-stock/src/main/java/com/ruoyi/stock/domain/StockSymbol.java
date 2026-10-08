package com.ruoyi.stock.domain;

/**
 * Search hit for trade entry. Code plus display name.
 */
public class StockSymbol
{
    private String stockCode;

    private String stockName;

    public StockSymbol()
    {
    }

    public StockSymbol(String stockCode, String stockName)
    {
        this.stockCode = stockCode;
        this.stockName = stockName;
    }

    public String getStockCode()
    {
        return stockCode;
    }

    public void setStockCode(String stockCode)
    {
        this.stockCode = stockCode;
    }

    public String getStockName()
    {
        return stockName;
    }

    public void setStockName(String stockName)
    {
        this.stockName = stockName;
    }
}
