<template>
  <div class="app-container stock-page">
    <el-row :gutter="12" class="stat-row">
      <el-col v-for="item in statCards" :key="item.key" :xs="12" :sm="6">
        <div class="stat-card" :class="`is-${item.key}`">
          <span>{{ item.label }}</span>
          <strong>{{ item.value }}</strong>
        </div>
      </el-col>
    </el-row>
    <el-row :gutter="16">
      <el-col :xs="24" :lg="9">
        <el-calendar v-model="selectedDate">
          <template #date-cell="{ data }">
            <div class="cal-cell" :class="{ 'is-marked': !!markMap[data.day], 'is-trade': (markMap[data.day] || 0) > 0 }">
              <span>{{ data.day.split('-').pop() }}</span>
              <i v-if="markMap[data.day] !== undefined" class="cal-dot" />
            </div>
          </template>
        </el-calendar>
      </el-col>
      <el-col :xs="24" :lg="15">
        <el-form ref="formRef" :model="form" label-width="96px" class="review-form">
          <div class="form-head">
            <h3>{{ form.reviewDate || '-' }}</h3>
            <div class="form-actions">
              <el-button type="info" plain icon="CopyDocument" v-hasPermi="['stock:review:add', 'stock:review:edit']" @click="copyPrevious">复制上一交易日</el-button>
              <el-button type="warning" plain icon="Document" v-hasPermi="['stock:review:add', 'stock:review:edit']" @click="openTemplates">套用模板</el-button>
              <el-button type="danger" plain icon="Delete" :disabled="!form.reviewId" v-hasPermi="['stock:review:remove']" @click="handleDeleteDay">删除本日</el-button>
              <el-button type="primary" :loading="saving" v-hasPermi="['stock:review:add', 'stock:review:edit']" @click="submitForm">保存</el-button>
            </div>
          </div>
          <el-row :gutter="12">
            <el-col :span="12">
              <el-form-item label="市场情绪" prop="mood">
                <el-select v-model="form.mood" placeholder="选择情绪" style="width: 100%">
                  <el-option v-for="dict in stock_review_mood" :key="dict.value" :label="dict.label" :value="dict.value" />
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="纪律评分" prop="score">
                <el-rate v-model="form.score" :max="5" />
              </el-form-item>
            </el-col>
          </el-row>
          <el-form-item label="今日结论">
            <markdown-editor v-model="form.conclusion" :min-height="180" placeholder="今天市场和自己做对了什么" />
          </el-form-item>
          <el-form-item label="做错了什么">
            <markdown-editor v-model="form.mistake" :min-height="180" placeholder="可以留空" />
          </el-form-item>
          <el-form-item label="下次怎么做">
            <markdown-editor v-model="form.nextPlan" :min-height="180" placeholder="可以留空" />
          </el-form-item>
          <el-form-item label="当日交易">
            <el-button type="primary" plain icon="Plus" @click="addTrade">加一行</el-button>
            <el-table :data="form.trades" class="trade-table">
              <el-table-column label="股票" min-width="220">
                <template #default="scope">
                  <el-select
                    v-model="scope.row.stockCode"
                    filterable
                    remote
                    reserve-keyword
                    allow-create
                    default-first-option
                    clearable
                    placeholder="输入代码或名称"
                    :remote-method="queryStockSymbols"
                    :loading="symbolLoading"
                    style="width: 100%"
                    @focus="queryStockSymbols('')"
                    @change="(val) => onStockPicked(scope.row, val)"
                  >
                    <el-option
                      v-for="item in symbolList"
                      :key="item.stockCode"
                      :label="formatSymbol(item)"
                      :value="item.stockCode"
                    />
                  </el-select>
                </template>
              </el-table-column>
              <el-table-column label="方向" width="110">
                <template #default="scope">
                  <el-select v-model="scope.row.direction" style="width: 100%">
                    <el-option v-for="dict in stock_trade_direction" :key="dict.value" :label="dict.label" :value="dict.value" />
                  </el-select>
                </template>
              </el-table-column>
              <el-table-column label="数量" width="120">
                <template #default="scope"><el-input-number v-model="scope.row.quantity" :min="0" :controls="false" style="width: 100%" /></template>
              </el-table-column>
              <el-table-column label="价格" width="120">
                <template #default="scope"><el-input-number v-model="scope.row.price" :min="0" :precision="4" :controls="false" style="width: 100%" /></template>
              </el-table-column>
              <el-table-column label="盈亏" width="120">
                <template #default="scope"><el-input-number v-model="scope.row.profitLoss" :precision="2" :controls="false" style="width: 100%" /></template>
              </el-table-column>
              <el-table-column label="结果" width="120">
                <template #default="scope">
                  <el-select v-model="scope.row.resultTag" clearable style="width: 100%">
                    <el-option v-for="dict in stock_trade_result" :key="dict.value" :label="dict.label" :value="dict.value" />
                  </el-select>
                </template>
              </el-table-column>
              <el-table-column label="备注" min-width="140">
                <template #default="scope"><el-input v-model="scope.row.note" maxlength="500" /></template>
              </el-table-column>
              <el-table-column width="70" align="center">
                <template #default="scope"><el-button link type="danger" @click="removeTrade(scope.$index)">删除</el-button></template>
              </el-table-column>
            </el-table>
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>
    <el-form :model="queryParams" :inline="true" class="mt16">
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
      </el-form-item>
    </el-form>
    <el-table v-loading="loading" :data="reviewList" @row-click="openRow">
      <el-table-column label="日期" prop="reviewDate" width="120" />
      <el-table-column label="市场情绪" prop="mood" width="90" align="center">
        <template #default="scope"><dict-tag :options="stock_review_mood" :value="scope.row.mood" /></template>
      </el-table-column>
      <el-table-column label="纪律评分" prop="score" width="80" align="center" />
      <el-table-column label="交易笔数" prop="tradeCount" width="100" align="center" />
      <el-table-column label="今日结论" prop="conclusion" min-width="240" show-overflow-tooltip />
      <el-table-column label="操作" width="90" align="center">
        <template #default="scope"><el-button link type="primary" @click.stop="openRow(scope.row)">打开</el-button></template>
      </el-table-column>
    </el-table>
    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
    <el-dialog v-model="templateOpen" title="复盘模板" width="720px" append-to-body>
      <p class="tpl-hint">第一次不知道怎么写，选一个套上，把带冒号的空行填完即可。不会改你的交易明细。</p>
      <div class="tpl-grid">
        <div v-for="item in templates" :key="item.templateId" class="tpl-card">
          <div class="tpl-card-head">
            <strong>{{ item.templateName }}</strong>
            <el-tag v-if="item.systemTemplate" size="small" type="info" effect="plain">系统</el-tag>
            <el-tag v-else size="small" effect="plain">我的</el-tag>
          </div>
          <p>{{ item.summary }}</p>
          <div class="tpl-card-actions">
            <el-button type="primary" size="small" @click="applyTemplate(item)">套用</el-button>
            <el-button v-if="!item.systemTemplate" size="small" type="danger" plain @click="removeTemplate(item)">删除</el-button>
          </div>
        </div>
      </div>
      <template #footer>
        <el-button @click="templateOpen = false">关闭</el-button>
        <el-button type="primary" plain @click="saveAsTemplate">把今天写的存为我的模板</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts" name="StockReview">
import {
  delStockReview,
  delStockReviewTemplate,
  getPreviousTrades,
  getStockReviewByDate,
  getStockReviewCalendar,
  getStockReviewStatistics,
  listStockReview,
  listStockReviewTemplates,
  listStockSymbols,
  saveStockReview,
  saveStockReviewTemplate
} from "@/api/stock/review"
import type { StockReview, StockReviewQueryParams, StockReviewStatistics, StockReviewTrade, StockReviewTemplate, StockSymbol } from "@/types"

const { proxy } = getCurrentInstance()
const { stock_review_mood, stock_trade_direction, stock_trade_result } = proxy.useDict(
  "stock_review_mood",
  "stock_trade_direction",
  "stock_trade_result"
)

const selectedDate = ref(new Date())
const viewYear = ref(selectedDate.value.getFullYear())
const viewMonth = ref(selectedDate.value.getMonth() + 1)
const markMap = ref<Record<string, number>>({})
const statistics = ref<StockReviewStatistics>({})
const saving = ref(false)
const loading = ref(false)
const templateOpen = ref(false)
const templates = ref<StockReviewTemplate[]>([])
const symbolLoading = ref(false)
const symbolList = ref<StockSymbol[]>([])
let symbolTimer: ReturnType<typeof setTimeout> | undefined
const total = ref(0)
const reviewList = ref<StockReview[]>([])
const queryParams = reactive<StockReviewQueryParams>({
  pageNum: 1,
  pageSize: 10,
  keyword: undefined,
  resultTag: undefined
})

const form = reactive<StockReview>({
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

function formatPnl(value?: number) {
  if (value === undefined || value === null) return "0"
  const num = Number(value)
  return (num > 0 ? "+" : "") + num.toFixed(2)
}


function formatSymbol(item: StockSymbol) {
  const code = item.stockCode || ""
  const name = item.stockName || ""
  if (!name || name === code) return code
  return code + "  " + name
}

function rememberSymbols(rows: Array<{ stockCode?: string, stockName?: string }>) {
  const next: Record<string, StockSymbol> = {}
  symbolList.value.forEach((item) => {
    if (item.stockCode) next[item.stockCode] = item
  })
  rows.forEach((row) => {
    const code = (row.stockCode || "").trim()
    if (!code) return
    next[code] = { stockCode: code, stockName: row.stockName || code }
  })
  symbolList.value = Object.keys(next).map((key) => next[key])
}

function selectedTradeSymbols(): StockSymbol[] {
  return (form.trades || [])
    .filter((row) => !!(row.stockCode || "").trim())
    .map((row) => ({ stockCode: (row.stockCode || "").trim(), stockName: row.stockName || row.stockCode }))
}

function queryStockSymbols(query: string) {
  if (symbolTimer) clearTimeout(symbolTimer)
  symbolTimer = setTimeout(() => {
    symbolLoading.value = true
    listStockSymbols(query).then((res) => {
      const hits = res.data || []
      const next: Record<string, StockSymbol> = {}
      hits.forEach((row) => {
        const code = (row.stockCode || "").trim()
        if (code) next[code] = { stockCode: code, stockName: row.stockName || code }
      })
      selectedTradeSymbols().forEach((row) => {
        if (row.stockCode && !next[row.stockCode]) next[row.stockCode] = row
      })
      symbolList.value = Object.keys(next).map((key) => next[key])
    }).finally(() => {
      symbolLoading.value = false
    })
  }, query ? 220 : 0)
}

function onStockPicked(row: StockReviewTrade, value: string) {
  const code = (value || "").trim()
  if (!code) {
    row.stockCode = ""
    row.stockName = ""
    return
  }
  const found = symbolList.value.find((item) => item.stockCode === code)
  row.stockCode = code
  row.stockName = found && found.stockName ? found.stockName : (row.stockName || code)
  rememberSymbols([{ stockCode: row.stockCode, stockName: row.stockName }])
}

function emptyTrade(): StockReviewTrade {
  return { stockCode: "", stockName: "", direction: "0", quantity: undefined, price: undefined, profitLoss: undefined, resultTag: undefined, note: "" }
}

function loadMonth() {
  getStockReviewCalendar(viewYear.value, viewMonth.value).then((res) => {
    const next: Record<string, number> = {}
    ;(res.data || []).forEach((item) => {
      if (item.reviewDate) next[item.reviewDate] = item.tradeCount || 0
    })
    markMap.value = next
  })
  getStockReviewStatistics(viewYear.value, viewMonth.value).then((res) => {
    statistics.value = res.data || {}
  })
}

function loadDay() {
  const day = formatDay(selectedDate.value)
  getStockReviewByDate(day).then((res) => {
    const data = res.data || {}
    form.reviewId = data.reviewId
    form.reviewDate = data.reviewDate || day
    form.mood = data.mood || "0"
    form.score = data.score == null ? 3 : data.score
    form.conclusion = data.conclusion || ""
    form.mistake = data.mistake || ""
    form.nextPlan = data.nextPlan || ""
    form.trades = (data.trades && data.trades.length) ? data.trades : [emptyTrade()]
    rememberSymbols(form.trades || [])
  })
}

function addTrade() {
  form.trades = (form.trades || []).concat(emptyTrade())
}

function removeTrade(index: number) {
  const rows = form.trades ? [...form.trades] : []
  rows.splice(index, 1)
  form.trades = rows.length ? rows : [emptyTrade()]
}

function copyPrevious() {
  getPreviousTrades(form.reviewDate || formatDay(selectedDate.value)).then((res) => {
    const rows = res.data || []
    if (!rows.length) {
      proxy.$modal.msgWarning("没有可复制的上一交易日")
      return
    }
    form.trades = rows.map((item) => ({
      stockCode: item.stockCode,
      stockName: item.stockName,
      direction: item.direction || "0",
      resultTag: item.resultTag,
      quantity: undefined,
      price: undefined,
      profitLoss: undefined,
      note: ""
    }))
    rememberSymbols(form.trades || [])
    proxy.$modal.msgSuccess("已带入代码，数量价格请重填")
  })
}

function hasReviewText() {
  return !!(form.conclusion || form.mistake || form.nextPlan)
}

function openTemplates() {
  listStockReviewTemplates().then((res) => {
    templates.value = res.data || []
    templateOpen.value = true
  })
}

function applyTemplate(item: StockReviewTemplate) {
  const run = () => {
    form.mood = item.mood || "0"
    form.score = item.score == null ? form.score : item.score
    form.conclusion = item.conclusion || ""
    form.mistake = item.mistake || ""
    form.nextPlan = item.nextPlan || ""
    templateOpen.value = false
    proxy.$modal.msgSuccess("已套用「{name}」，把空行填上再保存".replace("{name}", item.templateName || ""))
  }
  if (hasReviewText()) {
    proxy.$modal.confirm("当前已有文字，套用模板会覆盖结论三栏，交易明细不动。是否继续？").then(run).catch(() => {})
  } else {
    run()
  }
}

function saveAsTemplate() {
  proxy.$modal.prompt("给这个模板起个名字").then(({ value }: any) => {
    const name = (value || "").trim()
    if (!name) {
      proxy.$modal.msgError("请填写名称")
      return
    }
    return saveStockReviewTemplate({
      templateName: name,
      summary: "来自 " + (form.reviewDate || "") ,
      mood: form.mood,
      score: form.score,
      conclusion: form.conclusion,
      mistake: form.mistake,
      nextPlan: form.nextPlan
    })
  }).then((res: any) => {
    if (!res) return
    proxy.$modal.msgSuccess("已保存到我的模板")
    return listStockReviewTemplates()
  }).then((res: any) => {
    if (res) templates.value = res.data || []
  }).catch(() => {})
}

function removeTemplate(item: StockReviewTemplate) {
  if (!item.templateId) return
  proxy.$modal.confirm("删除模板「" + item.templateName + "」？").then(() => delStockReviewTemplate(item.templateId!)).then(() => {
    proxy.$modal.msgSuccess("已删除")
    return listStockReviewTemplates()
  }).then((res: any) => {
    if (res) templates.value = res.data || []
  }).catch(() => {})
}

function submitForm() {
  saving.value = true
  saveStockReview({
    ...form,
    reviewDate: form.reviewDate || formatDay(selectedDate.value),
    trades: form.trades
  }).then(() => {
    proxy.$modal.msgSuccess("保存成功")
    loadMonth()
    loadDay()
    getList()
  }).finally(() => {
    saving.value = false
  })
}

function handleDeleteDay() {
  if (!form.reviewId) return
  proxy.$modal.confirm("确认删除这一天的复盘？").then(() => delStockReview(form.reviewId!)).then(() => {
    proxy.$modal.msgSuccess("删除成功")
    loadMonth()
    loadDay()
    getList()
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

function openRow(row: StockReview) {
  if (!row.reviewDate) return
  selectedDate.value = new Date(row.reviewDate.replace(/-/g, "/"))
}

watch(selectedDate, (value) => {
  const year = value.getFullYear()
  const month = value.getMonth() + 1
  if (year !== viewYear.value || month !== viewMonth.value) {
    viewYear.value = year
    viewMonth.value = month
    loadMonth()
  }
  loadDay()
}, { immediate: true })

loadMonth()
queryStockSymbols("")
getList()
</script>

<style scoped>
.stat-row { margin-bottom: 16px; }
.stat-card { min-height: 88px; padding: 16px 18px; border: 1px solid #e7eaf0; border-radius: 10px; background: var(--el-bg-color); }
.stat-card span { display: block; color: var(--el-text-color-secondary); font-size: 13px; }
.stat-card strong { display: block; margin-top: 6px; font-size: 26px; line-height: 1.2; }
.stat-card.is-pnl strong { font-size: 22px; }
.form-head { display: flex; align-items: center; justify-content: space-between; gap: 12px; margin-bottom: 12px; }
.form-head h3 { margin: 0; }
.form-actions { display: flex; flex-wrap: wrap; gap: 8px; }
.cal-cell { display: flex; flex-direction: column; align-items: center; gap: 4px; height: 100%; }
.cal-dot { width: 6px; height: 6px; border-radius: 50%; background: var(--el-color-primary); }
.cal-cell.is-trade .cal-dot { background: var(--el-color-success); }
.trade-table { margin-top: 10px; }
.mt16 { margin-top: 16px; }
.review-form :deep(.el-form-item) { align-items: flex-start; }
.tpl-hint { margin: 0 0 12px; color: var(--el-text-color-secondary); font-size: 13px; line-height: 1.5; }
.tpl-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
.tpl-card { padding: 12px 14px; border: 1px solid #e7eaf0; border-radius: 10px; }
.tpl-card p { min-height: 44px; margin: 8px 0 12px; color: var(--el-text-color-regular); font-size: 13px; line-height: 1.5; }
.tpl-card-head { display: flex; align-items: center; gap: 8px; }
.tpl-card-actions { display: flex; gap: 8px; }
@media (max-width: 768px) { .tpl-grid { grid-template-columns: 1fr; } }
</style>
