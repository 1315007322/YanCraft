package com.ruoyi.stock.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.stock.domain.StockReview;
import com.ruoyi.stock.service.IStockReviewService;

/**
 * Public read-only stock reviews for the blog.
 */
@Anonymous
@RestController
@RequestMapping("/portal/stock/review")
public class StockReviewPortalController extends BaseController
{
    @Autowired
    private IStockReviewService stockReviewService;

    @GetMapping("/list")
    public TableDataInfo list()
    {
        startPage();
        List<StockReview> list = stockReviewService.selectPublicReviewList();
        return getDataTable(list);
    }

    @GetMapping("/{reviewId}")
    public AjaxResult getInfo(@PathVariable Long reviewId)
    {
        StockReview review = stockReviewService.selectPublicReviewById(reviewId);
        return review == null ? error("复盘不存在") : success(review);
    }
}
