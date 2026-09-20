<template>
  <div class="feed">
    <section class="panel hero">
      <h1>{{ site.siteName }}</h1>
      <p>{{ site.tagline }}</p>
    </section>
    <p v-if="pending" class="panel empty">加载中…</p>
    <p v-else-if="!articles.length" class="panel empty">还没有已发布的文章。</p>
    <ArticleCard v-for="item in articles" :key="item.articleId" :article="item">
      <template #meta>
        <span>{{ item.author || site.author }}</span>
        <span>{{ formatDate(item.publishTime) }}</span>
        <span v-if="item.categoryName">{{ item.categoryName }}</span>
        <span>{{ item.readingTime || 0 }} min</span>
      </template>
    </ArticleCard>
    <div v-if="total > pageSize" class="panel pager">
      <NuxtLink :to="pageLink(page - 1)" :aria-disabled="page <= 1">上一页</NuxtLink>
      <span>{{ page }} / {{ pageCount }}</span>
      <NuxtLink :to="pageLink(page + 1)" :aria-disabled="page >= pageCount">下一页</NuxtLink>
    </div>
  </div>
</template>

<script setup lang="ts">
const route = useRoute()
const site = await useSiteConfig()
const page = computed(() => Math.max(1, Number(route.query.page || 1)))
const keyword = computed(() => String(route.query.q || ''))
const pageSize = computed(() => site.value.homePageSize || 8)
const pageTitle = computed(() => keyword.value ? `搜索：${keyword.value}` : (site.value.siteName || 'SuperYan'))

const { data, pending } = await useAsyncData(
  () => `home-${page.value}-${keyword.value}-${pageSize.value}`,
  () => fetchArticleList({ pageNum: page.value, pageSize: pageSize.value, keyword: keyword.value || undefined }),
  { watch: [page, keyword, pageSize] }
)

const articles = computed(() => data.value?.rows || [])
const total = computed(() => data.value?.total || 0)
const pageCount = computed(() => Math.max(1, Math.ceil(total.value / pageSize.value)))

useHead({ title: () => `${pageTitle.value}` })

function pageLink(target: number) {
  const q: Record<string, string> = {}
  if (keyword.value) q.q = keyword.value
  if (target > 1) q.page = String(target)
  return { path: '/', query: q }
}
</script>
