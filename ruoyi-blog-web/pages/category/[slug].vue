<template>
  <div class="feed">
    <section class="panel hero">
      <h1>{{ title }}</h1>
      <p>分类归档</p>
    </section>
    <p v-if="pending" class="panel empty">加载中…</p>
    <p v-else-if="!articles.length" class="panel empty">该分类下还没有文章。</p>
    <ArticleCard v-for="item in articles" :key="item.articleId" :article="item">
      <template #meta>
        <span>{{ formatDate(item.publishTime) }}</span>
        <span>{{ item.readingTime || 0 }} min</span>
      </template>
    </ArticleCard>
  </div>
</template>
<script setup lang="ts">
const route = useRoute()
const slug = computed(() => String(route.params.slug || ''))
const { data, pending } = await useAsyncData(
  () => `cat-${slug.value}`,
  async () => {
    const [list, cats] = await Promise.all([
      fetchArticleList({ pageNum: 1, pageSize: 20, categorySlug: slug.value }),
      fetchCategories()
    ])
    return { list, cats }
  },
  { watch: [slug] }
)
const articles = computed(() => data.value?.list.rows || [])
const title = computed(() => (data.value?.cats.data || []).find(c => c.slug === slug.value)?.name || slug.value)
const site = await useSiteConfig()
useHead({ title: () => `${title.value} · ${site.value.siteName || 'SuperYan'}` })
</script>
