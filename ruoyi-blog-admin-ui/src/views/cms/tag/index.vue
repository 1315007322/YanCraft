<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="名称" prop="name">
        <el-input v-model="queryParams.name" placeholder="请输入标签名称" clearable style="width: 200px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['cms:tag:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()" v-hasPermi="['cms:tag:remove']">删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="tagList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="名称" align="center" prop="name" />
      <el-table-column label="访问标识" align="center" prop="slug" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="160" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['cms:tag:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['cms:tag:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="480px" append-to-body>
      <el-form ref="tagRef" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="标签名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入标签名称" />
        </el-form-item>
        <el-form-item label="访问标识" prop="slug">
          <el-input v-model="form.slug" placeholder="可空，英文短链" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
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

<script setup lang="ts" name="CmsTag">
import { listTag, getTag, addTag, updateTag, delTag } from "@/api/cms/tag"
import type { CmsTag, TagQueryParams } from "@/types"

const { proxy } = getCurrentInstance()

const tagList = ref<CmsTag[]>([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref<number[]>([])
const multiple = ref(true)
const total = ref(0)
const title = ref("")

const data = reactive({
  form: {} as CmsTag,
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    name: undefined
  } as TagQueryParams,
  rules: {
    name: [{ required: true, message: "标签名称不能为空", trigger: "blur" }]
  }
})

const { queryParams, form, rules } = toRefs(data)

function getList() {
  loading.value = true
  listTag(queryParams.value).then(response => {
    tagList.value = response.rows
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
    tagId: undefined,
    name: undefined,
    slug: undefined,
    remark: undefined
  }
  proxy.resetForm("tagRef")
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

function handleSelectionChange(selection: CmsTag[]) {
  ids.value = selection.map(item => item.tagId!)
  multiple.value = !selection.length
}

function handleAdd() {
  reset()
  open.value = true
  title.value = "新增标签"
}

function handleUpdate(row: CmsTag) {
  reset()
  getTag(row.tagId!).then(response => {
    form.value = response.data!
    open.value = true
    title.value = "修改标签"
  })
}

function submitForm() {
  proxy.$refs["tagRef"].validate((valid: boolean) => {
    if (valid) {
      if (form.value.tagId != undefined) {
        updateTag(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addTag(form.value).then(() => {
          proxy.$modal.msgSuccess("新增成功")
          open.value = false
          getList()
        })
      }
    }
  })
}

function handleDelete(row?: CmsTag) {
  const tagIds = row?.tagId || ids.value
  proxy.$modal.confirm('是否确认删除标签编号为"' + tagIds + '"的数据项？').then(function () {
    return delTag(tagIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

getList()
</script>
