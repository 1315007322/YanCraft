<template>
  <div class="app-container">
    <el-form ref="articleRef" :model="form" :rules="rules" label-width="100px">
      <el-row>
        <el-col :span="16">
          <el-form-item label="标题" prop="title">
            <el-input v-model="form.title" placeholder="请输入标题" maxlength="200" show-word-limit />
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="访问标识" prop="slug">
            <el-input v-model="form.slug" placeholder="可空，英文短链" />
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="分类" prop="categoryId">
            <el-select v-model="form.categoryId" placeholder="请选择分类" clearable style="width: 100%">
              <el-option v-for="item in categoryOptions" :key="item.categoryId" :label="item.name" :value="item.categoryId" />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="标签" prop="tagIds">
            <el-select v-model="form.tagIds" multiple filterable placeholder="请选择标签" clearable style="width: 100%">
              <el-option v-for="item in tagOptions" :key="item.tagId" :label="item.name" :value="item.tagId" />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="作者" prop="author">
            <el-input v-model="form.author" placeholder="可空，默认当前登录用户" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="状态" prop="status">
            <el-radio-group v-model="form.status">
              <el-radio v-for="dict in cms_article_status" :key="dict.value" :value="dict.value">{{ dict.label }}</el-radio>
            </el-radio-group>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="置顶" prop="isTop">
            <el-radio-group v-model="form.isTop">
              <el-radio value="0">否</el-radio>
              <el-radio value="1">是</el-radio>
            </el-radio-group>
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="封面" prop="cover">
            <image-upload v-model="form.cover" :limit="1" />
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="摘要" prop="summary">
            <el-input v-model="form.summary" type="textarea" :rows="3" maxlength="500" show-word-limit placeholder="列表摘要，可空" />
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="正文" prop="content">
            <el-input v-model="form.content" type="textarea" :rows="22" placeholder="请输入 Markdown 正文，字数和阅读时长保存时自动计算" />
          </el-form-item>
        </el-col>
        <el-col :span="12" v-if="form.articleId">
          <el-form-item label="字数">
            <span>{{ form.wordCount || 0 }}</span>
          </el-form-item>
        </el-col>
        <el-col :span="12" v-if="form.articleId">
          <el-form-item label="阅读时长">
            <span>{{ form.readingTime || 0 }} 分钟</span>
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
    <div class="footer-btns">
      <el-button type="primary" @click="submitForm">确 定</el-button>
      <el-button @click="goBack">取 消</el-button>
    </div>
  </div>
</template>

<script setup lang="ts" name="CmsArticleForm">
import { getArticle, addArticle, updateArticle } from "@/api/cms/article"
import { listCategory } from "@/api/cms/category"
import { listTag } from "@/api/cms/tag"
import type { CmsArticle, CmsCategory, CmsTag } from "@/types"

const route = useRoute()
const { proxy } = getCurrentInstance()
const { cms_article_status } = useDict("cms_article_status")

const categoryOptions = ref<CmsCategory[]>([])
const tagOptions = ref<CmsTag[]>([])

const data = reactive({
  form: {} as CmsArticle,
  rules: {
    title: [{ required: true, message: "标题不能为空", trigger: "blur" }]
  }
})

const { form, rules } = toRefs(data)

function reset() {
  form.value = {
    articleId: undefined,
    title: undefined,
    slug: undefined,
    summary: undefined,
    cover: undefined,
    content: undefined,
    categoryId: undefined,
    author: undefined,
    status: "0",
    isTop: "0",
    tagIds: []
  }
  proxy.resetForm("articleRef")
}

function loadOptions() {
  listCategory({ pageNum: 1, pageSize: 500 }).then(res => {
    categoryOptions.value = res.rows || []
  })
  listTag({ pageNum: 1, pageSize: 500 }).then(res => {
    tagOptions.value = res.rows || []
  })
}

function loadForm() {
  reset()
  const articleId = route.params.articleId
  if (articleId) {
    getArticle(Number(articleId)).then(response => {
      form.value = response.data!
      if (!form.value.tagIds) {
        form.value.tagIds = []
      }
    })
  }
}

function submitForm() {
  proxy.$refs["articleRef"].validate((valid: boolean) => {
    if (valid) {
      if (form.value.articleId != undefined) {
        updateArticle(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          goBack()
        })
      } else {
        addArticle(form.value).then(() => {
          proxy.$modal.msgSuccess("新增成功")
          goBack()
        })
      }
    }
  })
}

function goBack() {
  proxy.$tab.closeOpenPage({ path: "/cms/article" })
}

loadOptions()
loadForm()
watch(() => route.params.articleId, () => {
  loadForm()
})
</script>

<style scoped>
.footer-btns {
  padding: 12px 0 24px 100px;
}
</style>
