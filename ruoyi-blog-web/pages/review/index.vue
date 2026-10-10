<template>
  <div class="feed">
    <section class="panel hero">
      <h1>股票复盘</h1>
      <p>每天的结论、失误和下一次怎么做。</p>
    </section>
    <p v-if="pending" class="panel empty">加载中…</p>
    <p v-else-if="!reviews.length" class="panel empty">还没有复盘。</p>
    <article v-for="item in reviews" :key="item.reviewId" class="panel article-card review-list-card">
      <NuxtLink :to="'/review/' + item.reviewId">
        <img v-if="coverOf(item)" :src="coverOf(item)" alt="" />
        <div v-else class="cover-fallback">复</div>
      </NuxtLink>
      <div>
        <div>
          <h2><NuxtLink :to="'/review/' + item.reviewId">{{ dayOf(item) }}</NuxtLink></h2>
          <p class="review-list-kicker">复盘</p>
        </div>
        <dl class="review-list-stats">
          <div>
            <dt>情绪</dt>
            <dd :class="moodClass(item.mood)">{{ moodLabel(item.mood) }}</dd>
          </div>
          <div>
            <dt>纪律</dt>
            <dd>{{ item.score ?? 0 }}/5</dd>
          </div>
          <div>
            <dt>交易</dt>
            <dd>{{ item.tradeCount || 0 }} 笔</dd>
          </div>
          <div>
            <dt>当日收益</dt>
            <dd :class="pnlClass(item.profitLoss)">{{ pnlText(item.profitLoss) }}</dd>
          </div>
        </dl>
      </div>
    </article>
    <div v-if="total > pageSize" class="panel pager">
      <NuxtLink :to="pageLink(page - 1)" :aria-disabled="page <= 1">上一页</NuxtLink>
      <span>{{ page }} / {{ pageCount }}</span>
      <NuxtLink :to="pageLink(page + 1)" :aria-disabled="page >= pageCount">下一页</NuxtLink>
    </div>
  </div>
</template>

<script setup lang="ts">
import type { StockReview } from "~/types/cms"

const route = useRoute()
const site = await useSiteConfig()
const page = computed(() => Math.max(1, Number(route.query.page || 1)))
const pageSize = computed(() => site.value.homePageSize || 8)

const { data, pending } = await useAsyncData(
  () => `stock-reviews-${page.value}-${pageSize.value}`,
  () => fetchStockReviews(page.value, pageSize.value),
  { watch: [page, pageSize] }
)

const reviews = computed(() => data.value?.rows || [])
const total = computed(() => data.value?.total || 0)
const pageCount = computed(() => Math.max(1, Math.ceil(total.value / pageSize.value)))

useHead({ title: () => `股票复盘 · ${site.value.siteName || "SuperYan"}` })

const moods: Record<string, string> = {
  "0": "冷静",
  "1": "乐观",
  "2": "谨慎",
  "3": "追涨",
  "4": "恐慌"
}


function coverOf(item: StockReview) {
  const map: Record<string, string | undefined> = {
    "0": site.value.stockReviewCoverCalm,
    "1": site.value.stockReviewCoverOptimistic,
    "2": site.value.stockReviewCoverCautious,
    "3": site.value.stockReviewCoverChase,
    "4": site.value.stockReviewCoverPanic
  }
  return mediaUrl(map[item.mood || ""])
}

function moodLabel(value?: string) {
  return moods[value || ""] || "情绪"
}


function moodClass(value?: string) {
  return "review-mood-" + (value || "x")
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

function dayOf(item: StockReview) {
  return (item.reviewDate || "").slice(0, 10) || "复盘"
}

function pageLink(target: number) {
  return { path: "/review", query: target > 1 ? { page: String(target) } : {} }
}
</script>
