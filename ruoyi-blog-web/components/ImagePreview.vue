<template>
  <img
    v-if="src"
    v-bind="imgAttrs"
    :class="['img-preview-thumb', attrs.class]"
    :src="src"
    :alt="alt"
    role="button"
    tabindex="0"
    :aria-label="previewLabel"
    @click="open"
    @keydown.enter.prevent="open"
    @keydown.space.prevent="open"
  />
  <Teleport to="body">
    <div
      v-if="visible"
      class="yc-image-preview"
      role="dialog"
      aria-modal="true"
      :aria-label="previewLabel"
      @click.self="close"
    >
      <button class="yc-image-preview-close" type="button" :aria-label="closeLabel" @click="close">
        <X :size="22" :stroke-width="2" />
      </button>
      <img class="yc-image-preview-img" :src="src" :alt="alt" @click.stop />
    </div>
  </Teleport>
</template>

<script setup lang="ts">
import { X } from "lucide-vue-next"

defineOptions({ inheritAttrs: false })

defineProps<{
  src: string
  alt?: string
}>()

const attrs = useAttrs()
const imgAttrs = computed(() => {
  const copy: Record<string, unknown> = { ...attrs }
  delete copy.class
  return copy
})
const visible = ref(false)
const previewLabel = "\u56fe\u7247\u9884\u89c8"
const closeLabel = "\u5173\u95ed\u9884\u89c8"

function lockScroll(lock: boolean) {
  if (!import.meta.client) {
    return
  }
  document.body.style.overflow = lock ? "hidden" : ""
}

function open() {
  visible.value = true
  lockScroll(true)
}

function close() {
  visible.value = false
  lockScroll(false)
}

function onKey(event: KeyboardEvent) {
  if (event.key === "Escape") {
    close()
  }
}

watch(visible, (openNow) => {
  if (!import.meta.client) {
    return
  }
  if (openNow) {
    window.addEventListener("keydown", onKey)
    return
  }
  window.removeEventListener("keydown", onKey)
})

onUnmounted(() => {
  window.removeEventListener("keydown", onKey)
  lockScroll(false)
})
</script>

<style scoped>
.img-preview-thumb {
  cursor: zoom-in;
}
</style>

<style>
.yc-image-preview {
  position: fixed;
  inset: 0;
  z-index: 200;
  display: grid;
  place-items: center;
  padding: 48px 24px 24px;
  background: rgba(16, 14, 12, 0.88);
  cursor: zoom-out;
}

.yc-image-preview-img {
  display: block;
  max-width: min(96vw, 1280px);
  max-height: 88vh;
  width: auto;
  height: auto;
  object-fit: contain;
  border-radius: 8px;
  box-shadow: 0 18px 60px rgba(0, 0, 0, 0.4);
  cursor: default;
}

.yc-image-preview-close {
  position: absolute;
  top: 14px;
  right: 14px;
  width: 40px;
  height: 40px;
  display: grid;
  place-items: center;
  border: 0;
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.12);
  color: #f6f0e7;
  cursor: pointer;
}

.yc-image-preview-close:hover {
  background: rgba(255, 255, 255, 0.22);
}
</style>
