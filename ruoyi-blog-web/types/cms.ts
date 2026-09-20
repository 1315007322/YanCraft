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
