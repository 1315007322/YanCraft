<template>
  <span class="site-label">
    <el-tooltip placement="top" :show-after="200" popper-class="cms-site-hint">
      <template #content>
        <div class="hint-pop">{{ hint }}</div>
      </template>
      <el-icon class="site-q"><question-filled /></el-icon>
    </el-tooltip>
    {{ text }}
  </span>
</template>

<script setup lang="ts">
defineProps<{
  text: string
  hint: string
}>()
</script>

<style scoped>
.site-label {
  display: inline-flex;
  align-items: center;
  gap: 4px;
}
.site-q {
  cursor: help;
  color: #909399;
  font-size: 14px;
  outline: none;
}
</style>

<style>
.cms-site-hint .hint-pop {
  max-width: 320px;
  line-height: 1.55;
  white-space: normal;
}
</style>
