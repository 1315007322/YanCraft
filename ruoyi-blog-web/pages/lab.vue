<template>
  <div class="lab-page">
    <section class="panel lab-hero">
      <div>
        <p class="lab-kicker">PROJECT INDEX</p>
        <h1>实验室</h1>
        <p>正在构建、已经完成，以及值得被打开看一看的项目。</p>
      </div>
      <div class="lab-count" aria-label="项目数量">
        <strong>{{ projects.length }}</strong>
        <span>PROJECTS</span>
      </div>
    </section>

    <p v-if="pending" class="panel empty">正在整理实验台…</p>
    <p v-else-if="!projects.length" class="panel empty">实验室暂时是空的。</p>

    <section v-else class="lab-grid" aria-label="实验室项目">
      <article
        v-for="(project, index) in projects"
        :key="project.projectId"
        class="panel lab-card"
        :style="{ '--delay': `${index * 55}ms` }"
      >
        <a
          v-if="project.previewUrl"
          class="lab-cover"
          :href="project.previewUrl"
          target="_blank"
          rel="noopener noreferrer"
          :aria-label="`预览 ${project.projectName}`"
        >
          <img v-if="project.cover" :src="mediaUrl(project.cover)" :alt="project.projectName || '项目封面'" />
          <div v-else class="lab-cover-fallback">
            <span>{{ String(index + 1).padStart(2, "0") }}</span>
            <FlaskConical :size="34" :stroke-width="1.5" />
          </div>
          <span class="lab-cover-action">打开预览 <ArrowUpRight :size="16" /></span>
        </a>
        <div v-else class="lab-cover">
          <img v-if="project.cover" :src="mediaUrl(project.cover)" :alt="project.projectName || '项目封面'" />
          <div v-else class="lab-cover-fallback">
            <span>{{ String(index + 1).padStart(2, "0") }}</span>
            <FlaskConical :size="34" :stroke-width="1.5" />
          </div>
        </div>

        <div class="lab-card-body">
          <h2>{{ project.projectName }}</h2>
          <p v-if="project.description" class="lab-description">{{ project.description }}</p>
          <div class="lab-actions">
            <a
              v-if="project.previewUrl"
              :href="project.previewUrl"
              target="_blank"
              rel="noopener noreferrer"
              class="lab-link lab-link-primary"
            >
              <ExternalLink :size="17" />
              点击预览
            </a>
            <span v-else class="lab-link lab-link-disabled" aria-disabled="true">
              <ExternalLink :size="17" />
              点击预览
            </span>
            <a
              v-if="project.repoUrl"
              :href="project.repoUrl"
              target="_blank"
              rel="noopener noreferrer"
              class="lab-link"
            >
              <Code2 :size="17" />
              代码仓库
            </a>
            <span v-else class="lab-link lab-link-disabled" aria-disabled="true">
              <Code2 :size="17" />
              代码仓库
            </span>
          </div>
        </div>
      </article>
    </section>
  </div>
</template>

<script setup lang="ts">
import { ArrowUpRight, Code2, ExternalLink, FlaskConical } from "lucide-vue-next"

const { data, pending } = await useAsyncData("cms-lab-projects", fetchLabProjects)
const projects = computed(() => data.value?.data || [])

useHead({ title: "实验室" })
</script>
