<template>
  <div class="page" :class="{ 'is-nav-open': navOpen }">
    <input id="site-nav-switch" v-model="navOpen" class="nav-switch" type="checkbox" />
    <header class="topbar">
      <div class="topbar-inner">
        <div class="brand-row">
          <label
            class="menu-toggle"
            for="site-nav-switch"
            :aria-expanded="navOpen"
            aria-controls="site-sidenav"
            :aria-label="navOpen ? '收起菜单' : '打开菜单'"
          >
            <span class="icon-close"><X :size="22" :stroke-width="2" /></span>
            <span class="icon-open"><Menu :size="22" :stroke-width="2" /></span>
          </label>
          <NuxtLink to="/" class="logo" @click="closeNav">{{ site.logoPrefix }}<b>{{ site.logoHighlight }}</b></NuxtLink>
        </div>
        <form v-if="isEnabled(site.searchEnabled)" class="search-box" @submit.prevent="onSearch">
          <input v-model="keywordInput" type="search" :placeholder="'搜索'" />
          <button type="submit">搜索</button>
        </form>
      </div>
      <RouteProgress />
    </header>
    <label class="nav-mask" :class="{ show: navOpen }" for="site-nav-switch" aria-hidden="true" />
    <div class="shell">
      <aside id="site-sidenav" class="panel sidenav">
        <div class="profile">
          <div class="avatar">
            <img v-if="site.avatarUrl" :src="mediaUrl(site.avatarUrl)" :alt="site.author || site.siteName" />
            <template v-else>{{ site.avatarLetter || (site.author || site.siteName || 'S').slice(0, 2) }}</template>
          </div>
          <div class="profile-meta">
            <strong>{{ site.author || site.siteName }}</strong>
            <span v-if="site.authorSignature">{{ site.authorSignature }}</span>
          </div>
        </div>
        <nav @click="onNavClick">
          <ul class="nav-list">
            <li>
              <NuxtLink to="/" exact-active-class="active" active-class="is-partial">
                <House :size="20" :stroke-width="2" />
                <span>首页</span>
              </NuxtLink>
            </li>
            <li v-if="isEnabled(site.aboutEnabled)">
              <NuxtLink to="/about" exact-active-class="active" active-class="is-partial">
                <User :size="20" :stroke-width="2" />
                <span>关于我</span>
              </NuxtLink>
            </li>
            <li v-if="isEnabled(site.labEnabled)">
              <NuxtLink to="/lab" exact-active-class="active" active-class="is-partial">
                <FlaskConical :size="20" :stroke-width="2" />
                <span>实验室</span>
              </NuxtLink>
            </li>
            <li v-if="isEnabled(site.stockReviewEnabled)">
              <NuxtLink to="/review" active-class="active">
                <LineChart :size="20" :stroke-width="2" />
                <span>股票复盘</span>
              </NuxtLink>
            </li>
            <li v-for="item in extraNavs" :key="item.name + (item.url || '')">
              <a
                :href="item.url"
                :target="isEnabled(item.openInNew) ? '_blank' : '_self'"
                :rel="isEnabled(item.openInNew) ? 'noopener noreferrer' : undefined"
              >
                <ExternalLink :size="20" :stroke-width="2" />
                <span>{{ item.name }}</span>
              </a>
            </li>
            <li v-if="isEnabled(site.categoryEnabled)">
              <button class="nav-parent" type="button" :class="{ active: isCategorySection }" @click="categoryOpen = !categoryOpen">
                <span class="nav-parent-main">
                  <Folder :size="20" :stroke-width="2" />
                  <span>分类</span>
                </span>
                <ChevronDown :size="20" :stroke-width="2" class="caret" :class="{ open: categoryOpen }" />
              </button>
              <ul v-show="categoryOpen" class="nav-sub">
                <li v-for="c in categories" :key="c.categoryId">
                  <NuxtLink
                    v-if="c.slug"
                    :to="'/category/' + c.slug"
                    exact-active-class="active"
                    active-class="is-partial"
                  >{{ c.name }}</NuxtLink>
                </li>
              </ul>
            </li>
            <li v-if="isEnabled(site.friendLinkEnabled)">
              <button class="nav-parent" type="button" @click="linkOpen = !linkOpen">
                <span class="nav-parent-main">
                  <LinkIcon :size="20" :stroke-width="2" />
                  <span>友链</span>
                </span>
                <ChevronDown :size="20" :stroke-width="2" class="caret" :class="{ open: linkOpen }" />
              </button>
              <ul v-show="linkOpen" class="nav-sub">
                <li v-for="item in friendLinks" :key="item.linkId">
                  <a
                    v-if="item.siteUrl"
                    :href="item.siteUrl"
                    :title="item.description || item.nickname"
                    target="_blank"
                    rel="noopener noreferrer"
                  >{{ item.nickname }}</a>
                </li>
              </ul>
            </li>
          </ul>
        </nav>
      </aside>
      <main class="main">
        <slot />
      </main>
      <aside class="panel rail">
        <div class="rail-block">
          <h3>热门</h3>
          <ul class="hot-list">
            <li v-for="item in hot" :key="item.articleId">
              <i class="dot" />
              <NuxtLink :to="articlePath(item)">{{ item.title }}</NuxtLink>
              <ViewCount class="hot-views" :value="item.viewCount" :size="12" />
            </li>
            <li v-if="!hot.length" class="hot-empty">暂无</li>
          </ul>
        </div>
        <div class="rail-block">
          <h3>博客信息</h3>
          <ul class="stat-list">
            <li><span>文章</span><b>{{ total }}</b></li>
            <li><span>分类</span><b>{{ categories.length }}</b></li>
            <li><span>标签</span><b>{{ tags.length }}</b></li>
          </ul>
        </div>
        <div class="rail-block">
          <h3>标签云</h3>
          <div v-if="rankedTags.length" class="tag-heat">
            <NuxtLink
              v-for="t in rankedTags"
              :key="t.tagId"
              :to="'/tag/' + t.slug"
              :class="{ hot: heatOf(t) >= 0.62 }"
              :style="{ '--heat': String(heatOf(t)) }"
            >
              <span>{{ t.name }}</span>
              <i>{{ t.articleCount || 0 }}</i>
            </NuxtLink>
          </div>
          <p v-else class="hot-empty">暂无</p>
        </div>
      </aside>
    </div>
    <footer class="site-footer">
      <span>{{ site.footerText || site.siteName }}</span>
      <a
        v-if="site.beianText"
        class="beian"
        :href="site.beianUrl || 'https://beian.miit.gov.cn/'"
        target="_blank"
        rel="noopener noreferrer"
      >{{ site.beianText }}</a>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { ChevronDown, ExternalLink, FlaskConical, Folder, House, LineChart, Link as LinkIcon, Menu, User, X } from "lucide-vue-next"
import RouteProgress from "~/components/RouteProgress.vue"
import { normalizeThemeId } from "~/utils/themes"

const route = useRoute()
const router = useRouter()
const keywordInput = ref(String(route.query.q || ''))
const site = await useSiteConfig()
const themeId = computed(() => normalizeThemeId(site.value.themeId))
useHead({
  htmlAttrs: {
    "data-theme": themeId
  }
})

watch(() => route.query.q, (v) => { keywordInput.value = String(v || '') })

const { data } = await useAsyncData(
  () => `shell-meta-${site.value.hotLimit || 6}`,
  async () => {
    const [list, cats, tagRes, hotRes, linkRes] = await Promise.all([
      fetchArticleList({ pageNum: 1, pageSize: 1 }),
      fetchCategories(),
      fetchTags(),
      fetchHotArticles(site.value.hotLimit || 6),
      fetchFriendLinks()
    ])
    return { list, cats, tagRes, hotRes, linkRes }
  }
)

const total = computed(() => data.value?.list.total || 0)
const categories = computed(() => data.value?.cats.data || [])
const tags = computed(() => data.value?.tagRes.data || [])
const rankedTags = computed(() =>
  [...tags.value]
    .filter((item) => item.slug)
    .sort((a, b) => (b.articleCount || 0) - (a.articleCount || 0) || (a.tagId || 0) - (b.tagId || 0))
)

const tagHeatMax = computed(() => Math.max(1, ...rankedTags.value.map((item) => item.articleCount || 0)))
function heatOf(item: { articleCount?: number }) {
  return (item.articleCount || 0) / tagHeatMax.value
}
const hot = computed(() => data.value?.hotRes.data || [])
const friendLinks = computed(() => data.value?.linkRes.data || [])
const extraNavs = computed(() =>
  (site.value.extraNavLinks || []).filter((item) => isEnabled(item.enabled) && item.name && item.url)
)
const categoryOpen = ref(true)
const linkOpen = ref(true)

const navOpen = ref(false)
const mediaQuery = "(max-width: 800px)"

function isMobileNav() {
  return import.meta.client && window.matchMedia(mediaQuery).matches
}

function closeNav() {
  navOpen.value = false
}

function onNavClick(event: Event) {
  const target = event.target as HTMLElement | null
  if (target && target.closest("a")) {
    window.setTimeout(closeNav, 0)
  }
}

function syncBodyScroll() {
  if (!import.meta.client) return
  const lock = navOpen.value && isMobileNav()
  document.documentElement.classList.toggle("nav-open", lock)
  document.body.style.overflow = lock ? "hidden" : ""
}

watch(() => route.fullPath, closeNav)

watch(navOpen, syncBodyScroll)

function onKeydown(event: KeyboardEvent) {
  if (event.key === "Escape") closeNav()
}

function onResize() {
  if (!isMobileNav()) closeNav()
}

onMounted(() => {
  window.addEventListener("keydown", onKeydown)
  window.addEventListener("resize", onResize)
})

onBeforeUnmount(() => {
  window.removeEventListener("keydown", onKeydown)
  window.removeEventListener("resize", onResize)
  if (import.meta.client) {
    document.documentElement.classList.remove("nav-open")
    document.body.style.overflow = ""
  }
})

const isCategorySection = computed(() => route.path.startsWith("/category/"))

watch(isCategorySection, (on) => {
  if (on) {
    categoryOpen.value = true
  }
})

function onSearch() {
  router.push({ path: '/', query: keywordInput.value ? { q: keywordInput.value } : {} })
}
</script>
