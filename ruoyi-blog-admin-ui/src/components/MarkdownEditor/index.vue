<template>
  <div class="markdown-editor">
    <CodeEditor
      :model-value="modelValue || ''"
      language="markdown"
      :mode="mode"
      :theme="theme"
      :min-height="minHeight"
      :placeholder="placeholder"
      word-wrap
      @update:model-value="emit('update:modelValue', $event)"
    />
  </div>
</template>

<script setup lang="ts">
import { CodeEditor } from "@yancraft/vue"

withDefaults(defineProps<{
  modelValue?: string
  mode?: "edit" | "split" | "preview"
  theme?: "dark" | "light"
  minHeight?: number
  placeholder?: string
}>(), {
  modelValue: "",
  mode: "split",
  theme: "light",
  minHeight: 420,
  placeholder: "请输入 Markdown 正文"
})

const emit = defineEmits<{
  "update:modelValue": [value: string]
}>()
</script>

<style scoped>
.markdown-editor {
  width: 100%;
}
</style>
