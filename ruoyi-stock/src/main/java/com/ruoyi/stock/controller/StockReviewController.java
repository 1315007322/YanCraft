package com.ruoyi.stock.controller;

import java.util.Date;
import java.util.List;
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
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.stock.domain.StockReview;
import com.ruoyi.stock.domain.StockReviewTemplate;
import com.ruoyi.stock.service.IStockReviewService;

/**
 * Personal daily stock review.
 */
@RestController
@RequestMapping("/stock/review")
public class StockReviewController extends BaseController
{
    @Autowired
    private IStockReviewService stockReviewService;

    @PreAuthorize("@ss.hasPermi('stock:review:list')")
    @GetMapping("/list")
    public TableDataInfo list(StockReview query)
    {
        query.setOwnerUserId(getUserId());
        startPage();
        List<StockReview> list = stockReviewService.selectReviewList(query);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('stock:review:query')")
    @GetMapping("/statistics")
    public AjaxResult statistics(@RequestParam int year, @RequestParam int month)
    {
        return success(stockReviewService.selectMonthStatistics(year, month, getUserId()));
    }

    @PreAuthorize("@ss.hasPermi('stock:review:query')")
    @GetMapping("/calendar")
    public AjaxResult calendar(@RequestParam int year, @RequestParam int month)
    {
        return success(stockReviewService.selectCalendarMarks(year, month, getUserId()));
    }

    @PreAuthorize("@ss.hasPermi('stock:review:query')")
    @GetMapping("/templates")
    public AjaxResult templates()
    {
        return success(stockReviewService.selectTemplates(getUserId()));
    }

    @PreAuthorize("@ss.hasAnyPermi('stock:review:add,stock:review:edit')")
    @Log(title = "Stock Review Template", businessType = BusinessType.INSERT)
    @PostMapping("/templates")
    public AjaxResult saveTemplate(@RequestBody StockReviewTemplate template)
    {
        template.setOwnerUserId(getUserId());
        template.setCreateBy(getUsername());
        return toAjax(stockReviewService.saveMyTemplate(template));
    }

    @PreAuthorize("@ss.hasPermi('stock:review:remove')")
    @Log(title = "Stock Review Template", businessType = BusinessType.DELETE)
    @DeleteMapping("/templates/{templateId}")
    public AjaxResult removeTemplate(@PathVariable Long templateId)
    {
        return toAjax(stockReviewService.deleteMyTemplate(templateId, getUserId(), getUsername()));
    }

    @PreAuthorize("@ss.hasPermi('stock:review:query')")
    @GetMapping("/symbols")
    public AjaxResult symbols(@RequestParam(value = "q", required = false) String q)
    {
        return success(stockReviewService.searchSymbols(q, getUserId()));
    }

    @PreAuthorize("@ss.hasPermi('stock:review:query')")
    @GetMapping("/previous-trades")
    public AjaxResult previousTrades(@RequestParam String before)
    {
        return success(stockReviewService.selectPreviousTrades(parseDay(before), getUserId()));
    }

    @PreAuthorize("@ss.hasPermi('stock:review:query')")
    @GetMapping("/date/{reviewDate}")
    public AjaxResult getByDate(@PathVariable String reviewDate)
    {
        return success(stockReviewService.selectReviewByDate(parseDay(reviewDate), getUserId()));
    }

    @PreAuthorize("@ss.hasPermi('stock:review:query')")
    @GetMapping("/{reviewId}")
    public AjaxResult getInfo(@PathVariable Long reviewId)
    {
        return success(stockReviewService.selectReviewById(reviewId, getUserId()));
    }

    @PreAuthorize("@ss.hasAnyPermi('stock:review:add,stock:review:edit')")
    @Log(title = "Stock Review", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult save(@Validated @RequestBody StockReview review)
    {
        review.setOwnerUserId(getUserId());
        review.setCreateBy(getUsername());
        review.setUpdateBy(getUsername());
        return toAjax(stockReviewService.saveReview(review));
    }

    @PreAuthorize("@ss.hasPermi('stock:review:remove')")
    @Log(title = "Stock Review", businessType = BusinessType.DELETE)
    @DeleteMapping("/{reviewIds}")
    public AjaxResult remove(@PathVariable Long[] reviewIds)
    {
        return toAjax(stockReviewService.deleteReviews(reviewIds, getUserId(), getUsername()));
    }

    private Date parseDay(String value)
    {
        Date day = DateUtils.parseDate(value);
        if (day == null)
        {
            throw new ServiceException("Invalid date");
        }
        return day;
    }
}
