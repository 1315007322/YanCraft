import type { AjaxResult, ArticleListQuery, CmsArticle, CmsCategory, CmsFriendLink, CmsTag, TableDataInfo } from "~/types/cms"

function apiPrefix() {
  const config = useRuntimeConfig()
  return config.public.apiBase || ""
}

export function articlePath(article: CmsArticle) {
  const key = article.slug || article.articleId
  return `/post/${key}`
}

export function mediaUrl(path?: string) {
  if (!path) {
    return ""
  }
  if (/^https?:\/\//i.test(path)) {
    return path
  }
  return `${apiPrefix()}${path.startsWith("/") ? path : `/${path}`}`
}

export async function fetchArticleList(query: ArticleListQuery = {}) {
  try {
    return await $fetch<TableDataInfo<CmsArticle>>(`${apiPrefix()}/portal/cms/article/list`, {
      query: {
        pageNum: query.pageNum || 1,
        pageSize: query.pageSize || 10,
        keyword: query.keyword,
        categorySlug: query.categorySlug,
        tagSlug: query.tagSlug
      }
    })
  } catch {
    return { code: 500, msg: "unavailable", total: 0, rows: [] }
  }
}

export async function fetchArticleByKey(key: string) {
  const encoded = encodeURIComponent(key)
  try {
    const bySlug = await $fetch<AjaxResult<CmsArticle>>(`${apiPrefix()}/portal/cms/article/slug/${encoded}`)
    if (bySlug.code === 200 && bySlug.data) {
      return bySlug
    }
    if (/^\d+$/.test(key)) {
      return await $fetch<AjaxResult<CmsArticle>>(`${apiPrefix()}/portal/cms/article/${key}`)
    }
    return bySlug
  } catch {
    return { code: 500, msg: "unavailable" } as AjaxResult<CmsArticle>
  }
}

export async function fetchHotArticles(limit = 6) {
  try {
    return await $fetch<AjaxResult<CmsArticle[]>>(`${apiPrefix()}/portal/cms/article/hot`, {
      query: { limit }
    })
  } catch {
    return { code: 500, msg: "unavailable", data: [] }
  }
}

export async function fetchCategories() {
  try {
    return await $fetch<AjaxResult<CmsCategory[]>>(`${apiPrefix()}/portal/cms/category/list`)
  } catch {
    return { code: 500, msg: "unavailable", data: [] }
  }
}

export async function fetchTags() {
  try {
    return await $fetch<AjaxResult<CmsTag[]>>(`${apiPrefix()}/portal/cms/tag/list`)
  } catch {
    return { code: 500, msg: "unavailable", data: [] }
  }
}

export async function fetchFriendLinks() {
  try {
    return await $fetch<AjaxResult<CmsFriendLink[]>>(`${apiPrefix()}/portal/cms/link/list`)
  } catch {
    return { code: 500, msg: "unavailable", data: [] }
  }
}
