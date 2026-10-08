export const THEME_IDS = ["paper", "press", "celadon", "night", "ink", "harbor"] as const

export type ThemeId = (typeof THEME_IDS)[number]

export type ThemePreview = {
  bg: string
  card: string
  ink: string
  brand: string
  nav: string
}

export type ThemeMeta = {
  id: ThemeId
  label: string
  hint: string
  preview: ThemePreview
}

export const THEME_META: ThemeMeta[] = [
  {
    id: "paper",
    label: "暖纸朱印",
    hint: "当前默认，米黄纸底与朱红强调",
    preview: { bg: "#f1ebe3", card: "#fbf7f1", ink: "#1c1915", brand: "#c94b3a", nav: "#f6f0e7" }
  },
  {
    id: "press",
    label: "活版印刷",
    hint: "硬边框、深红印章感",
    preview: { bg: "#f4efe6", card: "#fffaf2", ink: "#111111", brand: "#a31111", nav: "#efe8db" }
  },
  {
    id: "celadon",
    label: "青瓷书斋",
    hint: "青绿底色，更圆润的边角",
    preview: { bg: "#e4eee8", card: "#f5faf7", ink: "#14342c", brand: "#2f6b4f", nav: "#dff0e6" }
  },
  {
    id: "night",
    label: "夜灯墨金",
    hint: "深色夜读，金色点缀",
    preview: { bg: "#14110e", card: "#221c16", ink: "#eadfce", brand: "#d4a017", nav: "#1a1511" }
  },
  {
    id: "ink",
    label: "水墨留白",
    hint: "黑白极简，少有色彩",
    preview: { bg: "#f7f7f5", card: "#ffffff", ink: "#161616", brand: "#161616", nav: "#f0f0ec" }
  },
  {
    id: "harbor",
    label: "港湾靛蓝",
    hint: "冷色靛蓝与清爽灰蓝",
    preview: { bg: "#e8eef4", card: "#f8fbfe", ink: "#1a2a3a", brand: "#2b4c7e", nav: "#dce7f2" }
  }
]

export function normalizeThemeId(id?: string | null): ThemeId {
  const value = String(id || "").trim()
  return (THEME_IDS as readonly string[]).includes(value) ? (value as ThemeId) : "paper"
}
