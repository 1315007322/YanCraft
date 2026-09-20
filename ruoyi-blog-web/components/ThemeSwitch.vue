<template>
  <div class="theme-switch" role="group" aria-label="theme">
    <button
      v-for="item in THEME_META"
      :key="item.id"
      type="button"
      :aria-pressed="theme === item.id"
      :title="item.hint"
      @click="apply(item.id)"
    >
      {{ item.label }}
    </button>
  </div>
</template>

<script setup lang="ts">
const route = useRoute()
const { theme, apply, THEME_META } = useTheme()

function syncFromRoute() {
  const hit = THEME_META.find(item => item.id === String(route.query.theme || ""))
  if (hit) {
    apply(hit.id)
    return true
  }
  return false
}

onMounted(() => {
  if (syncFromRoute()) {
    return
  }
  const saved = localStorage.getItem("yc-theme")
  const found = THEME_META.find(item => item.id === saved)
  apply(found ? found.id : "paper")
})

watch(() => String(route.query.theme || ""), () => {
  syncFromRoute()
})
</script>
