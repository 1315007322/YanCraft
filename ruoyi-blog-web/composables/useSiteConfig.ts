import type { CmsSiteSetting } from "~/types/cms"

export function defaultSiteSetting(): CmsSiteSetting {
  return {
    siteName: "SuperYan",
    logoPrefix: "SUPER",
    logoHighlight: "YAN",
    tagline: "Going to try and get something up eventually I hope",
    author: "SuperYan",
    authorSignature: "",
    avatarUrl: "",
    avatarLetter: "SY",
    footerText: "SuperYan",
    beianText: "",
    beianUrl: "https://beian.miit.gov.cn/",
    siteUrl: "",
    aboutTitle: "SuperYan",
    aboutContent: "",
    aboutEnabled: "0",
    searchEnabled: "0",
    categoryEnabled: "0",
    friendLinkEnabled: "0",
    labEnabled: "0",
    hotLimit: 6,
    homePageSize: 8,
    extraNavLinks: []
  }
}

export function isEnabled(flag?: string) {
  return flag !== "1"
}

export async function useSiteConfig() {
  const { data } = await useAsyncData("cms-site-setting", fetchSiteConfig)
  return computed(() => ({
    ...defaultSiteSetting(),
    ...(data.value?.data || {})
  }))
}
