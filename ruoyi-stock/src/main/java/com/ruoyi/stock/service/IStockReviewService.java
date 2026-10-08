package com.ruoyi.stock.service;

import java.util.Date;
import java.util.List;
import com.ruoyi.stock.domain.StockReview;
import com.ruoyi.stock.domain.StockReviewDayMark;
import com.ruoyi.stock.domain.StockReviewStatistics;
import com.ruoyi.stock.domain.StockReviewTemplate;
import com.ruoyi.stock.domain.StockReviewTrade;
import com.ruoyi.stock.domain.StockSymbol;

/**
 * Personal daily stock review.
 */
public interface IStockReviewService
{
    List<StockReview> selectReviewList(StockReview query);

    List<StockReviewTrade> selectTradeList(StockReviewTrade query);

    StockReview selectReviewById(Long reviewId, Long ownerUserId);

    StockReview selectReviewByDate(Date reviewDate, Long ownerUserId);

    List<StockReviewDayMark> selectCalendarMarks(int year, int month, Long ownerUserId);

    StockReviewStatistics selectMonthStatistics(int year, int month, Long ownerUserId);

    List<StockReviewTrade> selectPreviousTrades(Date beforeDate, Long ownerUserId);

    int saveReview(StockReview review);

    int deleteReviews(Long[] reviewIds, Long ownerUserId, String updateBy);

    List<StockReviewTemplate> selectTemplates(Long ownerUserId);

    int saveMyTemplate(StockReviewTemplate template);

    int deleteMyTemplate(Long templateId, Long ownerUserId, String updateBy);

    List<StockSymbol> searchSymbols(String keyword, Long ownerUserId);
}
