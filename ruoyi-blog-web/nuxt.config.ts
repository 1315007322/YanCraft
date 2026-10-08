const backend = process.env.NUXT_BACKEND_URL || "http://127.0.0.1:8080"

export default defineNuxtConfig({
  compatibilityDate: "2025-07-15",
  devtools: { enabled: false },
  css: ["~/assets/css/themes.css", "~/assets/css/main.css"],
  app: {
    head: {
      htmlAttrs: { lang: "zh-CN", "data-theme": "paper" },
      link: [
        { rel: "preconnect", href: "https://fonts.googleapis.com" },
        { rel: "preconnect", href: "https://fonts.gstatic.com", crossorigin: "" },
        {
          rel: "stylesheet",
          href: "https://fonts.googleapis.com/css2?family=Newsreader:ital,opsz,wght@0,7..72,500;0,7..72,650;0,7..72,700;1,7..72,400;1,7..72,500&family=Noto+Serif+SC:wght@500;600;700&family=Source+Sans+3:ital,wght@0,400;0,500;0,600;1,400&display=swap"
        }
      ]
    }
  },
  runtimeConfig: {
    public: {
      siteName: "SuperYan",
      tagline: "Going to try and get something up eventually I hope",
      apiBase: ""
    }
  },
  nitro: {
    routeRules: {
      "/portal/**": { proxy: `${backend}/portal/**` },
      "/profile/**": { proxy: `${backend}/profile/**` }
    }
  }
})
