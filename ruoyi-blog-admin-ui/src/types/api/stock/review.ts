import type { BaseEntity, PageDomain } from "../../common"

export interface StockReviewQueryParams extends PageDomain {
  keyword?: string
  mood?: string
  resultTag?: string
  params?: Record<string, any>
}

export interface StockReviewTrade {
  tradeId?: number
  reviewId?: number
  reviewDate?: string
  stockCode?: string
  stockName?: string
  direction?: string
  quantity?: number | null
  price?: number | null
  profitLoss?: number | null
  resultTag?: string
  note?: string
  sort?: number
}

export interface StockTradeQueryParams extends PageDomain {
  keyword?: string
  direction?: string
  resultTag?: string
}

export interface StockReview extends BaseEntity {
  reviewId?: number
  ownerUserId?: number
  reviewDate?: string
  mood?: string
  score?: number | null
  conclusion?: string
  mistake?: string
  nextPlan?: string
  tradeCount?: number
  trades?: StockReviewTrade[]
}

export interface StockReviewDayMark {
  reviewDate?: string
  tradeCount?: number
}

export interface StockReviewStatistics {
  reviewDays?: number
  tradeDays?: number
  profitLoss?: number
  topResultTag?: string
}

export interface StockSymbol {
  stockCode?: string
  stockName?: string
}

export interface StockReviewTemplate {
  templateId?: number
  ownerUserId?: number
  templateCode?: string
  templateName?: string
  summary?: string
  mood?: string
  score?: number | null
  conclusion?: string
  mistake?: string
  nextPlan?: string
  systemTemplate?: boolean
}
