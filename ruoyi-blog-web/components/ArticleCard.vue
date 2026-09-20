<template>
  <article class="panel article-card" :class="{ 'is-pinned': pinned }">
    <span v-if="pinned" class="pin-badge">{{ label }}</span>
    <NuxtLink :to="articlePath(article)">
      <img v-if="article.cover" :src="mediaUrl(article.cover)" :alt="article.title" />
      <div v-else class="cover-fallback">{{ (article.title || "S").slice(0, 1) }}</div>
    </NuxtLink>
    <div>
      <h2><NuxtLink :to="articlePath(article)">{{ article.title }}</NuxtLink></h2>
      <p v-if="article.summary" class="summary">{{ article.summary }}</p>
      <div v-if="$slots.meta" class="meta">
        <slot name="meta" />
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
const label = "\u7f6e\u9876"
</script>
