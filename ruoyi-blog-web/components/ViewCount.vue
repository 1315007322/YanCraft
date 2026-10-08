<template>
  <span class="view-count" :title="label">
    <Eye :size="size" :stroke-width="2" />
    {{ count }}
  </span>
</template>

<script setup lang="ts">
import { Eye } from "lucide-vue-next"

const props = withDefaults(defineProps<{
  value?: number
  size?: number
}>(), {
  size: 13
})

const count = computed(() => {
  const n = Number(props.value)
  return Number.isFinite(n) && n > 0 ? Math.floor(n) : 0
})

const label = "\u6d4f\u89c8"
</script>
