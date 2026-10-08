import request from "@/utils/request"
import type {
  AjaxResult,
  TableDataInfo,
  StockReview,
  StockReviewDayMark,
  StockReviewQueryParams,
  StockReviewStatistics,
  StockReviewTrade,
  StockReviewTemplate,
  StockSymbol
} from "@/types"

export function listStockReview(query: StockReviewQueryParams): Promise<TableDataInfo<StockReview>> {
  return request({
    url: "/stock/review/list",
    method: "get",
    params: query
  })
}

export function getStockReview(reviewId: number): Promise<AjaxResult<StockReview>> {
  return request({
    url: "/stock/review/" + reviewId,
    method: "get"
  })
}

export function getStockReviewByDate(reviewDate: string): Promise<AjaxResult<StockReview>> {
  return request({
    url: "/stock/review/date/" + reviewDate,
    method: "get"
  })
}

export function getStockReviewStatistics(year: number, month: number): Promise<AjaxResult<StockReviewStatistics>> {
  return request({
    url: "/stock/review/statistics",
    method: "get",
    params: { year, month }
  })
}

export function getStockReviewCalendar(year: number, month: number): Promise<AjaxResult<StockReviewDayMark[]>> {
  return request({
    url: "/stock/review/calendar",
    method: "get",
    params: { year, month }
  })
}

export function getPreviousTrades(before: string): Promise<AjaxResult<StockReviewTrade[]>> {
  return request({
    url: "/stock/review/previous-trades",
    method: "get",
    params: { before }
  })
}

export function saveStockReview(data: StockReview): Promise<AjaxResult> {
  return request({
    url: "/stock/review",
    method: "put",
    data
  })
}

export function delStockReview(reviewIds: number | number[]): Promise<AjaxResult> {
  return request({
    url: "/stock/review/" + reviewIds,
    method: "delete"
  })
}

export function listStockSymbols(q?: string): Promise<AjaxResult<StockSymbol[]>> {
  return request({
    url: "/stock/review/symbols",
    method: "get",
    params: { q }
  })
}

export function listStockReviewTemplates(): Promise<AjaxResult<StockReviewTemplate[]>> {
  return request({
    url: "/stock/review/templates",
    method: "get"
  })
}

export function saveStockReviewTemplate(data: StockReviewTemplate): Promise<AjaxResult> {
  return request({
    url: "/stock/review/templates",
    method: "post",
    data
  })
}

export function delStockReviewTemplate(templateId: number): Promise<AjaxResult> {
  return request({
    url: "/stock/review/templates/" + templateId,
    method: "delete"
  })
}
