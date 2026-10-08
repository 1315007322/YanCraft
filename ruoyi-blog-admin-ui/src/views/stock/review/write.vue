<template>
  <div class="app-container stock-write">
    <el-form ref="formRef" :model="form" label-width="96px" class="review-form">
      <div class="write-head">
        <div class="write-date">
          <el-button icon="ArrowLeft" @click="shiftDay(-1)" />
          <el-date-picker v-model="selectedDate" type="date" placeholder="选择日期" style="width: 168px" />
          <el-button icon="ArrowRight" @click="shiftDay(1)" />
          <el-button link type="primary" @click="goToday">今天</el-button>
        </div>
        <div class="form-actions">
          <el-button icon="Back" @click="goBoard">回看板</el-button>
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
        <markdown-editor v-model="form.conclusion" :min-height="220" placeholder="今天市场和自己做对了什么" />
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
        <el-button type="primary" plain @click="saveAsTemplate">SAVE_套用模板</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts" name="StockReviewWrite">
import {
  delStockReview,
  delStockReviewTemplate,
  getPreviousTrades,
  getStockReviewByDate,
  listStockReviewTemplates,
  listStockSymbols,
  saveStockReview,
  saveStockReviewTemplate
} from "@/api/stock/review"
import type { StockReview, StockReviewTrade, StockReviewTemplate, StockSymbol } from "@/types"

const route = useRoute()
const router = useRouter()
const { proxy } = getCurrentInstance()
const { stock_review_mood, stock_trade_direction, stock_trade_result } = proxy.useDict(
  "stock_review_mood",
  "stock_trade_direction",
  "stock_trade_result"
)

const saving = ref(false)
const templateOpen = ref(false)
const templates = ref<StockReviewTemplate[]>([])
const symbolLoading = ref(false)
const symbolList = ref<StockSymbol[]>([])
let symbolTimer: ReturnType<typeof setTimeout> | undefined
let syncingQuery = false

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

const selectedDate = ref(parseDay(queryDate()))

function queryDate() {
  const value = route.query.date
  return typeof value === "string" ? value : ""
}

function parseDay(value?: string) {
  if (value && /^\d{4}-\d{2}-\d{2}$/.test(value)) {
    return new Date(value.replace(/-/g, "/"))
  }
  return new Date()
}

function asDate(value: Date | string) {
  if (value instanceof Date) return value
  return parseDay(String(value).slice(0, 10))
}

function formatDay(date: Date | string) {
  const value = asDate(date)
  const y = value.getFullYear()
  const m = String(value.getMonth() + 1).padStart(2, "0")
  const d = String(value.getDate()).padStart(2, "0")
  return `${y}-${m}-${d}`
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
  proxy.$modal.prompt("NAME_套用模板").then(({ value }: any) => {
    const name = (value || "").trim()
    if (!name) {
      proxy.$modal.msgError("请填写名称")
      return
    }
    return saveStockReviewTemplate({
      templateName: name,
      summary: "来自 " + (form.reviewDate || ""),
      mood: form.mood,
      score: form.score,
      conclusion: form.conclusion,
      mistake: form.mistake,
      nextPlan: form.nextPlan
    })
  }).then((res: any) => {
    if (!res) return
    proxy.$modal.msgSuccess("SAVED_套用模板")
    return listStockReviewTemplates()
  }).then((res: any) => {
    if (res) templates.value = res.data || []
  }).catch(() => {})
}

function removeTemplate(item: StockReviewTemplate) {
  if (!item.templateId) return
  proxy.$modal.confirm("DEL_套用模板" + item.templateName + "」？").then(() => delStockReviewTemplate(item.templateId!)).then(() => {
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
    loadDay()
  }).finally(() => {
    saving.value = false
  })
}

function handleDeleteDay() {
  if (!form.reviewId) return
  proxy.$modal.confirm("确认删除这一天的复盘？").then(() => delStockReview(form.reviewId!)).then(() => {
    proxy.$modal.msgSuccess("已删除")
    loadDay()
  }).catch(() => {})
}

function shiftDay(delta: number) {
  const next = new Date(asDate(selectedDate.value).getTime())
  next.setDate(next.getDate() + delta)
  selectedDate.value = next
}

function goToday() {
  selectedDate.value = new Date()
}

function goBoard() {
  proxy.$tab.closeOpenPage({ path: "/stock/review" })
}

function syncQuery(day: string) {
  if (route.query.date === day) return
  syncingQuery = true
  router.replace({ path: route.path, query: { ...route.query, date: day } }).finally(() => {
    syncingQuery = false
  })
}

watch(selectedDate, (value) => {
  const day = formatDay(value)
  form.reviewDate = day
  syncQuery(day)
  loadDay()
}, { immediate: true })

watch(() => route.query.date, (value) => {
  if (syncingQuery) return
  const day = typeof value === "string" ? value : ""
  if (!day || day === formatDay(selectedDate.value)) return
  selectedDate.value = parseDay(day)
})

queryStockSymbols("")
</script>

<style scoped>
.write-head { display: flex; align-items: center; justify-content: space-between; gap: 12px; margin-bottom: 16px; }
.write-date { display: flex; align-items: center; gap: 8px; }
.form-actions { display: flex; flex-wrap: wrap; gap: 8px; justify-content: flex-end; }
.trade-table { margin-top: 10px; }
.review-form :deep(.el-form-item) { align-items: flex-start; }
.tpl-hint { margin: 0 0 12px; color: var(--el-text-color-secondary); font-size: 13px; line-height: 1.5; }
.tpl-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
.tpl-card { padding: 12px 14px; border: 1px solid #e7eaf0; border-radius: 10px; }
.tpl-card p { min-height: 44px; margin: 8px 0 12px; color: var(--el-text-color-regular); font-size: 13px; line-height: 1.5; }
.tpl-card-head { display: flex; align-items: center; gap: 8px; }
.tpl-card-actions { display: flex; gap: 8px; }
@media (max-width: 768px) {
  .write-head { flex-direction: column; align-items: flex-start; }
  .tpl-grid { grid-template-columns: 1fr; }
}
</style>
