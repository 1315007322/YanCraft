import { THEME_META, normalizeThemeId, type ThemeId } from "~/utils/themes"

export function useTheme() {
  const theme = useState<ThemeId>("yc-theme", () => "paper")

  const apply = (id: ThemeId) => {
    const next = normalizeThemeId(id)
    theme.value = next
    if (import.meta.client) {
      document.documentElement.setAttribute("data-theme", next)
    }
  }

  return { theme, apply, THEME_META }
}
