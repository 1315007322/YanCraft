package com.ruoyi.stock.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.stock.domain.StockReview;
import com.ruoyi.stock.domain.StockReviewTemplate;
import com.ruoyi.stock.domain.StockReviewTrade;
import com.ruoyi.stock.domain.StockSymbol;
import com.ruoyi.stock.mapper.StockReviewMapper;
import com.ruoyi.stock.mapper.StockReviewTemplateMapper;
import com.ruoyi.stock.service.impl.StockReviewServiceImpl;
import com.ruoyi.stock.support.StockMarketSymbolClient;

@RunWith(MockitoJUnitRunner.class)
public class StockReviewServiceImplTest
{
    @Mock
    private StockReviewMapper stockReviewMapper;

    @Mock
    private StockReviewTemplateMapper stockReviewTemplateMapper;

    @Mock
    private StockMarketSymbolClient stockMarketSymbolClient;

    @InjectMocks
    private StockReviewServiceImpl stockReviewService;

    private Date day;

    @Before
    public void setUp()
    {
        day = DateUtils.parseDate("2026-09-29");
    }

    @Test
    public void shouldInsertWhenDateIsNew()
    {
        StockReview review = new StockReview();
        review.setOwnerUserId(1L);
        review.setReviewDate(day);
        review.setMood("0");
        review.setCreateBy("admin");
        when(stockReviewMapper.selectReviewByDate(any(Date.class), eq(1L))).thenReturn(null);
        when(stockReviewMapper.insertReview(any(StockReview.class))).thenAnswer(invocation -> {
            StockReview saved = invocation.getArgument(0);
            saved.setReviewId(9L);
            return 1;
        });

        assertEquals(1, stockReviewService.saveReview(review));
        verify(stockReviewMapper).insertReview(any(StockReview.class));
        verify(stockReviewMapper).deleteTradesNotIn(eq(9L), eq(1L), eq(Collections.<Long>emptyList()), any());
    }

    @Test
    public void shouldReuseExistingRowOnSameDate()
    {
        StockReview existing = new StockReview();
        existing.setReviewId(3L);
        StockReview review = new StockReview();
        review.setOwnerUserId(1L);
        review.setReviewDate(day);
        review.setUpdateBy("admin");
        when(stockReviewMapper.selectReviewByDate(any(Date.class), eq(1L))).thenReturn(existing);
        when(stockReviewMapper.updateReview(any(StockReview.class))).thenReturn(1);

        stockReviewService.saveReview(review);
        assertEquals(Long.valueOf(3L), review.getReviewId());
        verify(stockReviewMapper).updateReview(any(StockReview.class));
        verify(stockReviewMapper, never()).insertReview(any(StockReview.class));
    }

    @Test(expected = ServiceException.class)
    public void shouldRejectInvalidMood()
    {
        StockReview review = new StockReview();
        review.setOwnerUserId(1L);
        review.setReviewDate(day);
        review.setMood("9");
        stockReviewService.saveReview(review);
    }

    @Test
    public void shouldSkipBlankTradesAndRequireCode()
    {
        StockReview review = new StockReview();
        review.setOwnerUserId(1L);
        review.setReviewDate(day);
        review.setUpdateBy("admin");
        StockReviewTrade blank = new StockReviewTrade();
        StockReviewTrade filled = new StockReviewTrade();
        filled.setStockCode(" 600519 ");
        filled.setQuantity(new BigDecimal("100"));
        review.setTrades(Arrays.asList(blank, filled));
        when(stockReviewMapper.selectReviewByDate(any(Date.class), eq(1L))).thenReturn(null);
        when(stockReviewMapper.insertReview(any(StockReview.class))).thenAnswer(invocation -> {
            ((StockReview) invocation.getArgument(0)).setReviewId(8L);
            return 1;
        });
        when(stockReviewMapper.insertTrade(any(StockReviewTrade.class))).thenAnswer(invocation -> {
            ((StockReviewTrade) invocation.getArgument(0)).setTradeId(21L);
            return 1;
        });

        stockReviewService.saveReview(review);

        ArgumentCaptor<StockReviewTrade> captor = ArgumentCaptor.forClass(StockReviewTrade.class);
        verify(stockReviewMapper).insertTrade(captor.capture());
        assertEquals("600519", captor.getValue().getStockCode());
        assertEquals("600519", captor.getValue().getStockName());
        verify(stockReviewMapper).deleteTradesNotIn(eq(8L), eq(1L), eq(Collections.singletonList(21L)), eq("admin"));
    }

    @Test
    public void shouldCopyPreviousTradesWithoutNumbers()
    {
        StockReviewTrade source = new StockReviewTrade();
        source.setStockCode("000001");
        source.setStockName("Ping An");
        source.setDirection("1");
        source.setResultTag("0");
        source.setQuantity(new BigDecimal("200"));
        source.setPrice(new BigDecimal("10.5"));
        source.setProfitLoss(new BigDecimal("30"));
        when(stockReviewMapper.selectPreviousTrades(eq(1L), any(Date.class))).thenReturn(Collections.singletonList(source));

        StockReviewTrade copy = stockReviewService.selectPreviousTrades(day, 1L).get(0);
        assertEquals("000001", copy.getStockCode());
        assertEquals("1", copy.getDirection());
        assertNull(copy.getTradeId());
        assertNull(copy.getQuantity());
        assertNull(copy.getPrice());
        assertNull(copy.getProfitLoss());
    }

    @Test
    public void shouldSaveUserTemplateWithoutSystemCode()
    {
        StockReviewTemplate template = new StockReviewTemplate();
        template.setOwnerUserId(1L);
        template.setTemplateName(" My Day ");
        template.setTemplateCode("watch");
        template.setMood("0");
        template.setCreateBy("admin");
        when(stockReviewTemplateMapper.insertTemplate(any(StockReviewTemplate.class))).thenReturn(1);

        assertEquals(1, stockReviewService.saveMyTemplate(template));
        assertNull(template.getTemplateCode());
        assertEquals("My Day", template.getTemplateName());
        verify(stockReviewTemplateMapper).insertTemplate(template);
    }

    @Test(expected = ServiceException.class)
    public void shouldRejectBlankTemplateName()
    {
        StockReviewTemplate template = new StockReviewTemplate();
        template.setOwnerUserId(1L);
        template.setTemplateName("  ");
        stockReviewService.saveMyTemplate(template);
    }

    @Test(expected = ServiceException.class)
    public void shouldNotDeleteMissingOrSystemTemplate()
    {
        when(stockReviewTemplateMapper.deleteTemplate(eq(1L), eq(1L), eq("admin"))).thenReturn(0);
        stockReviewService.deleteMyTemplate(1L, 1L, "admin");
    }

    @Test
    public void shouldPreferHistorySymbolsThenMarketHits()
    {
        when(stockReviewMapper.selectSymbols(eq(1L), eq("600"), eq(12)))
                .thenReturn(Collections.singletonList(new StockSymbol("600519", "Moutai")));
        when(stockMarketSymbolClient.search("600")).thenReturn(Arrays.asList(
                new StockSymbol("600519", "Kweichow Moutai"),
                new StockSymbol("600000", "Pudong Dev")));

        List<StockSymbol> rows = stockReviewService.searchSymbols("600", 1L);
        assertEquals(2, rows.size());
        assertEquals("600519", rows.get(0).getStockCode());
        assertEquals("Moutai", rows.get(0).getStockName());
        assertEquals("600000", rows.get(1).getStockCode());
    }
}
