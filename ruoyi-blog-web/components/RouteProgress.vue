<template>
  <div
    class="route-progress"
    :class="{ 'is-on': visible }"
    role="progressbar"
    :aria-hidden="!visible"
    aria-valuemin="0"
    aria-valuemax="100"
    :aria-valuenow="percent"
  >
    <span class="route-progress-bar" :style="{ transform: `scaleX(${progress})` }" />
  </div>
</template>

<script setup lang="ts">
const visible = ref(false)
const progress = ref(0)
const percent = computed(() => Math.round(progress.value * 100))

let pending = false
let showTimer = 0
let pulseTimer = 0
let hideTimer = 0
let stuckTimer = 0

function clearTimers() {
  window.clearTimeout(showTimer)
  window.clearInterval(pulseTimer)
  window.clearTimeout(hideTimer)
  window.clearTimeout(stuckTimer)
  showTimer = 0
  pulseTimer = 0
  hideTimer = 0
  stuckTimer = 0
}

function pulse() {
  window.clearInterval(pulseTimer)
  pulseTimer = window.setInterval(() => {
    const remain = 0.92 - progress.value
    if (remain <= 0.002) {
      return
    }
    progress.value += remain * 0.12
  }, 220)
}

function start() {
  if (!import.meta.client) {
    return
  }
  pending = true
  window.clearTimeout(hideTimer)
  window.clearTimeout(showTimer)
  showTimer = window.setTimeout(() => {
    if (!pending) {
      return
    }
    visible.value = true
    progress.value = progress.value > 0.08 && progress.value < 1 ? progress.value : 0.1
    pulse()
  }, 180)
  window.clearTimeout(stuckTimer)
  stuckTimer = window.setTimeout(finish, 12000)
}

function finish() {
  if (!import.meta.client) {
    return
  }
  pending = false
  window.clearTimeout(showTimer)
  window.clearInterval(pulseTimer)
  if (!visible.value) {
    progress.value = 0
    return
  }
  progress.value = 1
  hideTimer = window.setTimeout(() => {
    visible.value = false
    progress.value = 0
  }, 280)
}

onMounted(() => {
  const nuxtApp = useNuxtApp()
  nuxtApp.hook("page:start", start)
  nuxtApp.hook("page:finish", finish)
  nuxtApp.hook("page:loading:start", start)
  nuxtApp.hook("page:loading:end", finish)
  nuxtApp.hook("app:error", finish)
})

onBeforeUnmount(() => {
  if (import.meta.client) {
    clearTimers()
  }
})
</script>

<style scoped>
.route-progress {
  position: absolute;
  left: 0;
  right: 0;
  bottom: -1px;
  height: 3px;
  overflow: hidden;
  pointer-events: none;
  opacity: 0;
  z-index: 4;
  transition: opacity 0.18s ease;
}

.route-progress.is-on {
  opacity: 1;
}

.route-progress-bar {
  display: block;
  width: 100%;
  height: 100%;
  transform: scaleX(0);
  transform-origin: left center;
  background-image: linear-gradient(
    90deg,
    #c94b3a 0%,
    #e4a33a 18%,
    #62b56f 38%,
    #3aa3cc 58%,
    #7b6ad6 78%,
    #c94b3a 100%
  );
  background-size: 220% 100%;
  box-shadow: 0 0 10px rgba(201, 75, 58, 0.4);
  animation: route-rainbow 1s linear infinite;
  transition: transform 0.2s ease-out;
}

@keyframes route-rainbow {
  to {
    background-position: 220% 0;
  }
}

@media (prefers-reduced-motion: reduce) {
  .route-progress-bar {
    animation: none;
    background-image: none;
    background-color: var(--brand);
    box-shadow: none;
  }
}
</style>
