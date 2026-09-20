<template>
  <section class="panel about-body">
    <h1>{{ site.aboutTitle || site.siteName }}</h1>
    <p v-if="site.tagline">{{ site.tagline }}</p>
    <div class="markdown" v-html="html" />
  </section>
</template>
<script setup lang="ts">
const site = await useSiteConfig()
const html = computed(() => renderMarkdown(site.value.aboutContent))
useHead({ title: () => site.value.aboutTitle || site.value.siteName || "SuperYan" })
</script>
