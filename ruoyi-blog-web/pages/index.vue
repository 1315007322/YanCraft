<template>
  <div class="feed">
    <section class="panel hero">
      <h1>SuperYan</h1>
      <p>Going to try and get something up eventually I hope</p>
    </section>
    <p v-if="pending" class="panel empty">加载中…</p>
    <p v-else-if="!articles.length" class="panel empty">还没有已发布的文章。</p>
    <article v-for="item in articles" :key="item.articleId" class="panel article-card">
      <NuxtLink :to="articlePath(item)">
        <img v-if="item.cover" :src="mediaUrl(item.cover)" :alt="item.title" />
        <div v-else class="cover-fallback">{{ (item.title || 'S').slice(0, 1) }}</div>
      </NuxtLink>
      <div>
        <h2><NuxtLink :to="articlePath(item)">{{ item.title }}</NuxtLink></h2>
        <p v-if="item.summary" class="summary">{{ item.summary }}</p>
        <div class="meta">
          <span>{{ item.author || 'SuperYan' }}</span>
          <span>{{ formatDate(item.publishTime) }}</span>
          <span v-if="item.categoryName">{{ item.categoryName }}</span>
          <span>{{ item.readingTime || 0 }} min</span>
        </div>
      </div>
    </article>
    <div v-if="total > pageSize" class="panel pager">
      <NuxtLink :to="pageLink(page - 1)" :aria-disabled="page <= 1">上一页</NuxtLink>
      <span>{{ page }} / {{ pageCount }}</span>
      <NuxtLink :to="pageLink(page + 1)" :aria-disabled="page >= pageCount">下一页</NuxtLink>
    </div>
  </div>
</template>

<script setup lang="ts">
const route = useRoute()
const page = computed(() => Math.max(1, Number(route.query.page || 1)))
const keyword = computed(() => String(route.query.q || ''))
const pageSize = 8
const pageTitle = computed(() => keyword.value ? `搜索：${keyword.value}` : 'SuperYan')

const { data, pending } = await useAsyncData(
  () => `home-${page.value}-${keyword.value}`,
  () => fetchArticleList({ pageNum: page.value, pageSize, keyword: keyword.value || undefined }),
  { watch: [page, keyword] }
)

const articles = computed(() => data.value?.rows || [])
const total = computed(() => data.value?.total || 0)
const pageCount = computed(() => Math.max(1, Math.ceil(total.value / pageSize)))

useHead({ title: () => `${pageTitle.value}` })

function pageLink(target: number) {
  const q: Record<string, string> = {}
  if (keyword.value) q.q = keyword.value
  if (target > 1) q.page = String(target)
  return { path: '/', query: q }
}
</script>
