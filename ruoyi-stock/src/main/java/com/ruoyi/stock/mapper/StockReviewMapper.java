package com.ruoyi.stock.mapper;

import java.util.Date;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.stock.domain.StockReview;
import com.ruoyi.stock.domain.StockReviewDayMark;
import com.ruoyi.stock.domain.StockReviewStatistics;
import com.ruoyi.stock.domain.StockReviewTrade;
import com.ruoyi.stock.domain.StockSymbol;

/**
 * Daily stock review mapper.
 */
public interface StockReviewMapper
{
    List<StockReview> selectReviewList(StockReview query);

    StockReview selectReviewById(@Param("reviewId") Long reviewId, @Param("ownerUserId") Long ownerUserId);

    StockReview selectReviewByDate(@Param("reviewDate") Date reviewDate, @Param("ownerUserId") Long ownerUserId);

    List<StockReviewDayMark> selectCalendarMarks(@Param("ownerUserId") Long ownerUserId,
            @Param("beginDate") Date beginDate, @Param("endDate") Date endDate);

    StockReviewStatistics selectMonthStatistics(@Param("ownerUserId") Long ownerUserId,
            @Param("beginDate") Date beginDate, @Param("endDate") Date endDate);

    String selectTopResultTag(@Param("ownerUserId") Long ownerUserId, @Param("beginDate") Date beginDate,
            @Param("endDate") Date endDate);

    int insertReview(StockReview review);

    int updateReview(StockReview review);

    int deleteReviews(@Param("reviewIds") Long[] reviewIds, @Param("ownerUserId") Long ownerUserId,
            @Param("updateBy") String updateBy);

    List<StockReviewTrade> selectTradesByReviewId(@Param("reviewId") Long reviewId,
            @Param("ownerUserId") Long ownerUserId);

    List<StockReviewTrade> selectPreviousTrades(@Param("ownerUserId") Long ownerUserId,
            @Param("beforeDate") Date beforeDate);

    List<StockSymbol> selectSymbols(@Param("ownerUserId") Long ownerUserId, @Param("keyword") String keyword,
            @Param("limit") int limit);

    int insertTrade(StockReviewTrade trade);

    int updateTrade(StockReviewTrade trade);

    int deleteTradesNotIn(@Param("reviewId") Long reviewId, @Param("ownerUserId") Long ownerUserId,
            @Param("keepIds") List<Long> keepIds, @Param("updateBy") String updateBy);

    int deleteTradesByReviewIds(@Param("reviewIds") Long[] reviewIds, @Param("ownerUserId") Long ownerUserId,
            @Param("updateBy") String updateBy);
}
