<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="昵称" prop="nickname">
        <el-input v-model="queryParams.nickname" placeholder="请输入昵称" clearable style="width: 200px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="启用" prop="status">
        <el-select v-model="queryParams.status" placeholder="启用状态" clearable style="width: 160px">
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
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['cms:link:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()" v-hasPermi="['cms:link:remove']">删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="linkList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="昵称" align="center" prop="nickname" min-width="120" />
      <el-table-column label="描述" align="center" prop="description" min-width="180" show-overflow-tooltip />
      <el-table-column label="网站地址" align="center" prop="siteUrl" min-width="220" show-overflow-tooltip>
        <template #default="scope">
          <el-link v-if="scope.row.siteUrl" :href="scope.row.siteUrl" target="_blank" type="primary">{{ scope.row.siteUrl }}</el-link>
        </template>
      </el-table-column>
      <el-table-column label="排序" align="center" prop="sort" width="80" />
      <el-table-column label="启用" align="center" prop="status" width="100">
        <template #default="scope">
          <dict-tag :options="sys_normal_disable" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="160" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['cms:link:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['cms:link:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="520px" append-to-body>
      <el-form ref="linkRef" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="昵称" prop="nickname">
          <el-input v-model="form.nickname" placeholder="请输入昵称" maxlength="50" />
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入描述" maxlength="200" />
        </el-form-item>
        <el-form-item label="网站地址" prop="siteUrl">
          <el-input v-model="form.siteUrl" placeholder="https://example.com" maxlength="255" />
        </el-form-item>
        <el-form-item label="显示排序" prop="sort">
          <el-input-number v-model="form.sort" controls-position="right" :min="0" />
        </el-form-item>
        <el-form-item label="启用" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio v-for="dict in sys_normal_disable" :key="dict.value" :value="dict.value">{{ dict.label }}</el-radio>
          </el-radio-group>
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

<script setup lang="ts" name="CmsFriendLink">
import { listFriendLink, getFriendLink, addFriendLink, updateFriendLink, delFriendLink } from "@/api/cms/link"
import type { CmsFriendLink, FriendLinkQueryParams } from "@/types"
import { isHttp } from "@/utils/validate"

const { proxy } = getCurrentInstance()
const { sys_normal_disable } = useDict("sys_normal_disable")

const linkList = ref<CmsFriendLink[]>([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref<number[]>([])
const multiple = ref(true)
const total = ref(0)
const title = ref("")

const data = reactive({
  form: {} as CmsFriendLink,
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    nickname: undefined,
    status: undefined
  } as FriendLinkQueryParams,
  rules: {
    nickname: [{ required: true, message: "昵称不能为空", trigger: "blur" }],
    siteUrl: [
      { required: true, message: "网站地址不能为空", trigger: "blur" },
      {
        validator: (_rule: unknown, value: string, callback: (e?: Error) => void) => {
          if (!value || isHttp(value)) {
            callback()
          } else {
            callback(new Error("网站地址需以 http:// 或 https:// 开头"))
          }
        },
        trigger: "blur"
      }
    ]
  }
})

const { queryParams, form, rules } = toRefs(data)

function getList() {
  loading.value = true
  listFriendLink(queryParams.value).then(response => {
    linkList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function cancel() {
  open.value = false
  reset()
}

function reset() {
  form.value = {
    linkId: undefined,
    nickname: undefined,
    description: undefined,
    siteUrl: undefined,
    sort: 0,
    status: "0"
  }
  proxy.resetForm("linkRef")
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

function handleSelectionChange(selection: CmsFriendLink[]) {
  ids.value = selection.map(item => item.linkId!)
  multiple.value = !selection.length
}

function handleAdd() {
  reset()
  open.value = true
  title.value = "新增友链"
}

function handleUpdate(row: CmsFriendLink) {
  reset()
  getFriendLink(row.linkId!).then(response => {
    form.value = response.data!
    open.value = true
    title.value = "修改友链"
  })
}

function submitForm() {
  proxy.$refs["linkRef"].validate((valid: boolean) => {
    if (valid) {
      if (form.value.linkId != undefined) {
        updateFriendLink(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addFriendLink(form.value).then(() => {
          proxy.$modal.msgSuccess("新增成功")
          open.value = false
          getList()
        })
      }
    }
  })
}

function handleDelete(row?: CmsFriendLink) {
  const linkIds = row?.linkId || ids.value
  proxy.$modal.confirm('是否确认删除友链编号为"' + linkIds + '"的数据项？').then(function () {
    return delFriendLink(linkIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

getList()
</script>
