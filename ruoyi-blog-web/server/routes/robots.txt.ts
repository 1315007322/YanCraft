export default defineEventHandler(async (event) => {
  const backend = process.env.NUXT_BACKEND_URL || "http://127.0.0.1:8080"
  const requestUrl = getRequestURL(event)
  let origin = requestUrl.origin
  try {
    const site = await $fetch<{ data?: { siteUrl?: string } }>(`${backend}/portal/cms/site`)
    const configured = String(site?.data?.siteUrl || "").trim().replace(/\/$/, "")
    if (/^https?:\/\//i.test(configured)) {
      origin = configured
    }
  } catch {
    // keep the request origin
  }
  setHeader(event, "content-type", "text/plain; charset=utf-8")
  return `User-agent: *\nAllow: /\nSitemap: ${origin}/sitemap.xml\n`
})