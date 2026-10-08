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
          <el-form-item label="封面">
            <div class="cover-pair">
              <div class="cover-slot">
                <div class="cover-slot-label">列表封面 · 1:1</div>
                <image-upload v-model="form.cover" :limit="1" />
              </div>
              <div class="cover-slot">
                <div class="cover-slot-label">详情头图 · 宽图</div>
                <image-upload v-model="form.coverWide" :limit="1" />
              </div>
              <el-tooltip content="用 AI 生成封面" placement="top">
                <span class="cover-ai-btn">
                  <el-button circle native-type="button" :loading="aiLoading" @click="openCoverAi">
                    <el-icon><MagicStick /></el-icon>
                  </el-button>
                </span>
              </el-tooltip>
            </div>
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="摘要" prop="summary">
            <div class="summary-ai">
              <el-input v-model="form.summary" type="textarea" :rows="3" maxlength="500" show-word-limit placeholder="列表摘要，可空，也可让 AI 根据正文总结" />
              <el-tooltip content="用 AI 总结摘要" placement="top">
                <el-button circle native-type="button" :loading="summaryAiLoading" @click="openSummaryAi">
                  <el-icon><MagicStick /></el-icon>
                </el-button>
              </el-tooltip>
            </div>
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item label="正文" prop="content">
            <markdown-editor
              v-model="form.content"
              placeholder="请输入 Markdown 正文，字数和阅读时长保存时自动计算"
            />
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
    <el-dialog v-model="coverAiVisible" title="AI 生成封面" width="560px" append-to-body>
      <el-form label-width="90px">
        <el-form-item label="出图 AI">
          <el-select v-model="aiConfigId" placeholder="选择出图 AI" style="width: 100%" clearable>
            <el-option v-for="item in imageAiOptions" :key="item.configId" :label="item.configName" :value="item.configId" />
          </el-select>
        </el-form-item>
      </el-form>
      <p class="cover-ai-tip">固定提示词：根据文章摘要生成卡通像素风格封面，并附上正文（过长会截断）。列表用正方形，详情用横向宽图，可分别生成。</p>
      <p v-if="!imageAiOptions.length" class="cover-ai-tip">请先在「系统管理 / AI 配置」新增用途为出图的配置</p>
      <template #footer>
        <el-button @click="coverAiVisible = false">关 闭</el-button>
        <el-button type="primary" :loading="aiLoading" :disabled="!imageAiOptions.length" @click="generateCover('cover')">生成列表封面</el-button>
        <el-button type="primary" :loading="aiLoading" :disabled="!imageAiOptions.length" @click="generateCover('coverWide')">生成详情头图</el-button>
      </template>
    </el-dialog>
    <el-dialog v-model="summaryAiVisible" title="AI 总结摘要" width="420px" append-to-body>
      <el-form label-width="90px">
        <el-form-item label="对话 AI">
          <el-select v-model="chatConfigId" placeholder="选择对话 AI" style="width: 100%" clearable>
            <el-option v-for="item in chatAiOptions" :key="item.configId" :label="item.configName" :value="item.configId" />
          </el-select>
        </el-form-item>
      </el-form>
      <p class="cover-ai-tip">让 AI 根据正文总结列表摘要，约 120 字，可再编辑。</p>
      <p v-if="!chatAiOptions.length" class="cover-ai-tip">请先在「系统管理 / AI 配置」新增用途为对话的配置</p>
      <template #footer>
        <el-button @click="summaryAiVisible = false">取 消</el-button>
        <el-button type="primary" :loading="summaryAiLoading" :disabled="!chatAiOptions.length" @click="generateSummary">总结摘要</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts" name="CmsArticleForm">
import { getArticle, addArticle, updateArticle } from "@/api/cms/article"
import { listCategory } from "@/api/cms/category"
import { listTag } from "@/api/cms/tag"
import { listAiOptions, generateAiImage, generateAiChat } from "@/api/system/ai"
import { MagicStick } from "@element-plus/icons-vue"
import type { CmsArticle, CmsCategory, CmsTag, SysAiConfig } from "@/types"

const route = useRoute()
const { proxy } = getCurrentInstance()
const { cms_article_status } = useDict("cms_article_status")

const categoryOptions = ref<CmsCategory[]>([])
const tagOptions = ref<CmsTag[]>([])
const imageAiOptions = ref<SysAiConfig[]>([])
const chatAiOptions = ref<SysAiConfig[]>([])
const aiConfigId = ref<number | undefined>()
const chatConfigId = ref<number | undefined>()
const aiLoading = ref(false)
const summaryAiLoading = ref(false)
const coverAiVisible = ref(false)
const summaryAiVisible = ref(false)
const COVER_CONTENT_MAX = 1200
const COVER_SIZE = {
  cover: "1024x1024",
  coverWide: "1792x1024"
} as const
type CoverKind = keyof typeof COVER_SIZE

function openCoverAi() {
  coverAiVisible.value = true
}

function openSummaryAi() {
  summaryAiVisible.value = true
}

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
    coverWide: undefined,
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
  listAiOptions("image").then(res => {
    imageAiOptions.value = res.data || []
    const def = imageAiOptions.value.find(item => item.isDefault === "Y") || imageAiOptions.value[0]
    aiConfigId.value = def?.configId
  }).catch(() => {
    imageAiOptions.value = []
  })
  listAiOptions("chat").then(res => {
    chatAiOptions.value = res.data || []
    const def = chatAiOptions.value.find(item => item.isDefault === "Y") || chatAiOptions.value[0]
    chatConfigId.value = def?.configId
  }).catch(() => {
    chatAiOptions.value = []
  })
}

function stripMarkdown(raw: string) {
  return raw
    .replace(/```[\s\S]*?```/g, " ")
    .replace(/`[^`]*`/g, " ")
    .replace(/!\[[^\]]*\]\([^)]*\)/g, " ")
    .replace(/\[([^\]]*)\]\([^)]*\)/g, "$1")
    .replace(/^#{1,6}\s+/gm, "")
    .replace(/[*_~>|-]+/g, " ")
    .replace(/\s+/g, " ")
    .trim()
}

function clipText(text: string, max: number) {
  if (text.length <= max) {
    return text
  }
  return text.slice(0, max) + "…"
}

function resolveCoverPrompt(kind: CoverKind) {
  const summary = (form.value.summary || "").trim()
  const title = (form.value.title || "").trim()
  const content = clipText(stripMarkdown(form.value.content || ""), COVER_CONTENT_MAX)
  const abstractText = summary || title
  if (!abstractText && !content) {
    return ""
  }
  const shape = kind === "coverWide"
    ? "构图：横向宽图，适合文章详情顶部横幅。"
    : "构图：正方形 1:1，适合首页列表封面。"
  const lines = ["根据文章摘要生成封面图片，卡通像素风格。", shape]
  if (abstractText) {
    lines.push("摘要：" + abstractText)
  }
  lines.push("文章内容如下：")
  lines.push(content || abstractText)
  return lines.join("\n")
}

function generateCover(kind: CoverKind) {
  const prompt = resolveCoverPrompt(kind)
  if (!prompt) {
    proxy.$modal.msgError("请先填写摘要或正文")
    return
  }
  if (!imageAiOptions.value.length) {
    proxy.$modal.msgError("请先在系统管理新增出图 AI 配置")
    return
  }
  const run = () => {
    aiLoading.value = true
    generateAiImage({ configId: aiConfigId.value, prompt, size: COVER_SIZE[kind] }).then(res => {
      const url = res.url || (typeof res.data === "string" ? res.data : "")
      if (!url) {
        proxy.$modal.msgError("未拿到图片地址")
        return
      }
      form.value[kind] = url
      proxy.$modal.msgSuccess(kind === "coverWide" ? "详情头图已生成" : "列表封面已生成")
    }).finally(() => {
      aiLoading.value = false
    })
  }
  if (form.value[kind]) {
    proxy.$modal.confirm("将替换当前图片，是否继续？").then(run).catch(() => {})
    return
  }
  run()
}

function resolveSummaryPrompt() {
  const title = (form.value.title || "").trim()
  const content = clipText(stripMarkdown(form.value.content || ""), 6000)
  if (!content) {
    return ""
  }
  const lines = [
    "请根据下面文章总结一段适合博客列表展示的摘要。",
    "要求：用自己的话概括中心内容，不要照抄开头几句；中文，120字以内，不要标题、不要引号、不要「摘要：」前缀，只输出摘要本身。"
  ]
  if (title) {
    lines.push("标题：" + title)
  }
  lines.push("正文：")
  lines.push(content)
  return lines.join("\n")
}

function cleanSummary(raw: string) {
  let text = (raw || "").trim()
  text = text.replace(/^摘要[:：]\s*/, "")
  text = text.replace(/^["「『“]+/, "").replace(/["」』”]+$/, "")
  if (text.length > 500) {
    text = text.slice(0, 500)
  }
  return text
}

function generateSummary() {
  const prompt = resolveSummaryPrompt()
  if (!prompt) {
    proxy.$modal.msgError("请先填写正文")
    return
  }
  if (!chatAiOptions.value.length) {
    proxy.$modal.msgError("请先在系统管理新增对话 AI 配置")
    return
  }
  const run = () => {
    summaryAiLoading.value = true
    generateAiChat({ configId: chatConfigId.value, prompt }).then(res => {
      const raw = typeof res.data === "string" && res.data.trim()
        ? res.data
        : (typeof res.msg === "string" ? res.msg : "")
      const text = cleanSummary(raw)
      if (!text) {
        proxy.$modal.msgError("未拿到摘要")
        return
      }
      form.value.summary = text
      summaryAiVisible.value = false
      proxy.$modal.msgSuccess("摘要已生成")
    }).finally(() => {
      summaryAiLoading.value = false
    })
  }
  if ((form.value.summary || "").trim()) {
    proxy.$modal.confirm("将替换当前摘要，是否继续？").then(run).catch(() => {})
    return
  }
  run()
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
.cover-pair {
  display: flex;
  align-items: flex-start;
  gap: 16px;
  flex-wrap: wrap;
}
.cover-slot-label {
  margin-bottom: 6px;
  color: #909399;
  font-size: 12px;
  line-height: 1.4;
}
.cover-ai-btn {
  display: inline-flex;
  margin-top: 28px;
}
.summary-ai {
  display: flex;
  align-items: flex-start;
  gap: 10px;
  width: 100%;
}
.cover-ai-tip {
  margin: 8px 0 0;
  color: #909399;
  font-size: 12px;
  line-height: 1.5;
}
</style>
