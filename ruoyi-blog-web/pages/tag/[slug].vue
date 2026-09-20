<template>
  <div class="feed">
    <section class="panel hero">
      <h1># {{ title }}</h1>
      <p>标签归档</p>
    </section>
    <p v-if="pending" class="panel empty">加载中…</p>
    <p v-else-if="!articles.length" class="panel empty">该标签下还没有文章。</p>
    <article v-for="item in articles" :key="item.articleId" class="panel article-card">
      <NuxtLink :to="articlePath(item)">
        <img v-if="item.cover" :src="mediaUrl(item.cover)" :alt="item.title" />
        <div v-else class="cover-fallback">{{ (item.title || 'S').slice(0, 1) }}</div>
      </NuxtLink>
      <div>
        <h2><NuxtLink :to="articlePath(item)">{{ item.title }}</NuxtLink></h2>
        <p v-if="item.summary" class="summary">{{ item.summary }}</p>
      </div>
    </article>
  </div>
</template>
<script setup lang="ts">
const route = useRoute()
const slug = computed(() => String(route.params.slug || ''))
const { data, pending } = await useAsyncData(
  () => `tag-${slug.value}`,
  async () => {
    const [list, tags] = await Promise.all([
      fetchArticleList({ pageNum: 1, pageSize: 20, tagSlug: slug.value }),
      fetchTags()
    ])
    return { list, tags }
  },
  { watch: [slug] }
)
const articles = computed(() => data.value?.list.rows || [])
const title = computed(() => (data.value?.tags.data || []).find(t => t.slug === slug.value)?.name || slug.value)
const site = await useSiteConfig()
useHead({ title: () => `#${title.value} · ${site.value.siteName || 'SuperYan'}` })
</script>
