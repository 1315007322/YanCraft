<template>
  <article class="panel article-card" :class="{ 'is-pinned': pinned }">
    <span v-if="pinned" class="pin-badge">{{ label }}</span>
    <NuxtLink :to="articlePath(article)">
      <img v-if="coverSrc" :src="mediaUrl(coverSrc)" :alt="article.title" />
      <div v-else class="cover-fallback">{{ (article.title || "S").slice(0, 1) }}</div>
    </NuxtLink>
    <div>
      <h2><NuxtLink :to="articlePath(article)">{{ article.title }}</NuxtLink></h2>
      <p v-if="article.summary" class="summary">{{ article.summary }}</p>
      <div class="meta">
        <slot name="meta" />
        <ViewCount :value="article.viewCount" />
      </div>
    </div>
  </article>
</template>

<script setup lang="ts">
import type { CmsArticle } from "~/types/cms"

const props = defineProps<{
  article: CmsArticle
}>()

const pinned = computed(() => props.article.isTop === "1")
const coverSrc = computed(() => props.article.cover || props.article.coverWide)
const label = "\u7f6e\u9876"
</script>
