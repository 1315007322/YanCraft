import type { CmsSiteSetting } from "~/types/cms"

type SeoInput = {
  title: MaybeRefOrGetter<string>
  description?: MaybeRefOrGetter<string | undefined>
  image?: MaybeRefOrGetter<string | undefined>
  type?: MaybeRefOrGetter<"website" | "article">
  noindex?: MaybeRefOrGetter<boolean>
  jsonLd?: MaybeRefOrGetter<Record<string, unknown> | undefined>
}

export function plainText(value?: string, max = 160) {
  const text = (value || "")
    .replace(/```[\s\S]*?```/g, " ")
    .replace(/[#>*_`\[\]()!-]/g, " ")
    .replace(/\s+/g, " ")
    .trim()
  if (text.length <= max) {
    return text
  }
  return `${text.slice(0, max - 1)}\u2026`
}

export function usePageSeo(site: ComputedRef<CmsSiteSetting>, input: SeoInput) {
  const route = useRoute()
  const requestUrl = useRequestURL()
  const origin = computed(() => {
    const configured = (site.value.siteUrl || "").trim().replace(/\/$/, "")
    if (/^https?:\/\//i.test(configured)) {
      return configured
    }
    return requestUrl.origin
  })
  const siteName = computed(() => site.value.siteName || "SuperYan")
  const title = computed(() => {
    const raw = String(toValue(input.title) || "").trim()
    const name = siteName.value
    if (!raw || raw === name) {
      return name
    }
    return raw.endsWith(name) ? raw : `${raw} \u00b7 ${name}`
  })
  const description = computed(() => plainText(toValue(input.description) || site.value.tagline || siteName.value))
  const image = computed(() => {
    const raw = mediaUrl(toValue(input.image) || "")
    if (!raw) {
      return undefined
    }
    if (/^https?:\/\//i.test(raw)) {
      return raw
    }
    return origin.value + (raw.startsWith("/") ? raw : `/${raw}`)
  })
  const canonical = computed(() => {
    const url = new URL(route.fullPath, origin.value)
    url.hash = ""
    return url.toString()
  })
  const noindex = computed(() => Boolean(toValue(input.noindex)))

  useSeoMeta({
    title,
    description,
    ogTitle: title,
    ogDescription: description,
    ogType: () => toValue(input.type) || "website",
    ogUrl: canonical,
    ogImage: image,
    twitterCard: () => (image.value ? "summary_large_image" : "summary"),
    twitterTitle: title,
    twitterDescription: description,
    twitterImage: image,
    robots: () => (noindex.value ? "noindex,follow" : "index,follow")
  })

  useHead({
    link: () => [{ rel: "canonical", href: canonical.value }],
    script: () => {
      const data = toValue(input.jsonLd)
      if (!data) {
        return []
      }
      return [{ type: "application/ld+json", innerHTML: JSON.stringify(data) }]
    }
  })
}
