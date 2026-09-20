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
  hotLimit?: number
  homePageSize?: number
  extraNavLinks?: CmsNavLink[]
}

export interface CmsNavLink {
  name?: string
  url?: string
  openInNew?: string
  sort?: number
  enabled?: string
}
