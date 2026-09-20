<template>
  <section class="panel about-body">
    <header class="resume-head">
      <p class="resume-kicker">{{ kicker }}</p>
      <h1>{{ site.aboutTitle || site.author || site.siteName }}</h1>
      <p v-if="site.authorSignature" class="resume-sign">{{ site.authorSignature }}</p>
    </header>
    <div class="markdown resume-md" v-html="html" />
  </section>
</template>

<script setup lang="ts">
import resumeTemplate from "~/assets/about-resume.md?raw"

const kicker = "\u7b80\u5386"
const STUB = "\u5199\u4f5c\u5728\u82e5\u4f9d\u540e\u53f0\u5b8c\u6210\uff0c\u8fd9\u91cc\u53ea\u8bfb\u5df2\u53d1\u5e03\u7684 Markdown \u6587\u7ae0\u3002"
const site = await useSiteConfig()
const source = computed(() => {
  const raw = (site.value.aboutContent || "").trim()
  if (!raw || raw === STUB) {
    return resumeTemplate
  }
  return raw
})
const html = computed(() => renderMarkdown(source.value))
useHead({ title: () => site.value.aboutTitle || site.value.author || site.value.siteName || "SuperYan" })
</script>
