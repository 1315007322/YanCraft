type ListBody = { code?: number; rows?: Array<{ slug?: string; articleId?: number; reviewId?: number }>; total?: number }
type NamedList = { data?: Array<{ slug?: string }> }
type SiteBody = { data?: { siteUrl?: string } }

function escapeXml(value: string) {
  return value
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
}

async function readJson<T>(url: string, query?: Record<string, string | number>) {
  return await $fetch<T>(url, { query })
}

export default defineEventHandler(async (event) => {
  const backend = process.env.NUXT_BACKEND_URL || "http://127.0.0.1:8080"
  const requestUrl = getRequestURL(event)
  let origin = requestUrl.origin
  const paths = new Set<string>(["/", "/about", "/lab", "/review"])

  try {
    const site = await readJson<SiteBody>(`${backend}/portal/cms/site`)
    const configured = String(site?.data?.siteUrl || "").trim().replace(/\/$/, "")
    if (/^https?:\/\//i.test(configured)) {
      origin = configured
    }
  } catch {
    // keep the request origin
  }

  try {
    const categories = await readJson<NamedList>(`${backend}/portal/cms/category/list`)
    for (const item of categories?.data || []) {
      if (item.slug) paths.add(`/category/${item.slug}`)
    }
  } catch {
    // skip
  }

  try {
    const tags = await readJson<NamedList>(`${backend}/portal/cms/tag/list`)
    for (const item of tags?.data || []) {
      if (item.slug) paths.add(`/tag/${item.slug}`)
    }
  } catch {
    // skip
  }

  for (let page = 1; page <= 20; page += 1) {
    let list: ListBody
    try {
      list = await readJson<ListBody>(`${backend}/portal/cms/article/list`, { pageNum: page, pageSize: 100 })
    } catch {
      break
    }
    const rows = list?.rows || []
    for (const article of rows) {
      const key = article.slug || article.articleId
      if (key) paths.add(`/post/${key}`)
    }
    if (rows.length < 100) break
  }

  try {
    const reviews = await readJson<ListBody>(`${backend}/portal/stock/review/list`, { pageNum: 1, pageSize: 200 })
    if (reviews?.code === 200) {
      for (const review of reviews.rows || []) {
        if (review.reviewId) paths.add(`/review/${review.reviewId}`)
      }
    }
  } catch {
    // reviews stay off the map when the API is unavailable
  }

  const body = [
    '<?xml version="1.0" encoding="UTF-8"?>',
    '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">',
    ...[...paths].map((path) => `  <url><loc>${escapeXml(origin + path)}</loc></url>`),
    "</urlset>",
    ""
  ].join("\n")
  setHeader(event, "content-type", "application/xml; charset=utf-8")
  return body
})
