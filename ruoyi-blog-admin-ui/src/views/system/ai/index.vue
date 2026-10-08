<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="配置名称" prop="configName">
        <el-input v-model="queryParams.configName" placeholder="请输入配置名称" clearable style="width: 200px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="用途" prop="purpose">
        <el-select v-model="queryParams.purpose" placeholder="全部用途" clearable style="width: 160px">
          <el-option v-for="item in purposeOptions" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="配置状态" clearable style="width: 160px">
          <el-option v-for="dict in sys_normal_disable" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['system:ai:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate" v-hasPermi="['system:ai:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete" v-hasPermi="['system:ai:remove']">删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="configList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="配置名称" align="center" prop="configName" min-width="140" :show-overflow-tooltip="true" />
      <el-table-column label="用途" align="center" prop="purpose" width="90">
        <template #default="scope">{{ purposeLabel(scope.row.purpose) }}</template>
      </el-table-column>
      <el-table-column label="模型" align="center" prop="modelName" min-width="140" :show-overflow-tooltip="true" />
      <el-table-column label="接口地址" align="center" prop="baseUrl" min-width="180" :show-overflow-tooltip="true" />
      <el-table-column label="API Key" align="center" width="90">
        <template #default="scope">{{ scope.row.hasApiKey === "Y" ? "已配置" : "未配置" }}</template>
      </el-table-column>
      <el-table-column label="默认" align="center" prop="isDefault" width="80">
        <template #default="scope">
          <dict-tag :options="sys_yes_no" :value="scope.row.isDefault" />
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status" width="80">
        <template #default="scope">
          <dict-tag :options="sys_normal_disable" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="操作" width="180" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:ai:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['system:ai:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="640px" append-to-body>
      <el-form ref="aiRef" :model="form" :rules="rules" label-width="108px">
        <el-form-item label="配置名称" prop="configName">
          <el-input v-model="form.configName" maxlength="50" placeholder="例如通义出图、DeepSeek 写作" />
        </el-form-item>
        <el-form-item label="用途" prop="purpose">
          <el-radio-group v-model="form.purpose">
            <el-radio v-for="item in purposeOptions" :key="item.value" :value="item.value">{{ item.label }}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="接口地址" prop="baseUrl">
          <el-input v-model="form.baseUrl" placeholder="https://api.deepseek.com" />
        </el-form-item>
        <el-form-item label="API Key" prop="apiKey">
          <el-input v-model="form.apiKey" type="password" show-password :placeholder="form.configId ? '不修改请留空' : 'API Key'" />
        </el-form-item>
        <el-form-item label="模型名" prop="modelName">
          <el-input v-model="form.modelName" placeholder="deepseek-chat / dall-e-3" />
        </el-form-item>
        <el-form-item label="超时秒数" prop="timeoutSeconds">
          <el-input-number v-model="form.timeoutSeconds" :min="5" :max="300" controls-position="right" />
        </el-form-item>
        <el-form-item v-if="form.purpose === 'chat'" label="maxTokens" prop="maxTokens">
          <el-input-number v-model="form.maxTokens" :min="1" :max="128000" controls-position="right" />
        </el-form-item>
        <el-form-item v-if="form.purpose === 'image'" label="图片尺寸" prop="imageSize">
          <el-input v-model="form.imageSize" placeholder="1024x1024" />
        </el-form-item>
        <el-form-item label="系统提示词" prop="systemPrompt">
          <el-input v-model="form.systemPrompt" type="textarea" :rows="3" :placeholder="form.purpose === 'image' ? '可选，固定画风，会拼在每次封面提示词前面' : '可选，业务可再覆盖'" />
        </el-form-item>
        <el-form-item label="本类默认" prop="isDefault">
          <el-radio-group v-model="form.isDefault">
            <el-radio v-for="dict in sys_yes_no" :key="dict.value" :value="dict.value">{{ dict.label }}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio v-for="dict in sys_normal_disable" :key="dict.value" :value="dict.value">{{ dict.label }}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input-number v-model="form.sort" :min="0" controls-position="right" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts" name="AiConfig">
import { listAiConfig, getAiConfig, addAiConfig, updateAiConfig, delAiConfig } from "@/api/system/ai"
import type { SysAiConfig, AiConfigQueryParams } from "@/types/api/system/ai"

const { proxy } = getCurrentInstance()
const { sys_normal_disable, sys_yes_no } = useDict("sys_normal_disable", "sys_yes_no")

const purposeOptions = [
  { label: "对话", value: "chat" },
  { label: "出图", value: "image" }
]

const configList = ref<SysAiConfig[]>([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref<number[]>([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")

const data = reactive({
  form: {} as SysAiConfig,
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    configName: undefined,
    purpose: undefined,
    status: undefined
  } as AiConfigQueryParams,
  rules: {
    configName: [{ required: true, message: "配置名称不能为空", trigger: "blur" }],
    purpose: [{ required: true, message: "请选择用途", trigger: "change" }],
    baseUrl: [{ required: true, message: "接口地址不能为空", trigger: "blur" }],
    modelName: [{ required: true, message: "模型名不能为空", trigger: "blur" }],
    apiKey: [{
      validator: (_rule: unknown, value: string, callback: (err?: Error) => void) => {
        if (!form.value.configId && !(value || "").trim()) {
          callback(new Error("API Key不能为空"))
          return
        }
        callback()
      },
      trigger: "blur"
    }]
  }
})

const { queryParams, form, rules } = toRefs(data)

function purposeLabel(value?: string) {
  return purposeOptions.find(item => item.value === value)?.label || value || "-"
}

function getList() {
  loading.value = true
  listAiConfig(queryParams.value).then(res => {
    configList.value = res.rows || []
    total.value = res.total
  }).finally(() => {
    loading.value = false
  })
}

function cancel() {
  open.value = false
  reset()
}

function reset() {
  form.value = {
    configId: undefined,
    configName: undefined,
    purpose: "chat",
    baseUrl: undefined,
    apiKey: undefined,
    modelName: undefined,
    timeoutSeconds: 60,
    maxTokens: 4096,
    imageSize: "1024x1024",
    systemPrompt: undefined,
    isDefault: "N",
    status: "0",
    sort: 0,
    remark: undefined
  }
  proxy.resetForm("aiRef")
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

function handleSelectionChange(selection: SysAiConfig[]) {
  ids.value = selection.map(item => item.configId!)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

function handleAdd() {
  reset()
  open.value = true
  title.value = "新增 AI 配置"
}

function handleUpdate(row?: SysAiConfig) {
  reset()
  const configId = row?.configId || ids.value[0]
  getAiConfig(configId).then(res => {
    form.value = {
      timeoutSeconds: 60,
      maxTokens: 4096,
      imageSize: "1024x1024",
      isDefault: "N",
      status: "0",
      sort: 0,
      ...(res.data || {}),
      apiKey: ""
    }
    open.value = true
    title.value = "修改 AI 配置"
  })
}

function submitForm() {
  proxy.$refs["aiRef"].validate((valid: boolean) => {
    if (!valid) {
      return
    }
    const req = form.value.configId ? updateAiConfig(form.value) : addAiConfig(form.value)
    req.then(() => {
      proxy.$modal.msgSuccess(form.value.configId ? "修改成功" : "新增成功")
      open.value = false
      getList()
    })
  })
}

function handleDelete(row?: SysAiConfig) {
  const configIds = row?.configId || ids.value
  proxy.$modal.confirm("是否确认删除选中的 AI 配置？").then(() => {
    return delAiConfig(configIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

getList()
</script>
