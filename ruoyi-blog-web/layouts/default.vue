<template>
  <div class="page">
    <header class="topbar">
      <div class="topbar-inner">
        <NuxtLink to="/" class="logo">SUPER<b>YAN</b></NuxtLink>
        <form class="search-box" @submit.prevent="onSearch">
          <input v-model="keywordInput" type="search" :placeholder="'搜索'" />
          <button type="submit">搜索</button>
        </form>
      </div>
    </header>
    <div class="shell">
      <aside class="panel sidenav">
        <div class="profile">
          <div class="avatar">SY</div>
          <strong>SuperYan</strong>
          <span>Going to try and get something up eventually I hope</span>
        </div>
        <nav>
          <ul class="nav-list">
            <li>
              <NuxtLink to="/" exact-active-class="active" active-class="is-partial">
                <House :size="18" :stroke-width="2" />
                <span>首页</span>
              </NuxtLink>
            </li>
            <li>
              <NuxtLink to="/about" exact-active-class="active" active-class="is-partial">
                <User :size="18" :stroke-width="2" />
                <span>关于我</span>
              </NuxtLink>
            </li>
            <li>
              <button class="nav-parent" type="button" :class="{ active: isCategorySection }" @click="categoryOpen = !categoryOpen">
                <span class="nav-parent-main">
                  <Folder :size="18" :stroke-width="2" />
                  <span>分类</span>
                </span>
                <ChevronDown :size="18" :stroke-width="2" class="caret" :class="{ open: categoryOpen }" />
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
            <li>
              <button class="nav-parent" type="button" @click="linkOpen = !linkOpen">
                <span class="nav-parent-main">
                  <LinkIcon :size="18" :stroke-width="2" />
                  <span>友链</span>
                </span>
                <ChevronDown :size="18" :stroke-width="2" class="caret" :class="{ open: linkOpen }" />
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
            </li>
            <li v-if="!hot.length" style="color:#8a9099">暂无</li>
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
          <div class="cloud">
            <template v-for="t in tags" :key="t.tagId">
              <NuxtLink v-if="t.slug" :to="'/tag/' + t.slug">{{ t.name }}</NuxtLink>
            </template>
          </div>
        </div>
      </aside>
    </div>
    <footer class="site-footer">SuperYan</footer>
  </div>
</template>

<script setup lang="ts">
import { ChevronDown, Folder, House, Link as LinkIcon, User } from "lucide-vue-next"

const route = useRoute()
const router = useRouter()
const keywordInput = ref(String(route.query.q || ''))

watch(() => route.query.q, (v) => { keywordInput.value = String(v || '') })

const { data } = await useAsyncData('shell-meta', async () => {
  const [list, cats, tagRes, hotRes, linkRes] = await Promise.all([
    fetchArticleList({ pageNum: 1, pageSize: 1 }),
    fetchCategories(),
    fetchTags(),
    fetchHotArticles(6),
    fetchFriendLinks()
  ])
  return { list, cats, tagRes, hotRes, linkRes }
})

const total = computed(() => data.value?.list.total || 0)
const categories = computed(() => data.value?.cats.data || [])
const tags = computed(() => data.value?.tagRes.data || [])
const hot = computed(() => data.value?.hotRes.data || [])
const friendLinks = computed(() => data.value?.linkRes.data || [])
const categoryOpen = ref(true)
const linkOpen = ref(true)
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
