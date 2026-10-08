<template>
  <div class="theme-grid">
    <button
      v-for="item in BLOG_THEMES"
      :key="item.id"
      type="button"
      class="theme-card"
      :class="{ 'is-active': modelValue === item.id }"
      @click="emit('update:modelValue', item.id)"
    >
      <div
        class="theme-shot"
        :style="{
          '--p-bg': item.preview.bg,
          '--p-card': item.preview.card,
          '--p-ink': item.preview.ink,
          '--p-brand': item.preview.brand,
          '--p-nav': item.preview.nav
        }"
      >
        <div class="theme-chrome">
          <i /><i /><i />
        </div>
        <div class="theme-stage">
          <aside>
            <span class="dot" />
            <em />
            <em />
            <em />
          </aside>
          <main>
            <b />
            <p />
            <div class="mini-card" />
            <div class="mini-card" />
          </main>
        </div>
      </div>
      <strong>{{ item.label }}</strong>
      <span>{{ item.hint }}</span>
      <i v-if="modelValue === item.id" class="theme-check" />
    </button>
  </div>
</template>

<script setup lang="ts">
import { BLOG_THEMES } from "@/utils/blogThemes"

defineProps<{
  modelValue?: string
}>()

const emit = defineEmits<{
  "update:modelValue": [value: string]
}>()
</script>

<style scoped>
.theme-grid {
  width: 100%;
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 16px;
}
.theme-card {
  position: relative;
  margin: 0;
  padding: 0 0 12px;
  border: 2px solid #e7eaf0;
  border-radius: 12px;
  background: #fff;
  text-align: left;
  cursor: pointer;
  overflow: hidden;
}
.theme-card.is-active {
  border-color: var(--el-color-primary);
  box-shadow: 0 0 0 1px var(--el-color-primary) inset;
}
.theme-check {
  position: absolute;
  right: 10px;
  bottom: 10px;
  width: 22px;
  height: 22px;
  border-radius: 50%;
  background: var(--el-color-primary);
}
.theme-check::after {
  content: "";
  position: absolute;
  left: 7px;
  top: 4px;
  width: 6px;
  height: 10px;
  border: solid #fff;
  border-width: 0 2px 2px 0;
  transform: rotate(45deg);
}
.theme-shot {
  height: 148px;
  background:
    radial-gradient(circle at 80% 18%, color-mix(in srgb, var(--p-brand) 16%, transparent), transparent 36%),
    var(--p-bg);
  padding: 14px 14px 0;
}
.theme-chrome {
  display: flex;
  gap: 5px;
  margin-bottom: 8px;
}
.theme-chrome i {
  width: 7px;
  height: 7px;
  border-radius: 50%;
  background: color-mix(in srgb, var(--p-ink) 22%, var(--p-card));
}
.theme-stage {
  display: grid;
  grid-template-columns: 58px 1fr;
  gap: 8px;
  height: 108px;
}
.theme-stage aside,
.theme-stage main {
  background: var(--p-card);
  border: 1px solid color-mix(in srgb, var(--p-ink) 10%, transparent);
  border-radius: 8px 8px 0 0;
  padding: 8px;
}
.theme-stage aside {
  background: var(--p-nav);
}
.theme-stage aside .dot {
  display: block;
  width: 18px;
  height: 18px;
  margin-bottom: 8px;
  border-radius: 50%;
  background: var(--p-brand);
}
.theme-stage aside em {
  display: block;
  height: 5px;
  margin-bottom: 6px;
  border-radius: 99px;
  background: color-mix(in srgb, var(--p-ink) 18%, var(--p-nav));
}
.theme-stage main b {
  display: block;
  width: 42%;
  height: 8px;
  margin-bottom: 8px;
  border-radius: 4px;
  background: var(--p-brand);
}
.theme-stage main p {
  width: 78%;
  height: 5px;
  margin: 0 0 10px;
  border-radius: 4px;
  background: color-mix(in srgb, var(--p-ink) 16%, var(--p-card));
}
.mini-card {
  height: 22px;
  margin-bottom: 6px;
  border-radius: 5px;
  background: color-mix(in srgb, var(--p-ink) 7%, var(--p-card));
}
.theme-card strong {
  display: block;
  margin: 10px 12px 2px;
  font-size: 14px;
  color: var(--el-text-color-primary);
}
.theme-card span {
  display: block;
  margin: 0 36px 0 12px;
  font-size: 12px;
  color: var(--el-text-color-secondary);
}
@media (max-width: 1200px) {
  .theme-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
}
@media (max-width: 768px) {
  .theme-grid { grid-template-columns: 1fr; }
}
</style>
