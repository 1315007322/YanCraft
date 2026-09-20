<template>
  <article v-if="article" class="panel post-wrap">
    <h1>{{ article.title }}</h1>
    <div class="meta">
      <span>{{ article.author || site.author }}</span>
      <span>{{ formatDate(article.publishTime) }}</span>
      <span v-if="article.categoryName">{{ article.categoryName }}</span>
      <span>{{ article.wordCount || 0 }} 字</span>
      <span>{{ article.readingTime || 0 }} min</span>
    </div>
    <img v-if="article.cover" class="post-cover" :src="mediaUrl(article.cover)" :alt="article.title" />
    <div class="markdown" v-html="html" />
  </article>
  <p v-else class="panel empty">文章不存在或未发布。</p>
</template>

<script setup lang="ts">
const route = useRoute()
const site = await useSiteConfig()
const key = computed(() => String(route.params.slug || ''))
const { data } = await useAsyncData(() => `post-${key.value}`, () => fetchArticleByKey(key.value), { watch: [key] })
const article = computed(() => (data.value?.code === 200 ? data.value.data : undefined))
const html = computed(() => renderMarkdown(article.value?.content))
useHead({ title: () => article.value?.title || site.value.siteName || 'SuperYan' })
</script>
