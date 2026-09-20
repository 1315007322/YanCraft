<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="标题" prop="title">
        <el-input v-model="queryParams.title" placeholder="请输入标题" clearable style="width: 200px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="分类" prop="categoryId">
        <el-select v-model="queryParams.categoryId" placeholder="全部分类" clearable style="width: 180px">
          <el-option v-for="item in categoryOptions" :key="item.categoryId" :label="item.name" :value="item.categoryId" />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="文章状态" clearable style="width: 160px">
          <el-option v-for="dict in cms_article_status" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['cms:article:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate()" v-hasPermi="['cms:article:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete()" v-hasPermi="['cms:article:remove']">删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="articleList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="标题" align="left" prop="title" min-width="180" :show-overflow-tooltip="true" />
      <el-table-column label="分类" align="center" prop="categoryName" width="110" />
      <el-table-column label="状态" align="center" prop="status" width="90">
        <template #default="scope">
          <dict-tag :options="cms_article_status" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="置顶" align="center" prop="isTop" width="70">
        <template #default="scope">
          <span>{{ scope.row.isTop === '1' ? '是' : '否' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="字数" align="center" prop="wordCount" width="80" />
      <el-table-column label="阅读" align="center" width="90">
        <template #default="scope">
          <span>{{ scope.row.readingTime || 0 }} 分钟</span>
        </template>
      </el-table-column>
      <el-table-column label="浏览" align="center" prop="viewCount" width="70" />
      <el-table-column label="发布时间" align="center" prop="publishTime" width="160">
        <template #default="scope">
          <span>{{ parseTime(scope.row.publishTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="220" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['cms:article:edit']">修改</el-button>
          <el-button v-if="scope.row.status !== '1'" link type="primary" icon="Promotion" @click="handlePublish(scope.row)" v-hasPermi="['cms:article:publish']">发布</el-button>
          <el-button v-if="scope.row.status === '1'" link type="warning" icon="Download" @click="handleOffline(scope.row)" v-hasPermi="['cms:article:offline']">下线</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['cms:article:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
  </div>
</template>

<script setup lang="ts" name="CmsArticle">
import { listArticle, delArticle, publishArticle, offlineArticle } from "@/api/cms/article"
import { listCategory } from "@/api/cms/category"
import type { CmsArticle, ArticleQueryParams, CmsCategory } from "@/types"

const { proxy } = getCurrentInstance()
const { cms_article_status } = useDict("cms_article_status")

const articleList = ref<CmsArticle[]>([])
const categoryOptions = ref<CmsCategory[]>([])
const loading = ref(true)
const showSearch = ref(true)
const ids = ref<number[]>([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    title: undefined,
    status: undefined,
    categoryId: undefined
  } as ArticleQueryParams
})

const { queryParams } = toRefs(data)

function getList() {
  loading.value = true
  listArticle(queryParams.value).then(response => {
    articleList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

function handleSelectionChange(selection: CmsArticle[]) {
  ids.value = selection.map(item => item.articleId!)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

function handleAdd() {
  proxy.$tab.openPage("新增文章", "/cms/article-edit/index")
}

function handleUpdate(row?: CmsArticle) {
  const articleId = row?.articleId || ids.value[0]
  proxy.$tab.openPage("修改文章", "/cms/article-edit/index/" + articleId)
}

function handleDelete(row?: CmsArticle) {
  const articleIds = row?.articleId || ids.value
  proxy.$modal.confirm('是否确认删除文章编号为"' + articleIds + '"的数据项？').then(function () {
    return delArticle(articleIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

function handlePublish(row: CmsArticle) {
  proxy.$modal.confirm('是否确认发布《' + row.title + '》？').then(function () {
    return publishArticle(row.articleId!)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("发布成功")
  }).catch(() => {})
}

function handleOffline(row: CmsArticle) {
  proxy.$modal.confirm('是否确认下线《' + row.title + '》？').then(function () {
    return offlineArticle(row.articleId!)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("已下线")
  }).catch(() => {})
}

listCategory({ pageNum: 1, pageSize: 500 }).then(res => {
  categoryOptions.value = res.rows || []
})
getList()
onActivated(() => {
  getList()
})
</script>
