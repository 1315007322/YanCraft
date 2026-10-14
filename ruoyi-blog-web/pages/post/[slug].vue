<template>
  <article v-if="article" class="panel post-wrap">
    <h1>{{ article.title }}</h1>
    <div class="meta">
      <span>{{ article.author || site.author }}</span>
      <span>{{ formatDate(article.publishTime) }}</span>
      <span v-if="article.categoryName">{{ article.categoryName }}</span>
      <span>{{ article.wordCount || 0 }} 字</span>
      <span>{{ article.readingTime || 0 }} min</span>
      <ViewCount :value="article.viewCount" />
    </div>
    <ImagePreview
      v-if="heroCover"
      class="post-cover"
      :src="mediaUrl(heroCover)"
      :alt="article.title"
    />
    <div class="markdown" v-html="html" />
  </article>
  <p v-else class="panel empty">文章不存在或未发布。</p>
</template>

<script setup lang="ts">
import ViewCount from "~/components/ViewCount.vue"
import ImagePreview from "~/components/ImagePreview.vue"

const route = useRoute()
const site = await useSiteConfig()
const key = computed(() => String(route.params.slug || ''))
const { data } = await useAsyncData(() => `post-${key.value}`, () => fetchArticleByKey(key.value), { watch: [key] })
const article = computed(() => (data.value?.code === 200 ? data.value.data : undefined))
const heroCover = computed(() => article.value?.coverWide)
const html = computed(() =>
  renderMarkdown(stripLeadingTitle(article.value?.content || "", article.value?.title))
)
usePageSeo(site, {
  title: () => article.value?.title || site.value.siteName || "文章",
  description: () => article.value?.summary,
  image: () => article.value?.coverWide || article.value?.cover,
  type: "article",
  jsonLd: () => {
    const item = article.value
    if (!item) return undefined
    return {
      "@context": "https://schema.org",
      "@type": "BlogPosting",
      headline: item.title,
      description: plainText(item.summary),
      image: item.coverWide || item.cover || undefined,
      datePublished: item.publishTime,
      author: item.author ? { "@type": "Person", name: item.author } : undefined
    }
  }
})
</script>
