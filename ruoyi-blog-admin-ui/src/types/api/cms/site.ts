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
