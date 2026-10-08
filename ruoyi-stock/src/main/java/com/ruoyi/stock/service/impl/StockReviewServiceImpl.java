package com.ruoyi.stock.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.stock.domain.StockReview;
import com.ruoyi.stock.domain.StockReviewDayMark;
import com.ruoyi.stock.domain.StockReviewStatistics;
import com.ruoyi.stock.domain.StockReviewTrade;
import com.ruoyi.stock.domain.StockReviewTemplate;
import com.ruoyi.stock.domain.StockSymbol;
import com.ruoyi.stock.mapper.StockReviewMapper;
import com.ruoyi.stock.mapper.StockReviewTemplateMapper;
import com.ruoyi.stock.service.IStockReviewService;
import com.ruoyi.stock.support.StockMarketSymbolClient;

/**
 * Daily review with optional trades. One live row per user per date.
 */
@Service
public class StockReviewServiceImpl implements IStockReviewService
{
    private static final Set<String> MOODS = setOf("0", "1", "2", "3", "4");

    private static final Set<String> DIRECTIONS = setOf("0", "1", "2");

    private static final Set<String> RESULT_TAGS = setOf("0", "1", "2", "3", "4", "5");

    @Autowired
    private StockReviewMapper stockReviewMapper;

    @Autowired
    private StockReviewTemplateMapper stockReviewTemplateMapper;

    @Autowired
    private StockMarketSymbolClient stockMarketSymbolClient;

    @Override
    public List<StockReview> selectReviewList(StockReview query)
    {
        return stockReviewMapper.selectReviewList(query);
    }

    @Override
    public List<StockReviewTrade> selectTradeList(StockReviewTrade query)
    {
        return stockReviewMapper.selectTradeList(query);
    }

    @Override
    public StockReview selectReviewById(Long reviewId, Long ownerUserId)
    {
        StockReview review = stockReviewMapper.selectReviewById(reviewId, ownerUserId);
        if (review == null)
        {
            throw new ServiceException("Review not found");
        }
        review.setTrades(stockReviewMapper.selectTradesByReviewId(reviewId, ownerUserId));
        return review;
    }

    @Override
    public StockReview selectReviewByDate(Date reviewDate, Long ownerUserId)
    {
        Date day = normalizeDate(reviewDate);
        StockReview review = stockReviewMapper.selectReviewByDate(day, ownerUserId);
        if (review == null)
        {
            review = new StockReview();
            review.setReviewDate(day);
            review.setTrades(new ArrayList<StockReviewTrade>());
            return review;
        }
        review.setTrades(stockReviewMapper.selectTradesByReviewId(review.getReviewId(), ownerUserId));
        return review;
    }

    @Override
    public List<StockReviewDayMark> selectCalendarMarks(int year, int month, Long ownerUserId)
    {
        Date[] range = monthRange(year, month);
        return stockReviewMapper.selectCalendarMarks(ownerUserId, range[0], range[1]);
    }

    @Override
    public StockReviewStatistics selectMonthStatistics(int year, int month, Long ownerUserId)
    {
        Date[] range = monthRange(year, month);
        StockReviewStatistics statistics = stockReviewMapper.selectMonthStatistics(ownerUserId, range[0], range[1]);
        if (statistics == null)
        {
            statistics = new StockReviewStatistics();
            statistics.setReviewDays(0L);
            statistics.setTradeDays(0L);
            statistics.setProfitLoss(BigDecimal.ZERO);
        }
        statistics.setTopResultTag(stockReviewMapper.selectTopResultTag(ownerUserId, range[0], range[1]));
        return statistics;
    }

    @Override
    public List<StockReviewTrade> selectPreviousTrades(Date beforeDate, Long ownerUserId)
    {
        Date day = normalizeDate(beforeDate);
        List<StockReviewTrade> source = stockReviewMapper.selectPreviousTrades(ownerUserId, day);
        List<StockReviewTrade> copies = new ArrayList<StockReviewTrade>();
        int sort = 0;
        for (StockReviewTrade item : source)
        {
            StockReviewTrade copy = new StockReviewTrade();
            copy.setStockCode(item.getStockCode());
            copy.setStockName(item.getStockName());
            copy.setDirection(item.getDirection());
            copy.setResultTag(item.getResultTag());
            copy.setSort(sort++);
            copies.add(copy);
        }
        return copies;
    }

    @Override
    @Transactional
    public int saveReview(StockReview review)
    {
        Date day = normalizeDate(review.getReviewDate());
        review.setReviewDate(day);
        normalizeReview(review);

        StockReview existingByDate = stockReviewMapper.selectReviewByDate(day, review.getOwnerUserId());
        if (review.getReviewId() == null)
        {
            if (existingByDate != null)
            {
                review.setReviewId(existingByDate.getReviewId());
            }
        }
        else
        {
            StockReview existing = stockReviewMapper.selectReviewById(review.getReviewId(), review.getOwnerUserId());
            if (existing == null)
            {
                throw new ServiceException("Review not found");
            }
            if (existingByDate != null && !existingByDate.getReviewId().equals(review.getReviewId()))
            {
                throw new ServiceException("This date already has a review");
            }
        }

        int rows;
        if (review.getReviewId() == null)
        {
            rows = stockReviewMapper.insertReview(review);
        }
        else
        {
            rows = stockReviewMapper.updateReview(review);
        }
        syncTrades(review);
        return rows;
    }

    @Override
    @Transactional
    public int deleteReviews(Long[] reviewIds, Long ownerUserId, String updateBy)
    {
        if (reviewIds == null || reviewIds.length == 0)
        {
            return 0;
        }
        stockReviewMapper.deleteTradesByReviewIds(reviewIds, ownerUserId, updateBy);
        return stockReviewMapper.deleteReviews(reviewIds, ownerUserId, updateBy);
    }

    @Override
    public List<StockReviewTemplate> selectTemplates(Long ownerUserId)
    {
        List<StockReviewTemplate> rows = stockReviewTemplateMapper.selectTemplateList(ownerUserId);
        if (rows == null)
        {
            return Collections.emptyList();
        }
        for (StockReviewTemplate row : rows)
        {
            row.setSystemTemplate(StockReviewTemplate.SYSTEM_OWNER_ID.equals(row.getOwnerUserId()));
        }
        return rows;
    }

    @Override
    public int saveMyTemplate(StockReviewTemplate template)
    {
        if (StringUtils.isEmpty(template.getTemplateName()))
        {
            throw new ServiceException("Template name is required");
        }
        String name = template.getTemplateName().trim();
        if (name.length() > 40)
        {
            throw new ServiceException("Template name is too long");
        }
        template.setTemplateName(name);
        template.setOwnerUserId(template.getOwnerUserId());
        template.setTemplateCode(null);
        template.setSummary(blankToNull(template.getSummary()));
        if (template.getSummary() != null && template.getSummary().length() > 200)
        {
            throw new ServiceException("Template summary is too long");
        }
        if (StringUtils.isEmpty(template.getMood()))
        {
            template.setMood("0");
        }
        if (!MOODS.contains(template.getMood()))
        {
            throw new ServiceException("Invalid mood");
        }
        if (template.getScore() != null && template.getScore() == 0)
        {
            template.setScore(null);
        }
        if (template.getScore() != null && (template.getScore() < 1 || template.getScore() > 5))
        {
            throw new ServiceException("Score must be 1 to 5");
        }
        if (template.getSort() == null)
        {
            template.setSort(100);
        }
        return stockReviewTemplateMapper.insertTemplate(template);
    }

    @Override
    public int deleteMyTemplate(Long templateId, Long ownerUserId, String updateBy)
    {
        int rows = stockReviewTemplateMapper.deleteTemplate(templateId, ownerUserId, updateBy);
        if (rows == 0)
        {
            throw new ServiceException("Template not found");
        }
        return rows;
    }

    @Override
    public List<StockSymbol> searchSymbols(String keyword, Long ownerUserId)
    {
        String query = keyword == null ? "" : keyword.trim();
        if (query.length() > 20)
        {
            query = query.substring(0, 20);
        }
        int historyLimit = StringUtils.isEmpty(query) ? 30 : 12;
        List<StockSymbol> history = stockReviewMapper.selectSymbols(ownerUserId, query, historyLimit);
        Map<String, StockSymbol> merged = new LinkedHashMap<String, StockSymbol>();
        addSymbols(merged, history);
        if (StringUtils.isNotEmpty(query))
        {
            addSymbols(merged, stockMarketSymbolClient.search(query));
        }
        List<StockSymbol> rows = new ArrayList<StockSymbol>(merged.values());
        if (rows.size() > 20)
        {
            return rows.subList(0, 20);
        }
        return rows;
    }

    private void addSymbols(Map<String, StockSymbol> merged, List<StockSymbol> rows)
    {
        if (rows == null)
        {
            return;
        }
        for (StockSymbol row : rows)
        {
            if (row == null || StringUtils.isEmpty(row.getStockCode()))
            {
                continue;
            }
            String code = row.getStockCode().trim().toUpperCase();
            String name = row.getStockName() == null ? "" : row.getStockName().trim();
            if (StringUtils.isEmpty(name))
            {
                name = code;
            }
            if (!merged.containsKey(code))
            {
                merged.put(code, new StockSymbol(code, name));
            }
        }
    }

    private void syncTrades(StockReview review)
    {
        List<StockReviewTrade> incoming = normalizeTrades(review.getTrades());
        List<Long> keepIds = new ArrayList<Long>();
        int sort = 0;
        for (StockReviewTrade trade : incoming)
        {
            trade.setReviewId(review.getReviewId());
            trade.setOwnerUserId(review.getOwnerUserId());
            trade.setSort(sort++);
            if (trade.getTradeId() == null)
            {
                trade.setCreateBy(StringUtils.isNotEmpty(review.getUpdateBy()) ? review.getUpdateBy() : review.getCreateBy());
                stockReviewMapper.insertTrade(trade);
            }
            else
            {
                trade.setUpdateBy(review.getUpdateBy());
                int updated = stockReviewMapper.updateTrade(trade);
                if (updated == 0)
                {
                    throw new ServiceException("Trade not found");
                }
            }
            keepIds.add(trade.getTradeId());
        }
        stockReviewMapper.deleteTradesNotIn(review.getReviewId(), review.getOwnerUserId(), keepIds, review.getUpdateBy());
    }

    private void normalizeReview(StockReview review)
    {
        if (StringUtils.isEmpty(review.getMood()))
        {
            review.setMood("0");
        }
        if (!MOODS.contains(review.getMood()))
        {
            throw new ServiceException("Invalid mood");
        }
        if (review.getScore() != null && review.getScore() == 0)
        {
            review.setScore(null);
        }
        if (review.getScore() != null && (review.getScore() < 1 || review.getScore() > 5))
        {
            throw new ServiceException("Score must be 1 to 5");
        }
        review.setConclusion(blankToNull(review.getConclusion()));
        review.setMistake(blankToNull(review.getMistake()));
        review.setNextPlan(blankToNull(review.getNextPlan()));
    }

    private List<StockReviewTrade> normalizeTrades(List<StockReviewTrade> trades)
    {
        if (trades == null || trades.isEmpty())
        {
            return Collections.emptyList();
        }
        List<StockReviewTrade> result = new ArrayList<StockReviewTrade>();
        for (StockReviewTrade trade : trades)
        {
            if (trade == null)
            {
                continue;
            }
            String code = trade.getStockCode() == null ? "" : trade.getStockCode().trim().toUpperCase();
            String name = trade.getStockName() == null ? "" : trade.getStockName().trim();
            if (StringUtils.isEmpty(code) && StringUtils.isEmpty(name)
                    && trade.getQuantity() == null && trade.getPrice() == null && trade.getProfitLoss() == null
                    && StringUtils.isEmpty(trade.getNote()))
            {
                continue;
            }
            if (StringUtils.isEmpty(code))
            {
                throw new ServiceException("Stock code is required");
            }
            if (code.length() > 16)
            {
                throw new ServiceException("Stock code is too long");
            }
            if (name.length() > 64)
            {
                throw new ServiceException("Stock name is too long");
            }
            if (StringUtils.isEmpty(name))
            {
                name = code;
            }
            if (StringUtils.isEmpty(trade.getDirection()))
            {
                trade.setDirection("0");
            }
            if (!DIRECTIONS.contains(trade.getDirection()))
            {
                throw new ServiceException("Invalid trade direction");
            }
            if (StringUtils.isNotEmpty(trade.getResultTag()) && !RESULT_TAGS.contains(trade.getResultTag()))
            {
                throw new ServiceException("Invalid result tag");
            }
            if (StringUtils.isEmpty(trade.getResultTag()))
            {
                trade.setResultTag(null);
            }
            if (trade.getNote() != null && trade.getNote().length() > 500)
            {
                throw new ServiceException("Trade note is too long");
            }
            assertNonNegative(trade.getQuantity(), "Quantity");
            assertNonNegative(trade.getPrice(), "Price");
            trade.setStockCode(code);
            trade.setStockName(name);
            result.add(trade);
        }
        return result;
    }

    private void assertNonNegative(BigDecimal value, String field)
    {
        if (value != null && value.compareTo(BigDecimal.ZERO) < 0)
        {
            throw new ServiceException(field + " cannot be negative");
        }
    }

    private Date normalizeDate(Date date)
    {
        if (date == null)
        {
            throw new ServiceException("Review date is required");
        }
        return DateUtils.parseDate(DateUtils.parseDateToStr(DateUtils.YYYY_MM_DD, date));
    }

    private Date[] monthRange(int year, int month)
    {
        if (year < 2000 || year > 2100 || month < 1 || month > 12)
        {
            throw new ServiceException("Invalid year or month");
        }
        Calendar calendar = Calendar.getInstance();
        calendar.clear();
        calendar.set(year, month - 1, 1);
        Date begin = calendar.getTime();
        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        Date end = calendar.getTime();
        return new Date[] { begin, end };
    }

    private String blankToNull(String value)
    {
        return StringUtils.isEmpty(value) ? null : value;
    }

    private static Set<String> setOf(String... values)
    {
        Set<String> set = new HashSet<String>();
        for (String value : values)
        {
            set.add(value);
        }
        return set;
    }
}
