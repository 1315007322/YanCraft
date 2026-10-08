<template>
  <div class="app-container stock-board">
    <el-row :gutter="12" class="stat-row">
      <el-col v-for="item in statCards" :key="item.key" :xs="12" :sm="6">
        <div class="stat-card" :class="`is-${item.key}`">
          <span>{{ item.label }}</span>
          <strong>{{ item.value }}</strong>
        </div>
      </el-col>
    </el-row>

    <div class="panel list-panel">
      <el-form :model="queryParams" :inline="true">
        <el-form-item label="关键词">
          <el-input v-model="queryParams.keyword" placeholder="结论 / 代码 / 名称" clearable style="width: 200px" @keyup.enter="getList" />
        </el-form-item>
        <el-form-item label="结果标签">
          <el-select v-model="queryParams.resultTag" clearable placeholder="全部" style="width: 140px">
            <el-option v-for="dict in stock_trade_result" :key="dict.value" :label="dict.label" :value="dict.value" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="Search" @click="getList">搜索</el-button>
          <el-button icon="Refresh" @click="resetQuery">重置</el-button>
          <el-button type="primary" icon="EditPen" v-hasPermi="['stock:review:add', 'stock:review:edit']" @click="goWrite()">写今天</el-button>
        </el-form-item>
      </el-form>
      <el-table v-loading="loading" :data="reviewList">
        <el-table-column label="日期" prop="reviewDate" width="120" />
        <el-table-column label="市场情绪" prop="mood" width="90" align="center">
          <template #default="scope"><dict-tag :options="stock_review_mood" :value="scope.row.mood" /></template>
        </el-table-column>
        <el-table-column label="纪律评分" prop="score" width="90" align="center" />
        <el-table-column label="交易笔数" prop="tradeCount" width="100" align="center" />
        <el-table-column label="今日结论" prop="conclusion" min-width="240" show-overflow-tooltip />
        <el-table-column label="操作" width="150" align="center">
          <template #default="scope">
            <el-button link type="primary" @click="openPreview(scope.row)">预览</el-button>
            <el-button link type="primary" v-hasPermi="['stock:review:add', 'stock:review:edit']" @click="goWrite(scope.row.reviewDate)">编写</el-button>
          </template>
        </el-table-column>
      </el-table>
      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    </div>

    <div class="panel list-panel">
      <div class="panel-head">
        <h3>买卖记录</h3>
      </div>
      <el-form :model="tradeQuery" :inline="true">
        <el-form-item label="关键词">
          <el-input v-model="tradeQuery.keyword" placeholder="代码 / 名称 / 备注" clearable style="width: 200px" @keyup.enter="getTradeList" />
        </el-form-item>
        <el-form-item label="方向">
          <el-select v-model="tradeQuery.direction" clearable placeholder="全部" style="width: 140px">
            <el-option v-for="dict in stock_trade_direction" :key="dict.value" :label="dict.label" :value="dict.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="结果标签">
          <el-select v-model="tradeQuery.resultTag" clearable placeholder="全部" style="width: 140px">
            <el-option v-for="dict in stock_trade_result" :key="dict.value" :label="dict.label" :value="dict.value" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="Search" @click="getTradeList">搜索</el-button>
          <el-button icon="Refresh" @click="resetTradeQuery">重置</el-button>
        </el-form-item>
      </el-form>
      <el-table v-loading="tradeLoading" :data="tradeList">
        <el-table-column label="日期" prop="reviewDate" width="120" />
        <el-table-column label="股票" min-width="160">
          <template #default="scope">{{ formatTradeName(scope.row) }}</template>
        </el-table-column>
        <el-table-column label="方向" width="90" align="center">
          <template #default="scope"><dict-tag :options="stock_trade_direction" :value="scope.row.direction" /></template>
        </el-table-column>
        <el-table-column label="数量" prop="quantity" width="90" align="right" />
        <el-table-column label="价格" width="100" align="right">
          <template #default="scope">{{ formatNumber(scope.row.price, 4) }}</template>
        </el-table-column>
        <el-table-column label="盈亏" width="110" align="right">
          <template #default="scope">
            <span :class="pnlClass(scope.row.profitLoss)">{{ formatPnl(scope.row.profitLoss) }}</span>
          </template>
        </el-table-column>
        <el-table-column label="结果" width="90" align="center">
          <template #default="scope"><dict-tag :options="stock_trade_result" :value="scope.row.resultTag" /></template>
        </el-table-column>
        <el-table-column label="备注" prop="note" min-width="160" show-overflow-tooltip />
        <el-table-column label="操作" width="150" align="center">
          <template #default="scope">
            <el-button link type="primary" @click="openPreview({ reviewDate: scope.row.reviewDate })">预览</el-button>
            <el-button link type="primary" v-hasPermi="['stock:review:add', 'stock:review:edit']" @click="goWrite(scope.row.reviewDate)">编写</el-button>
          </template>
        </el-table-column>
      </el-table>
      <pagination v-show="tradeTotal > 0" :total="tradeTotal" v-model:page="tradeQuery.pageNum" v-model:limit="tradeQuery.pageSize" @pagination="getTradeList" />
    </div>

    <el-dialog v-model="previewOpen" :title="preview.reviewDate || '复盘预览'" width="780px" append-to-body destroy-on-close>
      <div v-if="previewLoading" class="preview-empty">加载中...</div>
      <div v-else class="preview-body">
        <div class="preview-meta">
          <span>市场情绪 <dict-tag :options="stock_review_mood" :value="preview.mood" /></span>
          <span>纪律评分 <el-rate v-model="preview.score" disabled /></span>
        </div>
        <section class="preview-section">
          <h4>今日结论</h4>
          <markdown-editor v-if="preview.conclusion" :model-value="preview.conclusion" mode="preview" :min-height="88" />
          <p v-else class="muted">未写</p>
        </section>
        <section class="preview-section">
          <h4>做错了什么</h4>
          <markdown-editor v-if="preview.mistake" :model-value="preview.mistake" mode="preview" :min-height="88" />
          <p v-else class="muted">未写</p>
        </section>
        <section class="preview-section">
          <h4>下次怎么做</h4>
          <markdown-editor v-if="preview.nextPlan" :model-value="preview.nextPlan" mode="preview" :min-height="88" />
          <p v-else class="muted">未写</p>
        </section>
        <section class="preview-section">
          <h4>当日交易</h4>
          <el-table v-if="preview.trades && preview.trades.length" :data="preview.trades" class="trade-table">
            <el-table-column label="股票" min-width="160">
              <template #default="scope">{{ formatTradeName(scope.row) }}</template>
            </el-table-column>
            <el-table-column label="方向" width="90" align="center">
              <template #default="scope"><dict-tag :options="stock_trade_direction" :value="scope.row.direction" /></template>
            </el-table-column>
            <el-table-column label="数量" prop="quantity" width="90" align="right" />
            <el-table-column label="价格" width="100" align="right">
              <template #default="scope">{{ formatNumber(scope.row.price, 4) }}</template>
            </el-table-column>
            <el-table-column label="盈亏" width="100" align="right">
              <template #default="scope">{{ formatPnl(scope.row.profitLoss) }}</template>
            </el-table-column>
            <el-table-column label="结果" width="90" align="center">
              <template #default="scope"><dict-tag :options="stock_trade_result" :value="scope.row.resultTag" /></template>
            </el-table-column>
            <el-table-column label="备注" prop="note" min-width="140" show-overflow-tooltip />
          </el-table>
          <p v-else class="muted">无交易</p>
        </section>
      </div>
      <template #footer>
        <el-button @click="previewOpen = false">关闭</el-button>
        <el-button type="danger" plain :disabled="!preview.reviewId" v-hasPermi="['stock:review:remove']" @click="handleDeleteDay">删除本日</el-button>
        <el-button type="primary" v-hasPermi="['stock:review:add', 'stock:review:edit']" @click="goWrite(preview.reviewDate)">去编写</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts" name="StockReviewBoard">
import { delStockReview, getStockReviewByDate, getStockReviewStatistics, listStockReview, listStockTrades } from "@/api/stock/review"
import type { StockReview, StockReviewQueryParams, StockReviewStatistics, StockReviewTrade, StockTradeQueryParams } from "@/types"

const { proxy } = getCurrentInstance()
const { stock_review_mood, stock_trade_direction, stock_trade_result } = proxy.useDict(
  "stock_review_mood",
  "stock_trade_direction",
  "stock_trade_result"
)

const now = new Date()
const statistics = ref<StockReviewStatistics>({})
const loading = ref(false)
const previewOpen = ref(false)
const previewLoading = ref(false)
const total = ref(0)
const reviewList = ref<StockReview[]>([])
const queryParams = reactive<StockReviewQueryParams>({
  pageNum: 1,
  pageSize: 10,
  keyword: undefined,
  resultTag: undefined
})
const tradeLoading = ref(false)
const tradeTotal = ref(0)
const tradeList = ref<StockReviewTrade[]>([])
const tradeQuery = reactive<StockTradeQueryParams>({
  pageNum: 1,
  pageSize: 10,
  keyword: undefined,
  direction: undefined,
  resultTag: undefined
})
const preview = reactive<StockReview>({
  reviewId: undefined,
  reviewDate: "",
  mood: "0",
  score: 3,
  conclusion: "",
  mistake: "",
  nextPlan: "",
  trades: []
})

const statCards = computed(() => [
  { key: "review", label: "本月复盘天数", value: statistics.value.reviewDays || 0 },
  { key: "trade", label: "本月有交易天数", value: statistics.value.tradeDays || 0 },
  { key: "pnl", label: "本月盈亏合计", value: formatPnl(statistics.value.profitLoss) },
  { key: "tag", label: "最常见失误/结果", value: topTagLabel.value }
])

const topTagLabel = computed(() => {
  const tag = statistics.value.topResultTag
  if (!tag) return "-"
  return proxy.selectDictLabel(stock_trade_result.value, tag) || tag
})

function formatDay(date: Date) {
  const y = date.getFullYear()
  const m = String(date.getMonth() + 1).padStart(2, "0")
  const d = String(date.getDate()).padStart(2, "0")
  return `${y}-${m}-${d}`
}

function formatPnl(value?: number | null) {
  if (value === undefined || value === null) return "0"
  const num = Number(value)
  return (num > 0 ? "+" : "") + num.toFixed(2)
}

function formatNumber(value?: number | null, digits = 2) {
  if (value === undefined || value === null || value === ("" as any)) return "-"
  return Number(value).toFixed(digits)
}

function pnlClass(value?: number | null) {
  if (value === undefined || value === null) return ""
  const num = Number(value)
  if (num > 0) return "is-up"
  if (num < 0) return "is-down"
  return ""
}

function formatTradeName(row: StockReviewTrade) {
  const code = row.stockCode || ""
  const name = row.stockName || ""
  if (!name || name === code) return code || "-"
  return code + "  " + name
}

function loadStats() {
  getStockReviewStatistics(now.getFullYear(), now.getMonth() + 1).then((res) => {
    statistics.value = res.data || {}
  })
}

function fillPreview(data: StockReview, day: string) {
  preview.reviewId = data.reviewId
  preview.reviewDate = data.reviewDate || day
  preview.mood = data.mood || "0"
  preview.score = data.score == null ? 3 : data.score
  preview.conclusion = data.conclusion || ""
  preview.mistake = data.mistake || ""
  preview.nextPlan = data.nextPlan || ""
  preview.trades = (data.trades || []).filter((row) => !!(row.stockCode || row.stockName))
}

function openPreview(row: StockReview) {
  const day = row.reviewDate
  if (!day) return
  previewOpen.value = true
  previewLoading.value = true
  fillPreview({ reviewDate: day, mood: "0", score: 3, conclusion: "", mistake: "", nextPlan: "", trades: [] }, day)
  getStockReviewByDate(day).then((res) => {
    fillPreview(res.data || {}, day)
  }).finally(() => {
    previewLoading.value = false
  })
}

function goWrite(day?: string) {
  const date = day || formatDay(new Date())
  previewOpen.value = false
  proxy.$tab.openPage("写复盘", "/stock/review-write/index", { date })
}

function handleDeleteDay() {
  if (!preview.reviewId) return
  proxy.$modal.confirm("确认删除这一天的复盘？").then(() => delStockReview(preview.reviewId!)).then(() => {
    proxy.$modal.msgSuccess("删除成功")
    previewOpen.value = false
    loadStats()
    getList()
    getTradeList()
  }).catch(() => {})
}

function getList() {
  loading.value = true
  listStockReview(queryParams).then((res) => {
    reviewList.value = res.rows || []
    total.value = res.total || 0
  }).finally(() => {
    loading.value = false
  })
}

function resetQuery() {
  queryParams.keyword = undefined
  queryParams.resultTag = undefined
  queryParams.pageNum = 1
  getList()
}

function getTradeList() {
  tradeLoading.value = true
  listStockTrades(tradeQuery).then((res) => {
    tradeList.value = res.rows || []
    tradeTotal.value = res.total || 0
  }).finally(() => {
    tradeLoading.value = false
  })
}

function resetTradeQuery() {
  tradeQuery.keyword = undefined
  tradeQuery.direction = undefined
  tradeQuery.resultTag = undefined
  tradeQuery.pageNum = 1
  getTradeList()
}

onActivated(() => {
  loadStats()
  getList()
  getTradeList()
})

loadStats()
getList()
getTradeList()
</script>

<style scoped>
.stat-row { margin-bottom: 16px; }
.stat-card { min-height: 88px; padding: 16px 18px; border: 1px solid #eadfd3; border-radius: 12px; background: #fffdf9; }
.stat-card span { display: block; color: #8a6a4a; font-size: 13px; }
.stat-card strong { display: block; margin-top: 6px; font-size: 26px; line-height: 1.2; }
.stat-card.is-pnl strong { font-size: 22px; }
.panel { margin-bottom: 16px; padding: 16px 18px 18px; border: 1px solid #eadfd3; border-radius: 12px; background: #fffdf9; }
.preview-empty { padding: 48px 16px; text-align: center; color: var(--el-text-color-secondary); }
.preview-meta { display: flex; flex-wrap: wrap; gap: 18px; align-items: center; margin-bottom: 8px; }
.preview-section { margin-top: 16px; }
.preview-section h4 { margin: 0 0 8px; color: #8a6a4a; font-size: 12px; letter-spacing: 0.16em; }
.muted { margin: 0; color: var(--el-text-color-secondary); }
.trade-table { margin-top: 8px; }
.panel-head { display: flex; align-items: center; justify-content: space-between; margin-bottom: 12px; }
.panel-head h3 { margin: 0; font-size: 16px; }
.list-panel { padding-bottom: 8px; }
.is-up { color: #c94b3a; }
.is-down { color: #2f6b4f; }
</style>
