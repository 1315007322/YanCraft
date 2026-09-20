const backend = process.env.NUXT_BACKEND_URL || "http://127.0.0.1:8080"

export default defineNuxtConfig({
  compatibilityDate: "2025-07-15",
  devtools: { enabled: false },
  css: ["~/assets/css/main.css"],
  app: {
    head: {
      htmlAttrs: { lang: "zh-CN" },
      link: [
        { rel: "preconnect", href: "https://fonts.googleapis.com" },
        { rel: "preconnect", href: "https://fonts.gstatic.com", crossorigin: "" },
        {
          rel: "stylesheet",
          href: "https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@400;500;700&display=swap"
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
