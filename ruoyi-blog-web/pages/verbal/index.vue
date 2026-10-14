<template>
  <div class="feed verbal-page">
    <section class="panel verbal-hero">
      <div class="verbal-hero-text">
        <p class="verbal-kicker">
          <i class="k0" /><i class="k1" /><i class="k2" />
          <span>每天 0:05 排好</span>
        </p>
        <h1>言语积累</h1>
        <p>先自己说出差别，再翻开。记住的会越隔越久，没记住的明天再来。</p>
      </div>
      <button type="button" class="verbal-random" :disabled="randomLoading" @click="drawRandom">
        <Shuffle :size="18" :stroke-width="2" />
        <span>随机一张</span>
      </button>
    </section>

    <section class="panel verbal-bar">
      <div class="verbal-tabs" role="tablist">
        <NuxtLink :to="link({ tab: undefined, page: undefined })" role="tab" :aria-selected="tab === 'today'" :class="{ on: tab === 'today' }">
          今日卡组<i>{{ todayCards.length }}</i>
        </NuxtLink>
        <NuxtLink :to="link({ tab: 'all', page: undefined })" role="tab" :aria-selected="tab === 'all'" :class="{ on: tab === 'all' }">
          全部卡片<i>{{ allTotal }}</i>
        </NuxtLink>
      </div>
      <div class="verbal-filter">
        <div class="verbal-types">
          <NuxtLink
            v-for="item in typeChips"
            :key="item.value || 'all'"
            :to="link({ type: item.value || undefined, page: undefined })"
            class="verbal-chip"
            :class="['verbal-chip-' + (item.value || 'all'), { on: cardType === item.value }]"
          >{{ item.label }}</NuxtLink>
        </div>
        <form class="verbal-search" @submit.prevent="onSearch">
          <input v-model="keywordInput" type="search" placeholder="搜正面、差别、搭配" />
          <button type="submit">搜索</button>
        </form>
      </div>
    </section>

    <template v-if="tab === 'today'">
      <section v-if="todayCards.length" class="panel verbal-progress">
        <div class="verbal-progress-track"><span :style="{ width: progress + '%' }" /></div>
        <p>
          已翻 <b>{{ flippedCount }}</b> / {{ todayCards.length }}
          <template v-if="missedCount"> · {{ missedCount }} 张明天再来</template>
          <template v-if="flippedCount >= todayCards.length"> · 今天刷完了</template>
        </p>
        <p v-if="notice" class="verbal-notice">{{ notice }}</p>
      </section>
      <p v-if="todayPending" class="panel empty">加载中…</p>
      <p v-else-if="!todayCards.length" class="panel empty">今天没有到期的卡。去「全部卡片」翻翻，或者点「随机一张」。</p>
      <p v-else-if="!todayShown.length" class="panel empty">今日卡组里没有符合筛选的卡。</p>
      <div v-else class="verbal-grid">
        <VerbalCard v-for="card in todayShown" :key="card.cardId" :card="card" @flip="onFlip(card)">
          <button
            type="button"
            class="verbal-miss"
            :disabled="card.missed === '1' || missing === card.cardId"
            @click="miss(card)"
          >{{ card.missed === '1' ? '已推到明天' : '还没记住，明天再来' }}</button>
        </VerbalCard>
      </div>
    </template>

    <template v-else>
      <p v-if="allPending" class="panel empty">加载中…</p>
      <p v-else-if="!allCards.length" class="panel empty">{{ keyword || cardType ? '没有符合条件的卡片。' : '还没有卡片，去后台「考公 / 言语积累」录入。' }}</p>
      <div v-else class="verbal-grid">
        <VerbalCard v-for="card in allCards" :key="card.cardId" :card="card" />
      </div>
      <div v-if="allTotal > pageSize" class="panel pager">
        <NuxtLink :to="link({ page: page > 2 ? String(page - 1) : undefined })" :aria-disabled="page <= 1">上一页</NuxtLink>
        <span>{{ page }} / {{ pageCount }}</span>
        <NuxtLink :to="link({ page: String(page + 1) })" :aria-disabled="page >= pageCount">下一页</NuxtLink>
      </div>
    </template>

    <Teleport to="body">
      <div v-if="randomOpen" class="verbal-modal" role="dialog" aria-modal="true" aria-label="随机一张" @click.self="closeRandom">
        <div class="verbal-modal-body">
          <p class="verbal-modal-head">
            <span>随机一张</span>
            <em v-if="filterHint">{{ filterHint }}</em>
          </p>
          <VerbalCard v-if="randomCard" :key="randomSeq" :card="randomCard" />
          <p v-else-if="!randomLoading" class="verbal-modal-empty">{{ randomMsg }}</p>
          <div class="verbal-modal-actions">
            <button type="button" class="verbal-close" @click="closeRandom">关闭</button>
            <button type="button" class="verbal-random" :disabled="randomLoading" @click="drawRandom">
              <Shuffle :size="16" :stroke-width="2" />
              <span>再抽一张</span>
            </button>
          </div>
        </div>
      </div>
    </Teleport>
  </div>
</template>

<script setup lang="ts">
import { Shuffle } from "lucide-vue-next"
import VerbalCard from "~/components/VerbalCard.vue"
import type { ExamVerbalCard } from "~/types/cms"

const route = useRoute()
const router = useRouter()
const site = await useSiteConfig()

const pageSize = 12
const typeChips = [
  { value: "", label: "全部" },
  { value: "0", label: "实词成语" },
  { value: "1", label: "关联词" },
  { value: "2", label: "主旨句" }
]

const tab = computed(() => (route.query.tab === "all" ? "all" : "today"))
const cardType = computed(() => {
  const value = String(route.query.type || "")
  return ["0", "1", "2"].includes(value) ? value : ""
})
const keyword = computed(() => String(route.query.q || "").trim())
const page = computed(() => Math.max(1, Number(route.query.page || 1)))
const keywordInput = ref(keyword.value)
watch(keyword, (value) => { keywordInput.value = value })

const { data: todayData, pending: todayPending } = await useAsyncData("verbal-today", fetchTodayVerbalCards)
const { data: allData, pending: allPending } = await useAsyncData(
  () => `verbal-all-${page.value}-${cardType.value}-${keyword.value}`,
  () => fetchVerbalCards({ pageNum: page.value, pageSize, keyword: keyword.value, cardType: cardType.value }),
  { watch: [page, cardType, keyword] }
)

const missedIds = ref<number[]>([])
const todayCards = computed<ExamVerbalCard[]>(() =>
  (todayData.value?.data || []).map((card) =>
    missedIds.value.includes(card.cardId || 0) ? { ...card, missed: "1" } : card
  )
)
const todayShown = computed(() =>
  todayCards.value.filter((card) => {
    if (cardType.value && card.cardType !== cardType.value) return false
    if (!keyword.value) return true
    const needle = keyword.value.toLowerCase()
    return [card.prompt, card.difference, card.collocation, card.confusion, card.ownSentence]
      .some((text) => (text || "").toLowerCase().includes(needle))
  })
)
const missedCount = computed(() => todayCards.value.filter((card) => card.missed === "1").length)

const allCards = computed(() => allData.value?.rows || [])
const allTotal = computed(() => allData.value?.total || 0)
const pageCount = computed(() => Math.max(1, Math.ceil(allTotal.value / pageSize)))

const flippedIds = ref<number[]>([])
const flippedCount = computed(() => todayCards.value.filter((card) => flippedIds.value.includes(card.cardId || 0)).length)
const progress = computed(() => (todayCards.value.length ? Math.round((flippedCount.value / todayCards.value.length) * 100) : 0))

function storageKey() {
  const now = new Date()
  const pad = (n: number) => String(n).padStart(2, "0")
  return `verbal-flipped-${now.getFullYear()}-${pad(now.getMonth() + 1)}-${pad(now.getDate())}`
}

function onFlip(card: ExamVerbalCard) {
  const id = card.cardId || 0
  if (!id || flippedIds.value.includes(id)) return
  flippedIds.value = [...flippedIds.value, id]
  try {
    localStorage.setItem(storageKey(), JSON.stringify(flippedIds.value))
  } catch {
    // private mode
  }
}

const missing = ref<number | null>(null)
const notice = ref("")

async function miss(card: ExamVerbalCard) {
  if (!card.cardId) return
  missing.value = card.cardId
  const res = await missVerbalCard(card.cardId)
  missing.value = null
  if (res.code === 200) {
    missedIds.value = [...missedIds.value, card.cardId]
    onFlip(card)
    notice.value = ""
  } else {
    notice.value = res.msg || "没推成，稍后再试"
  }
}

const randomOpen = ref(false)
const randomLoading = ref(false)
const randomCard = ref<ExamVerbalCard | null>(null)
const randomMsg = ref("")
const randomSeq = ref(0)
const filterHint = computed(() => {
  const label = typeChips.find((item) => item.value === cardType.value && item.value)?.label
  return [label, keyword.value ? `“${keyword.value}”` : ""].filter(Boolean).join(" · ")
})

async function drawRandom() {
  randomOpen.value = true
  randomLoading.value = true
  const res = await fetchRandomVerbalCard(keyword.value, cardType.value)
  randomLoading.value = false
  if (res.code === 200 && res.data) {
    randomCard.value = res.data
    randomSeq.value++
  } else {
    randomCard.value = null
    randomMsg.value = res.msg && res.msg !== "unavailable" ? res.msg : "没有可读的卡片"
  }
}

function closeRandom() {
  randomOpen.value = false
}

function onKey(event: KeyboardEvent) {
  if (event.key === "Escape" && randomOpen.value) closeRandom()
}

watch(randomOpen, (open) => {
  if (import.meta.client) document.documentElement.classList.toggle("verbal-lock", open)
})

onMounted(() => {
  try {
    const saved = JSON.parse(localStorage.getItem(storageKey()) || "[]")
    if (Array.isArray(saved)) flippedIds.value = saved.filter((id) => typeof id === "number")
  } catch {
    // ignore broken storage
  }
  window.addEventListener("keydown", onKey)
})

onBeforeUnmount(() => {
  window.removeEventListener("keydown", onKey)
  document.documentElement.classList.remove("verbal-lock")
})

function link(patch: Record<string, string | undefined>) {
  const query: Record<string, string> = {}
  const merged: Record<string, string | undefined> = {
    tab: tab.value === "all" ? "all" : undefined,
    type: cardType.value || undefined,
    q: keyword.value || undefined,
    page: page.value > 1 ? String(page.value) : undefined,
    ...patch
  }
  for (const [key, value] of Object.entries(merged)) {
    if (value) query[key] = value
  }
  return { path: "/verbal", query }
}

function onSearch() {
  router.push(link({ q: keywordInput.value.trim() || undefined, page: undefined }))
}

usePageSeo(site, {
  title: "言语积累",
  description: "言语理解的实词成语、关联词和主旨句积累卡片，每天按间隔复习。"
})
</script>

<style scoped>
.verbal-page {
  --c0: #b4432f;
  --c1: #1f6f78;
  --c2: #9a6a12;
}

.verbal-hero {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  gap: 16px;
  padding: 22px 24px;
  background:
    linear-gradient(115deg, color-mix(in srgb, var(--card) 96%, transparent), color-mix(in srgb, var(--card) 88%, transparent)),
    repeating-linear-gradient(90deg, transparent 0 31px, color-mix(in srgb, var(--c0) 7%, transparent) 31px 32px);
}

.verbal-hero h1 {
  margin: 4px 0 6px;
  font-family: var(--serif);
  font-size: 1.6rem;
  letter-spacing: -0.02em;
}

.verbal-hero-text p:last-child {
  margin: 0;
  color: var(--ink-soft);
  font-size: 15px;
}

.verbal-kicker {
  display: flex;
  align-items: center;
  gap: 5px;
  margin: 0;
  color: var(--muted);
  font-size: 12px;
  letter-spacing: 0.1em;
}

.verbal-kicker i {
  width: 8px;
  height: 8px;
  border-radius: 2px;
}

.verbal-kicker .k0 { background: var(--c0); }
.verbal-kicker .k1 { background: var(--c1); border-radius: 50%; }
.verbal-kicker .k2 { background: var(--c2); }

.verbal-kicker span {
  margin-left: 4px;
}

.verbal-random {
  flex: 0 0 auto;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 9px 16px;
  border: 0;
  border-radius: 999px;
  background: var(--brand);
  color: #fff;
  font: inherit;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  box-shadow: 0 8px 18px color-mix(in srgb, var(--brand) 26%, transparent);
  transition: transform 0.15s ease, box-shadow 0.15s ease;
}

.verbal-random:hover:not(:disabled) {
  transform: translateY(-1px);
}

.verbal-random:disabled {
  opacity: 0.6;
  cursor: wait;
}

.verbal-bar {
  display: flex;
  flex-direction: column;
  gap: 10px;
  padding: 12px 14px;
}

.verbal-tabs {
  display: flex;
  gap: 4px;
  padding: 3px;
  border-radius: 12px;
  background: color-mix(in srgb, var(--ink) 5%, transparent);
  align-self: flex-start;
}

.verbal-tabs a {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 6px 14px;
  border-radius: 9px;
  color: var(--ink-soft);
  font-size: 14px;
  text-decoration: none;
}

.verbal-tabs a.on {
  background: var(--card);
  color: var(--ink);
  font-weight: 600;
  box-shadow: 0 1px 4px rgba(28, 25, 21, 0.08);
}

.verbal-tabs i {
  min-width: 20px;
  padding: 0 6px;
  border-radius: 999px;
  background: color-mix(in srgb, var(--brand) 12%, transparent);
  color: var(--brand);
  font-size: 12px;
  font-style: normal;
  text-align: center;
}

.verbal-filter {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
}

.verbal-types {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.verbal-chip {
  --chip: var(--ink-soft);
  padding: 3px 11px;
  border: 1px solid color-mix(in srgb, var(--chip) 30%, var(--line));
  border-radius: 999px;
  color: var(--chip);
  font-size: 13px;
  text-decoration: none;
}

.verbal-chip-0 { --chip: var(--c0); }
.verbal-chip-1 { --chip: var(--c1); }
.verbal-chip-2 { --chip: var(--c2); }

.verbal-chip.on {
  border-color: var(--chip);
  background: var(--chip);
  color: #fff;
}

.verbal-chip-all.on {
  background: var(--ink);
  border-color: var(--ink);
  color: var(--card);
}

.verbal-search {
  display: flex;
  gap: 6px;
}

.verbal-search input {
  width: 170px;
  padding: 5px 10px;
  border: 1px solid var(--line);
  border-radius: 999px;
  background: var(--card);
  color: var(--ink);
  font: inherit;
  font-size: 13px;
}

.verbal-search button {
  padding: 5px 12px;
  border: 1px solid var(--line);
  border-radius: 999px;
  background: transparent;
  color: var(--ink-soft);
  font: inherit;
  font-size: 13px;
  cursor: pointer;
}

.verbal-progress {
  padding: 12px 16px;
}

.verbal-progress-track {
  height: 6px;
  overflow: hidden;
  border-radius: 999px;
  background: color-mix(in srgb, var(--ink) 7%, transparent);
}

.verbal-progress-track span {
  display: block;
  height: 100%;
  border-radius: inherit;
  background: linear-gradient(90deg, var(--c0), var(--c2) 55%, var(--c1));
  transition: width 0.4s ease;
}

.verbal-progress p {
  margin: 8px 0 0;
  color: var(--muted);
  font-size: 13px;
}

.verbal-progress b {
  color: var(--ink);
}

.verbal-progress .verbal-notice {
  color: var(--brand);
}

.verbal-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 14px;
}

.verbal-miss {
  padding: 4px 12px;
  border: 1px dashed color-mix(in srgb, var(--v) 45%, var(--line));
  border-radius: 999px;
  background: transparent;
  color: var(--v);
  font: inherit;
  font-size: 12px;
  cursor: pointer;
}

.verbal-miss:disabled {
  border-style: solid;
  color: var(--muted);
  cursor: default;
}

.verbal-modal {
  position: fixed;
  inset: 0;
  z-index: 200;
  display: grid;
  place-items: center;
  padding: 20px;
  background: rgba(28, 25, 21, 0.42);
  backdrop-filter: blur(3px);
}

.verbal-modal-body {
  display: flex;
  flex-direction: column;
  gap: 12px;
  width: min(440px, 100%);
}

.verbal-modal-head {
  display: flex;
  align-items: baseline;
  gap: 10px;
  margin: 0;
  color: #fff;
  font-family: var(--serif);
  font-size: 18px;
}

.verbal-modal-head em {
  color: rgba(255, 255, 255, 0.75);
  font-family: var(--sans);
  font-size: 13px;
  font-style: normal;
}

.verbal-modal-body :deep(.verbal-face) {
  min-height: 280px;
}

.verbal-modal-empty {
  margin: 0;
  padding: 40px 20px;
  border-radius: 16px;
  background: var(--card);
  color: var(--muted);
  text-align: center;
}

.verbal-modal-actions {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
}

.verbal-close {
  padding: 9px 16px;
  border: 1px solid rgba(255, 255, 255, 0.5);
  border-radius: 999px;
  background: transparent;
  color: #fff;
  font: inherit;
  font-size: 14px;
  cursor: pointer;
}

:global(html.verbal-lock) {
  overflow: hidden;
}

@media (max-width: 800px) {
  .verbal-hero {
    flex-direction: column;
    align-items: stretch;
    padding: 14px;
  }
  .verbal-hero h1 {
    font-size: 1.25rem;
  }
  .verbal-random {
    justify-content: center;
  }
  .verbal-search,
  .verbal-search input {
    width: 100%;
  }
  .verbal-search input {
    flex: 1;
  }
  .verbal-grid {
    grid-template-columns: 1fr;
    gap: 10px;
  }
}
</style>
