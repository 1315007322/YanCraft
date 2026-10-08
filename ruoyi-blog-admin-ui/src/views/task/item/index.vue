<template>
  <div class="app-container task-page">
    <el-row :gutter="12" class="stat-row">
      <el-col v-for="item in statCards" :key="item.key" :xs="12" :sm="8" :md="4">
        <div class="stat-card" :class="`is-${item.key}`">
          <span>{{ item.label }}</span>
          <strong>{{ item.value }}</strong>
        </div>
      </el-col>
    </el-row>

    <el-form ref="queryRef" :model="queryParams" :inline="true" v-show="showSearch">
      <el-form-item label="任务" prop="keyword">
        <el-input
          v-model="queryParams.keyword"
          placeholder="名称或描述"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="全部状态" clearable style="width: 140px">
          <el-option v-for="dict in task_status" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="优先级" prop="priority">
        <el-select v-model="queryParams.priority" placeholder="全部优先级" clearable style="width: 140px">
          <el-option v-for="dict in task_priority" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="截止日期">
        <el-date-picker
          v-model="dueDateRange"
          value-format="YYYY-MM-DD"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          style="width: 240px"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd()" v-hasPermi="['task:item:add']">
          新增主任务
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete()"
          v-hasPermi="['task:item:remove']"
        >
          删除
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="info" plain icon="Sort" @click="toggleExpandAll">展开/折叠</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="refresh"></right-toolbar>
    </el-row>

    <el-table
      v-if="refreshTable"
      v-loading="loading"
      :data="taskList"
      row-key="taskId"
      :default-expand-all="isExpandAll"
      :tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="48" align="center" />
      <el-table-column label="任务名称" prop="taskName" min-width="230">
        <template #default="scope">
          <div class="task-name">
            <span>{{ scope.row.taskName }}</span>
            <el-tag v-if="scope.row.parentId !== 0" size="small" type="info" effect="plain">子任务</el-tag>
            <el-tag v-if="scope.row.overdue" size="small" type="danger" effect="dark">逾期</el-tag>
          </div>
          <div v-if="scope.row.description" class="task-description">{{ scope.row.description }}</div>
        </template>
      </el-table-column>
      <el-table-column label="优先级" prop="priority" width="95" align="center">
        <template #default="scope">
          <dict-tag :options="task_priority" :value="scope.row.priority" />
        </template>
      </el-table-column>
      <el-table-column label="状态" prop="status" width="105" align="center">
        <template #default="scope">
          <dict-tag :options="task_status" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="进度" prop="progress" width="260">
        <template #default="scope">
          <div class="progress-cell">
            <el-progress :percentage="scope.row.progress || 0" :stroke-width="8" style="flex: 1" />
            <el-tooltip v-if="scope.row.hasChildren" content="由子任务进度自动计算">
              <el-tag size="small" type="info" effect="plain">自动</el-tag>
            </el-tooltip>
            <div v-else-if="hasQuantity(scope.row)" class="quantity-cell">
              <el-input-number
                v-model="scope.row.completedQuantity"
                :min="0"
                :max="scope.row.totalQuantity"
                :step="1"
                size="small"
                controls-position="right"
                class="quantity-input"
                @change="handleQuantityChange(scope.row)"
              />
              <span>/ {{ scope.row.totalQuantity }}</span>
            </div>
            <el-input-number
              v-else
              v-model="scope.row.progress"
              :min="0"
              :max="100"
              :step="5"
              size="small"
              controls-position="right"
              class="progress-input"
              @change="handleProgressChange(scope.row)"
            />
          </div>
        </template>
      </el-table-column>
      <el-table-column label="计划开始" prop="planStartDate" width="115" align="center">
        <template #default="scope">{{ scope.row.planStartDate || "—" }}</template>
      </el-table-column>
      <el-table-column label="截止日期" prop="dueDate" width="115" align="center">
        <template #default="scope">
          <span :class="{ 'due-overdue': scope.row.overdue }">{{ scope.row.dueDate || "—" }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="230" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button
            v-if="scope.row.parentId === 0"
            link
            type="primary"
            icon="Plus"
            @click="handleAdd(scope.row)"
            v-hasPermi="['task:item:add']"
          >
            子任务
          </el-button>
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['task:item:edit']">
            修改
          </el-button>
          <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['task:item:remove']">
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <el-dialog :title="title" v-model="open" width="720px" append-to-body>
      <el-form ref="taskRef" :model="form" :rules="rules" label-width="92px">
        <el-row :gutter="18">
          <el-col :span="24">
            <el-form-item label="上级任务" prop="parentId">
              <el-select
                v-model="form.parentId"
                placeholder="请选择"
                style="width: 100%"
                :disabled="Boolean(form.hasChildren)"
              >
                <el-option label="无（主任务）" :value="0" />
                <el-option
                  v-for="item in rootOptions"
                  :key="item.taskId"
                  :label="item.taskName"
                  :value="item.taskId"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="任务名称" prop="taskName">
              <el-input v-model="form.taskName" maxlength="120" show-word-limit placeholder="请输入任务名称" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="任务描述" prop="description">
              <el-input
                v-model="form.description"
                type="textarea"
                :rows="4"
                maxlength="1000"
                show-word-limit
                placeholder="记录目标、验收条件或下一步行动"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="优先级" prop="priority">
              <el-select v-model="form.priority" style="width: 100%">
                <el-option v-for="dict in task_priority" :key="dict.value" :label="dict.label" :value="dict.value" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-select v-model="form.status" style="width: 100%">
                <el-option v-for="dict in task_status" :key="dict.value" :label="dict.label" :value="dict.value" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="任务总量" prop="totalQuantity">
              <el-input-number
                v-model="form.totalQuantity"
                :min="0"
                :disabled="Boolean(form.hasChildren)"
                controls-position="right"
                placeholder="如 100 集"
                style="width: 100%"
                @change="syncProgressFromQuantity"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="已完成" prop="completedQuantity">
              <el-input-number
                v-model="form.completedQuantity"
                :min="0"
                :max="form.totalQuantity || undefined"
                :disabled="Boolean(form.hasChildren) || !hasQuantity(form)"
                controls-position="right"
                placeholder="如 21 集"
                style="width: 100%"
                @change="syncProgressFromQuantity"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="任务进度" prop="progress">
              <el-slider
                v-model="form.progress"
                :min="0"
                :max="100"
                show-input
                :disabled="Boolean(form.hasChildren) || hasQuantity(form)"
              />
              <div v-if="hasQuantity(form)" class="form-hint">进度按已完成数量自动计算</div>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="显示排序" prop="sort">
              <el-input-number v-model="form.sort" :min="0" controls-position="right" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="计划开始" prop="planStartDate">
              <el-date-picker
                v-model="form.planStartDate"
                type="date"
                value-format="YYYY-MM-DD"
                placeholder="选择日期"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="截止日期" prop="dueDate">
              <el-date-picker
                v-model="form.dueDate"
                type="date"
                value-format="YYYY-MM-DD"
                placeholder="选择日期"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" maxlength="500" placeholder="可选" />
            </el-form-item>
          </el-col>
        </el-row>
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

<script setup lang="ts" name="TaskItem">
import {
  addTask,
  delTask,
  getTask,
  getTaskStatistics,
  listRootTaskOptions,
  listTask,
  updateTask,
  updateTaskProgress,
  updateTaskQuantity
} from "@/api/task/item"
import type { TaskItem, TaskItemQueryParams, TaskStatistics } from "@/types"

const { proxy } = getCurrentInstance()
const { task_status, task_priority } = useDict("task_status", "task_priority")

const loading = ref(true)
const open = ref(false)
const showSearch = ref(true)
const refreshTable = ref(true)
const isExpandAll = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const ids = ref<number[]>([])
const dueDateRange = ref<string[]>([])
const taskList = ref<TaskItem[]>([])
const rootOptions = ref<TaskItem[]>([])
const statistics = reactive<TaskStatistics>({
  total: 0,
  inProgress: 0,
  upcoming: 0,
  overdue: 0,
  completed: 0
})

const statCards = computed(() => [
  { key: "total", label: "全部任务", value: statistics.total },
  { key: "progress", label: "进行中", value: statistics.inProgress },
  { key: "upcoming", label: "7天内到期", value: statistics.upcoming },
  { key: "overdue", label: "已逾期", value: statistics.overdue },
  { key: "completed", label: "已完成", value: statistics.completed }
])

const data = reactive({
  form: {} as TaskItem,
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    keyword: undefined,
    status: undefined,
    priority: undefined
  } as TaskItemQueryParams,
  rules: {
    taskName: [{ required: true, message: "任务名称不能为空", trigger: "blur" }],
    priority: [{ required: true, message: "请选择优先级", trigger: "change" }],
    status: [{ required: true, message: "请选择任务状态", trigger: "change" }],
    dueDate: [
      {
        validator: (_rule: unknown, value: string, callback: (error?: Error) => void) => {
          if (!value || !form.value.planStartDate || value >= form.value.planStartDate) {
            callback()
          } else {
            callback(new Error("截止日期不能早于计划开始日期"))
          }
        },
        trigger: "change"
      }
    ]
  }
})

const { queryParams, form, rules } = toRefs(data)

function hasQuantity(row: TaskItem) {
  return Boolean(row.totalQuantity && row.totalQuantity > 0)
}

function syncProgressFromQuantity() {
  if (form.value.hasChildren) return
  if (!hasQuantity(form.value)) {
    form.value.completedQuantity = undefined
    return
  }
  const completed = form.value.completedQuantity || 0
  form.value.completedQuantity = completed
  form.value.progress = Math.round((completed * 100) / form.value.totalQuantity!)
}

function getList() {
  loading.value = true
  const query = proxy.addDateRange({ ...queryParams.value }, dueDateRange.value, "DueDate")
  listTask(query).then(response => {
    taskList.value = response.rows
    total.value = response.total
  }).finally(() => {
    loading.value = false
  })
}

function loadStatistics() {
  getTaskStatistics().then(response => {
    Object.assign(statistics, response.data || {})
  })
}

function refresh() {
  getList()
  loadStatistics()
}

function reset() {
  form.value = {
    taskId: undefined,
    parentId: 0,
    taskName: undefined,
    description: undefined,
    status: "0",
    priority: "1",
    progress: 0,
    totalQuantity: undefined,
    completedQuantity: undefined,
    planStartDate: undefined,
    dueDate: undefined,
    sort: 0,
    remark: undefined,
    hasChildren: false
  }
  proxy.resetForm("taskRef")
}

function loadRootOptions(excludeTaskId?: number) {
  return listRootTaskOptions(excludeTaskId).then(response => {
    rootOptions.value = response.data || []
  })
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  dueDateRange.value = []
  proxy.resetForm("queryRef")
  handleQuery()
}

function handleSelectionChange(selection: TaskItem[]) {
  ids.value = selection.map(item => item.taskId!)
  multiple.value = !selection.length
}

function toggleExpandAll() {
  refreshTable.value = false
  isExpandAll.value = !isExpandAll.value
  nextTick(() => {
    refreshTable.value = true
  })
}

function handleAdd(parent?: TaskItem) {
  reset()
  form.value.parentId = parent?.taskId || 0
  loadRootOptions().then(() => {
    open.value = true
    title.value = parent ? `新增子任务 · ${parent.taskName}` : "新增主任务"
  })
}

function handleUpdate(row: TaskItem) {
  reset()
  Promise.all([getTask(row.taskId!), loadRootOptions(row.taskId)]).then(([response]) => {
    form.value = response.data!
    open.value = true
    title.value = "修改任务"
  })
}

function submitForm() {
  proxy.$refs["taskRef"].validate((valid: boolean) => {
    if (!valid) return
    const request = form.value.taskId ? updateTask(form.value) : addTask(form.value)
    request.then(() => {
      proxy.$modal.msgSuccess(form.value.taskId ? "修改成功" : "新增成功")
      open.value = false
      refresh()
    })
  })
}

function handleProgressChange(row: TaskItem) {
  updateTaskProgress(row.taskId!, row.progress || 0).then(() => {
    proxy.$modal.msgSuccess("进度已更新")
    refresh()
  }).catch(() => {
    getList()
  })
}

function handleQuantityChange(row: TaskItem) {
  updateTaskQuantity(row.taskId!, row.completedQuantity || 0).then(() => {
    proxy.$modal.msgSuccess("数量已更新")
    refresh()
  }).catch(() => {
    getList()
  })
}

function handleDelete(row?: TaskItem) {
  const taskIds = row?.taskId || ids.value
  proxy.$modal.confirm(`是否确认删除任务编号为“${taskIds}”的数据？删除主任务会同时删除其子任务。`).then(() => {
    return delTask(taskIds)
  }).then(() => {
    proxy.$modal.msgSuccess("删除成功")
    refresh()
  }).catch(() => {})
}

function cancel() {
  open.value = false
  reset()
}

refresh()
</script>

<style scoped>
.task-page {
  --task-border: #e7eaf0;
}

.stat-row {
  margin-bottom: 18px;
}

.stat-card {
  position: relative;
  min-height: 92px;
  padding: 17px 18px;
  overflow: hidden;
  border: 1px solid var(--task-border);
  border-radius: 10px;
  background: var(--el-bg-color);
}

.stat-card::after {
  content: "";
  position: absolute;
  right: -18px;
  bottom: -30px;
  width: 72px;
  height: 72px;
  border: 13px solid color-mix(in srgb, var(--el-color-primary) 9%, transparent);
  border-radius: 50%;
}

.stat-card span {
  display: block;
  color: var(--el-text-color-secondary);
  font-size: 13px;
}

.stat-card strong {
  display: block;
  margin-top: 5px;
  color: var(--el-text-color-primary);
  font-size: 28px;
  line-height: 1;
}

.stat-card.is-overdue strong {
  color: var(--el-color-danger);
}

.stat-card.is-completed strong {
  color: var(--el-color-success);
}

.task-name {
  display: flex;
  align-items: center;
  gap: 7px;
  font-weight: 600;
}

.task-description {
  margin-top: 3px;
  overflow: hidden;
  color: var(--el-text-color-secondary);
  font-size: 12px;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.progress-cell {
  display: flex;
  align-items: center;
  gap: 9px;
}

.progress-input,
.quantity-input {
  width: 82px;
}

.quantity-cell {
  display: flex;
  align-items: center;
  gap: 4px;
  color: var(--el-text-color-regular);
  white-space: nowrap;
}

.form-hint {
  margin-top: 4px;
  color: var(--el-text-color-secondary);
  font-size: 12px;
  line-height: 1.4;
}

.due-overdue {
  color: var(--el-color-danger);
  font-weight: 600;
}

@media (max-width: 768px) {
  .stat-card {
    margin-bottom: 10px;
  }
}
</style>
