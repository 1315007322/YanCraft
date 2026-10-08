<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="项目名称" prop="projectName">
        <el-input v-model="queryParams.projectName" placeholder="请输入项目名称" clearable style="width: 200px" @keyup.enter="handleQuery" />
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
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['cms:lab:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()" v-hasPermi="['cms:lab:remove']">删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="projectList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="封面" align="center" width="90">
        <template #default="scope">
          <image-preview v-if="scope.row.cover" :src="scope.row.cover" :width="48" :height="48" />
          <span v-else>—</span>
        </template>
      </el-table-column>
      <el-table-column label="项目名称" align="center" prop="projectName" min-width="140" show-overflow-tooltip />
      <el-table-column label="项目描述" align="left" prop="description" min-width="180" show-overflow-tooltip />
      <el-table-column label="仓库地址" align="center" prop="repoUrl" min-width="200" show-overflow-tooltip>
        <template #default="scope">
          <el-link v-if="scope.row.repoUrl" :href="scope.row.repoUrl" target="_blank" type="primary">{{ scope.row.repoUrl }}</el-link>
        </template>
      </el-table-column>
      <el-table-column label="预览地址" align="center" prop="previewUrl" min-width="200" show-overflow-tooltip>
        <template #default="scope">
          <el-link v-if="scope.row.previewUrl" :href="scope.row.previewUrl" target="_blank" type="primary">{{ scope.row.previewUrl }}</el-link>
          <span v-else>—</span>
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
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['cms:lab:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['cms:lab:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="560px" append-to-body>
      <el-form ref="labRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="项目名称" prop="projectName">
          <el-input v-model="form.projectName" placeholder="请输入项目名称" maxlength="100" />
        </el-form-item>
        <el-form-item label="项目描述" prop="description">
          <el-input
            v-model="form.description"
            type="textarea"
            :rows="3"
            maxlength="500"
            show-word-limit
            placeholder="请输入项目简介"
          />
        </el-form-item>
        <el-form-item label="仓库地址" prop="repoUrl">
          <el-input v-model="form.repoUrl" placeholder="https://github.com/..." maxlength="500" />
        </el-form-item>
        <el-form-item label="预览地址" prop="previewUrl">
          <el-input v-model="form.previewUrl" placeholder="可空，https://..." maxlength="500" />
        </el-form-item>
        <el-form-item label="封面" prop="cover">
          <image-upload v-model="form.cover" :limit="1" />
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

<script setup lang="ts" name="CmsLab">
import { listLabProject, getLabProject, addLabProject, updateLabProject, delLabProject } from "@/api/cms/lab"
import type { CmsLabProject, LabProjectQueryParams } from "@/types"
import { isHttp } from "@/utils/validate"

const { proxy } = getCurrentInstance()
const { sys_normal_disable } = useDict("sys_normal_disable")

const projectList = ref<CmsLabProject[]>([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref<number[]>([])
const multiple = ref(true)
const total = ref(0)
const title = ref("")

const data = reactive({
  form: {} as CmsLabProject,
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    projectName: undefined,
    status: undefined
  } as LabProjectQueryParams,
  rules: {
    projectName: [{ required: true, message: "项目名称不能为空", trigger: "blur" }],
    repoUrl: [
      { required: true, message: "仓库地址不能为空", trigger: "blur" },
      {
        validator: (_rule: unknown, value: string, callback: (e?: Error) => void) => {
          if (!value || isHttp(value)) {
            callback()
          } else {
            callback(new Error("仓库地址需以 http:// 或 https:// 开头"))
          }
        },
        trigger: "blur"
      }
    ],
    previewUrl: [
      {
        validator: (_rule: unknown, value: string, callback: (e?: Error) => void) => {
          if (!value || isHttp(value)) {
            callback()
          } else {
            callback(new Error("预览地址需以 http:// 或 https:// 开头"))
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
  listLabProject(queryParams.value).then(response => {
    projectList.value = response.rows
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
    projectId: undefined,
    projectName: undefined,
    description: undefined,
    repoUrl: undefined,
    previewUrl: undefined,
    cover: undefined,
    sort: 0,
    status: "0"
  }
  proxy.resetForm("labRef")
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

function handleSelectionChange(selection: CmsLabProject[]) {
  ids.value = selection.map(item => item.projectId!)
  multiple.value = !selection.length
}

function handleAdd() {
  reset()
  open.value = true
  title.value = "新增实验室项目"
}

function handleUpdate(row: CmsLabProject) {
  reset()
  getLabProject(row.projectId!).then(response => {
    form.value = response.data!
    open.value = true
    title.value = "修改实验室项目"
  })
}

function submitForm() {
  proxy.$refs["labRef"].validate((valid: boolean) => {
    if (valid) {
      if (form.value.projectId != undefined) {
        updateLabProject(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addLabProject(form.value).then(() => {
          proxy.$modal.msgSuccess("新增成功")
          open.value = false
          getList()
        })
      }
    }
  })
}

function handleDelete(row?: CmsLabProject) {
  const projectIds = row?.projectId || ids.value
  proxy.$modal.confirm('是否确认删除实验室项目编号为"' + projectIds + '"的数据项？').then(function () {
    return delLabProject(projectIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

getList()
</script>
