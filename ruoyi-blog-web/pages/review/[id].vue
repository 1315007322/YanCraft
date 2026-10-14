<template>
  <div v-if="review" class="review-page">
    <header class="panel review-head">
      <p class="review-kicker">复盘</p>
      <h1>{{ day }}</h1>
      <div class="review-facts">
        <span class="review-chip">{{ moodLabel(review.mood) }}</span>
        <span class="review-dots" :aria-label="'纪律评分 ' + score + '/5'">
          <i v-for="n in 5" :key="n" :class="{ on: n <= score }" />
        </span>
        <span>{{ (review.trades || []).length }} 笔交易</span>
        <span>当日收益 <b :class="pnlClass(dayPnl)">{{ pnlText(dayPnl) }}</b></span>
      </div>
    </header>
    <section class="panel review-card">
      <h2>今日结论</h2>
      <div v-if="review.conclusion" class="markdown review-md" v-html="html(review.conclusion)" />
      <p v-else class="review-empty">未写</p>
    </section>
    <section class="panel review-card">
      <h2>做错了什么</h2>
      <div v-if="review.mistake" class="markdown review-md" v-html="html(review.mistake)" />
      <p v-else class="review-empty">未写</p>
    </section>
    <section class="panel review-card">
      <h2>下次怎么做</h2>
      <div v-if="review.nextPlan" class="markdown review-md" v-html="html(review.nextPlan)" />
      <p v-else class="review-empty">未写</p>
    </section>
    <section class="panel review-card">
      <h2>当日交易</h2>
      <ul v-if="review.trades && review.trades.length" class="review-trades">
        <li v-for="row in review.trades" :key="row.tradeId" class="review-trade">
          <div class="review-trade-top">
            <strong>{{ tradeName(row) }}</strong>
            <span class="review-chip">{{ directionLabel(row.direction) }}</span>
            <b :class="pnlClass(row.profitLoss)">{{ formatPnl(row.profitLoss) }}</b>
          </div>
          <p class="review-trade-meta">
            {{ formatNum(row.quantity, 0) }} 股 · {{ formatNum(row.price, 4) }} · {{ resultLabel(row.resultTag) }}
          </p>
          <p v-if="row.note" class="review-trade-note">{{ row.note }}</p>
        </li>
      </ul>
      <p v-else class="review-empty">无交易</p>
    </section>
  </div>
  <p v-else class="panel empty">复盘不存在。</p>
</template>

<script setup lang="ts">
import type { StockReviewTrade } from "~/types/cms"

const route = useRoute()
const site = await useSiteConfig()
const id = computed(() => String(route.params.id || ""))
const { data } = await useAsyncData(
  () => `stock-review-${id.value}`,
  () => fetchStockReview(id.value),
  { watch: [id] }
)
const review = computed(() => (data.value?.code === 200 ? data.value.data : undefined))
const day = computed(() => (review.value?.reviewDate || "").slice(0, 10) || "复盘")
const dayPnl = computed(() => {
  const direct = review.value?.profitLoss
  if (direct != null && !Number.isNaN(Number(direct))) return Number(direct)
  const known = (review.value?.trades || []).map((row) => row.profitLoss).filter((value) => value != null) as number[]
  if (!known.length) return null
  return known.reduce((sum, value) => sum + Number(value), 0)
})
const score = computed(() => {
  const n = Number(review.value?.score)
  if (!Number.isFinite(n)) return 0
  return Math.max(0, Math.min(5, Math.round(n)))
})

usePageSeo(site, {
  title: () => `${day.value} 复盘`,
  description: () => review.value?.conclusion,
  type: "article"
})

const moods: Record<string, string> = { "0": "冷静", "1": "乐观", "2": "谨慎", "3": "追涨", "4": "恐慌" }
const directions: Record<string, string> = { "0": "买入", "1": "卖出", "2": "观察" }
const results: Record<string, string> = { "0": "计划内", "1": "追涨", "2": "扛单", "3": "止盈", "4": "止损", "5": "观察" }

function moodLabel(value?: string) {
  return moods[value || ""] || "—"
}
function directionLabel(value?: string) {
  return directions[value || ""] || "—"
}
function resultLabel(value?: string) {
  return results[value || ""] || "—"
}
function html(source?: string) {
  return renderMarkdown(source || "")
}
function tradeName(row: StockReviewTrade) {
  const name = row.stockName || ""
  const code = row.stockCode || ""
  if (name && code && name !== code) return `${name} ${code}`
  return name || code || "—"
}
function formatNum(value?: number, digits = 2) {
  if (value == null || Number.isNaN(Number(value))) return "—"
  return Number(value).toLocaleString("zh-CN", { maximumFractionDigits: digits })
}
function formatPnl(value?: number | null) {
  return pnlText(value)
}
function pnlText(value?: number | null) {
  if (value == null || Number.isNaN(Number(value))) return "未记"
  const n = Number(value)
  if (n === 0) return "持平"
  const text = n.toLocaleString("zh-CN", { maximumFractionDigits: 2 })
  return n > 0 ? `+${text}` : text
}
function pnlClass(value?: number | null) {
  if (value == null || Number.isNaN(Number(value)) || Number(value) === 0) return "review-pnl-flat"
  return Number(value) > 0 ? "review-pnl-up" : "review-pnl-down"
}
</script>
