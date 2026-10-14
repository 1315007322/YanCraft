export interface AjaxResult<T = unknown> {
  code: number
  msg: string
  data?: T
}

export interface TableDataInfo<T> {
  code: number
  msg: string
  total: number
  rows: T[]
}

export interface CmsTag {
  tagId?: number
  name?: string
  slug?: string
  articleCount?: number
}

export interface CmsCategory {
  categoryId?: number
  name?: string
  slug?: string
  sort?: number
  remark?: string
}

export interface CmsArticle {
  articleId?: number
  title?: string
  slug?: string
  summary?: string
  cover?: string
  coverWide?: string
  content?: string
  categoryId?: number
  categoryName?: string
  author?: string
  isTop?: string
  viewCount?: number
  wordCount?: number
  readingTime?: number
  publishTime?: string
  tags?: CmsTag[]
}

export interface ArticleListQuery {
  pageNum?: number
  pageSize?: number
  keyword?: string
  categorySlug?: string
  tagSlug?: string
}

export interface CmsFriendLink {
  linkId?: number
  nickname?: string
  description?: string
  siteUrl?: string
  sort?: number
}

export interface CmsLabProject {
  projectId?: number
  projectName?: string
  description?: string
  repoUrl?: string
  previewUrl?: string
  cover?: string
  sort?: number
}

export interface CmsSiteSetting {
  siteName?: string
  logoPrefix?: string
  logoHighlight?: string
  tagline?: string
  author?: string
  authorSignature?: string
  avatarUrl?: string
  avatarLetter?: string
  footerText?: string
  beianText?: string
  beianUrl?: string
  siteUrl?: string
  aboutTitle?: string
  aboutContent?: string
  aboutEnabled?: string
  searchEnabled?: string
  categoryEnabled?: string
  friendLinkEnabled?: string
  labEnabled?: string
  stockReviewEnabled?: string
  verbalEnabled?: string
  stockReviewCoverCalm?: string
  stockReviewCoverOptimistic?: string
  stockReviewCoverCautious?: string
  stockReviewCoverChase?: string
  stockReviewCoverPanic?: string
  hotLimit?: number
  homePageSize?: number
  extraNavLinks?: CmsNavLink[]
  themeId?: string
}

export interface StockReviewTrade {
  tradeId?: number
  stockCode?: string
  stockName?: string
  direction?: string
  quantity?: number
  price?: number
  profitLoss?: number
  resultTag?: string
  note?: string
}

export interface StockReview {
  reviewId?: number
  reviewDate?: string
  mood?: string
  score?: number
  conclusion?: string
  mistake?: string
  nextPlan?: string
  tradeCount?: number
  profitLoss?: number | null
  trades?: StockReviewTrade[]
}

export interface CmsNavLink {
  name?: string
  url?: string
  openInNew?: string
  sort?: number
  enabled?: string
}

export interface ExamVerbalCard {
  cardId?: number
  cardType?: string
  prompt?: string
  difference?: string
  collocation?: string
  confusion?: string
  ownSentence?: string
  intervalDays?: number
  dueDate?: string
  reviewCount?: number
  missed?: string
}
