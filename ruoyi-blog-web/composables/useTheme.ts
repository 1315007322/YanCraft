export const THEME_IDS = ["paper", "press", "celadon", "night"] as const

export type ThemeId = (typeof THEME_IDS)[number]

export const THEME_META: { id: ThemeId; label: string; hint: string }[] = [
  { id: "paper", label: "Rice", hint: "paper magazine" },
  { id: "press", label: "Press", hint: "letterpress" },
  { id: "celadon", label: "Celadon", hint: "study" },
  { id: "night", label: "Night", hint: "lamp" }
]

export function useTheme() {
  const theme = useState<ThemeId>("yc-theme", () => "paper")

  const apply = (id: ThemeId) => {
    theme.value = id
    if (import.meta.client) {
      document.documentElement.setAttribute("data-theme", id)
      localStorage.setItem("yc-theme", id)
    }
  }

  return { theme, apply, THEME_META }
}
