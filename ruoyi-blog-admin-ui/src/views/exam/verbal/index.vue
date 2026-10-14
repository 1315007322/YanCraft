<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="类型" prop="cardType">
        <el-select v-model="queryParams.cardType" placeholder="全部类型" clearable style="width: 140px">
          <el-option v-for="item in typeOptions" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="关键词" prop="keyword">
        <el-input v-model="queryParams.keyword" placeholder="正面、差别或搭配" clearable style="width: 220px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['exam:verbal:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()" v-hasPermi="['exam:verbal:remove']">删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="cardList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="类型" align="center" prop="cardType" width="110">
        <template #default="scope">
          <el-tag :type="typeTag(scope.row.cardType)" effect="light" disable-transitions>{{ typeLabel(scope.row.cardType) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="正面" align="left" prop="prompt" min-width="180" :show-overflow-tooltip="true" />
      <el-table-column label="差别" align="left" prop="difference" min-width="220" :show-overflow-tooltip="true" />
      <el-table-column label="下次" align="center" prop="dueDate" width="120">
        <template #default="scope">
          <span>{{ scope.row.dueDate }}</span>
        </template>
      </el-table-column>
      <el-table-column label="间隔" align="center" prop="intervalDays" width="80" />
      <el-table-column label="已刷" align="center" prop="reviewCount" width="80" />
      <el-table-column label="操作" align="center" width="160" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['exam:verbal:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['exam:verbal:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="640px" append-to-body>
      <el-form ref="cardRef" :model="form" :rules="rules" label-width="96px">
        <el-form-item label="类型" prop="cardType">
          <el-select v-model="form.cardType" placeholder="选择类型" style="width: 100%">
            <el-option v-for="item in typeOptions" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="正面" prop="prompt">
          <el-input v-model="form.prompt" maxlength="80" placeholder="例如：遏制 / 遏止" />
        </el-form-item>
        <el-form-item label="差别" prop="difference">
          <el-input v-model="form.difference" type="textarea" maxlength="500" :rows="3" placeholder="两者到底差在哪" />
        </el-form-item>
        <el-form-item label="搭配" prop="collocation">
          <el-input v-model="form.collocation" maxlength="200" placeholder="可空" />
        </el-form-item>
        <el-form-item label="易混" prop="confusion">
          <el-input v-model="form.confusion" maxlength="200" placeholder="自己最容易错的地方" />
        </el-form-item>
        <el-form-item label="自己的一句" prop="ownSentence">
          <el-input v-model="form.ownSentence" type="textarea" maxlength="300" :rows="2" placeholder="用自己的话记住" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确定</el-button>
          <el-button @click="cancel">取消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts" name="ExamVerbal">
import { listVerbalCard, getVerbalCard, addVerbalCard, updateVerbalCard, delVerbalCard } from "@/api/exam/verbal"
import type { ExamVerbalCard, ExamVerbalQuery } from "@/types"

const { proxy } = getCurrentInstance()
const typeOptions = [
  { value: "0", label: "实词成语" },
  { value: "1", label: "关联词" },
  { value: "2", label: "主旨句" }
]

const cardList = ref<ExamVerbalCard[]>([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref<number[]>([])
const multiple = ref(true)
const total = ref(0)
const title = ref("")

const data = reactive({
  form: {} as ExamVerbalCard,
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    keyword: undefined,
    cardType: undefined
  } as ExamVerbalQuery,
  rules: {
    cardType: [{ required: true, message: "请选择类型", trigger: "change" }],
    prompt: [{ required: true, message: "请填写正面", trigger: "blur" }],
    difference: [{ required: true, message: "请填写差别", trigger: "blur" }]
  }
})

const { queryParams, form, rules } = toRefs(data)

function typeTag(value?: string) {
  if (value === "1") return "success"
  if (value === "2") return "warning"
  return "danger"
}

function typeLabel(value?: string) {
  const found = typeOptions.find((item) => item.value === value)
  return found ? found.label : value
}

function getList() {
  loading.value = true
  listVerbalCard(queryParams.value).then((response) => {
    cardList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function reset() {
  form.value = { cardType: "0", prompt: "", difference: "", collocation: "", confusion: "", ownSentence: "" }
  proxy.resetForm("cardRef")
}

function cancel() {
  open.value = false
  reset()
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

function handleSelectionChange(selection: ExamVerbalCard[]) {
  ids.value = selection.map((item) => item.cardId!)
  multiple.value = !selection.length
}

function handleAdd() {
  reset()
  open.value = true
  title.value = "新增卡片"
}

function handleUpdate(row?: ExamVerbalCard) {
  reset()
  const cardId = row?.cardId || ids.value[0]
  getVerbalCard(cardId).then((response) => {
    form.value = response.data || {}
    open.value = true
    title.value = "修改卡片"
  })
}

function submitForm() {
  proxy.$refs["cardRef"].validate((valid: boolean) => {
    if (!valid) return
    const request = form.value.cardId ? updateVerbalCard(form.value) : addVerbalCard(form.value)
    request.then(() => {
      proxy.$modal.msgSuccess("保存成功")
      open.value = false
      getList()
    })
  })
}

function handleDelete(row?: ExamVerbalCard) {
  const cardIds = row?.cardId ? [row.cardId] : ids.value
  proxy.$modal.confirm("确认删除选中的卡片？").then(() => delVerbalCard(cardIds)).then(() => {
    getList()
    proxy.$modal.msgSuccess("已删除")
  }).catch(() => {})
}

getList()
</script>
