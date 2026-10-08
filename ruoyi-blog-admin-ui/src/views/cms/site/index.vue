<template>
  <div class="app-container">
    <el-form ref="siteRef" :model="form" :rules="rules" label-width="128px">
      <el-card shadow="never" class="mb8">
        <template #header>
          <span>基础信息</span>
          <span class="card-sub">影响前台顶栏 Logo、首页标题、页脚；左侧头像区用默认作者和个性签名</span>
        </template>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item prop="siteName">
              <template #label>
                <HintLabel text="站点名称" hint="首页大标题和浏览器标签标题。页脚文案为空时也会回退显示这里。不用于左侧头像下方。" />
              </template>
              <el-input v-model="form.siteName" maxlength="50" show-word-limit />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item prop="author">
              <template #label>
                <HintLabel text="默认作者" hint="前台左侧栏头像下方的名字。文章没有单独填写作者时，列表和详情页也会显示这个名字。" />
              </template>
              <el-input v-model="form.author" maxlength="64" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item prop="authorSignature">
              <template #label>
                <HintLabel text="个性签名" hint="前台左侧栏作者名下方的一句话，只描述作者本人，和站点「一句话简介」互不影响。" />
              </template>
              <el-input v-model="form.authorSignature" maxlength="200" show-word-limit placeholder="作者的个性签名" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item prop="logoPrefix">
              <template #label>
                <HintLabel text="Logo 前缀" hint="前台顶部导航最左侧 Logo 的前半段普通文字，例如 SUPER。" />
              </template>
              <el-input v-model="form.logoPrefix" maxlength="40" placeholder="SUPER" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item prop="logoHighlight">
              <template #label>
                <HintLabel text="Logo 高亮" hint="顶部 Logo 的后半段加粗高亮，例如 YAN，和前缀拼成完整站标。" />
              </template>
              <el-input v-model="form.logoHighlight" maxlength="40" placeholder="YAN" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item prop="tagline">
              <template #label>
                <HintLabel text="一句话简介" hint="显示在首页大标题下方，以及关于我页面标题下方。不用于左侧头像区。" />
              </template>
              <el-input v-model="form.tagline" maxlength="200" show-word-limit />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item prop="avatarUrl">
              <template #label>
                <HintLabel text="头像" hint="前台左侧栏顶部的圆形头像，属于作者资料。不上传时改用「头像字母」。" />
              </template>
              <image-upload v-model="form.avatarUrl" :limit="1" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item prop="avatarLetter">
              <template #label>
                <HintLabel text="头像字母" hint="未上传头像时，左侧栏圆形区域内显示的字母，一般用作者名缩写。" />
              </template>
              <el-input v-model="form.avatarLetter" maxlength="8" placeholder="无图时显示" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item prop="footerText">
              <template #label>
                <HintLabel text="页脚文案" hint="页面最底部那一行版权 / 站名。留空则显示站点名称。" />
              </template>
              <el-input v-model="form.footerText" maxlength="200" placeholder="版权 / 站名" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item prop="siteUrl">
              <template #label>
                <HintLabel text="站点 URL" hint="网站对外访问地址。当前前台页面不会直接显示，预留给后续 SEO / 分享。" />
              </template>
              <el-input v-model="form.siteUrl" maxlength="255" placeholder="https://example.com" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item prop="beianText">
              <template #label>
                <HintLabel text="备案文案" hint="页脚版权右侧的备案号。填了才会显示。" />
              </template>
              <el-input v-model="form.beianText" maxlength="100" placeholder="京ICP备xxxxxxxx号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item prop="beianUrl">
              <template #label>
                <HintLabel text="备案链接" hint="点击页脚备案号时打开的地址，一般填工信部备案查询站点。" />
              </template>
              <el-input v-model="form.beianUrl" maxlength="255" placeholder="https://beian.miit.gov.cn/" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-card>

      <el-card shadow="never" class="mb8">
        <template #header>
          <span>前台主题</span>
          <span class="card-sub">选一套作为全站外观，下方缩略图对应前台顶栏 + 侧栏布局</span>
        </template>
        <el-form-item prop="themeId" label-width="0">
          <ThemePicker v-model="form.themeId" />
        </el-form-item>
      </el-card>

      <el-card shadow="never" class="mb8">
        <template #header>
          <span>关于我</span>
          <span class="card-sub">影响左侧「关于我」菜单和关于我页面</span>
        </template>
        <el-form-item prop="aboutEnabled">
          <template #label>
            <HintLabel text="显示菜单" hint="关闭后，前台左侧导航不再出现「关于我」。" />
          </template>
          <el-switch v-model="form.aboutEnabled" active-value="0" inactive-value="1" />
        </el-form-item>
        <el-form-item prop="aboutTitle">
          <template #label>
            <HintLabel text="页面标题" hint="关于我页面顶部的主标题。留空则显示站点名称。" />
          </template>
          <el-input v-model="form.aboutTitle" maxlength="50" />
        </el-form-item>
        <el-form-item prop="aboutContent">
          <template #label>
            <HintLabel text="正文" hint="关于我页面的正文，支持 Markdown。建议用简历结构：技能、经历、项目、教育、联系。带【】的是占位，换成你的真实信息后保存。" />
          </template>
          <div style="width:100%">
            <el-button type="primary" plain size="small" @click="fillResumeTemplate">填入简历模板</el-button>
            <markdown-editor
              v-model="form.aboutContent"
              class="mt8"
              :min-height="320"
              placeholder="关于我页面的 Markdown 正文"
            />
          </div>
        </el-form-item>
      </el-card>

      <el-card shadow="never" class="mb8">
        <template #header>
          <span>导航与模块</span>
          <span class="card-sub">影响顶栏搜索、左侧导航、右侧热门和首页分页</span>
        </template>
        <el-form-item prop="searchEnabled">
          <template #label>
            <HintLabel text="搜索" hint="控制前台顶部导航栏右侧的搜索框是否显示。" />
          </template>
          <el-switch v-model="form.searchEnabled" active-value="0" inactive-value="1" />
        </el-form-item>
        <el-form-item prop="categoryEnabled">
          <template #label>
            <HintLabel text="分类菜单" hint="控制左侧导航里的「分类」折叠菜单。子级来自分类管理，用来筛选文章。" />
          </template>
          <el-switch v-model="form.categoryEnabled" active-value="0" inactive-value="1" />
        </el-form-item>
        <el-form-item prop="friendLinkEnabled">
          <template #label>
            <HintLabel text="友链菜单" hint="控制左侧导航里的「友链」折叠菜单。子级来自友链管理，不是这里的第三方链接。" />
          </template>
          <el-switch v-model="form.friendLinkEnabled" active-value="0" inactive-value="1" />
        </el-form-item>
        <el-form-item prop="labEnabled">
          <template #label>
            <HintLabel text="实验室菜单" hint="控制前台左侧导航里的「实验室」入口。页面展示实验室管理中已启用的项目卡片。" />
          </template>
          <el-switch v-model="form.labEnabled" active-value="0" inactive-value="1" />
        </el-form-item>
        <el-form-item>
          <template #label>
            <HintLabel text="第三方链接" hint="显示在左侧「关于我」和「分类」之间的固定外链，适合自己的 GitHub、仓库等。启用且填写名称和网址后才会出现。" />
          </template>
          <div style="width:100%">
            <el-button type="primary" plain icon="Plus" size="small" @click="addNavLink">新增</el-button>
            <el-table :data="form.extraNavLinks" border size="small" class="mt8" empty-text="暂无">
              <el-table-column label="名称" min-width="120">
                <template #default="scope">
                  <el-input v-model="scope.row.name" maxlength="20" placeholder="GitHub" />
                </template>
              </el-table-column>
              <el-table-column label="链接" min-width="220">
                <template #default="scope">
                  <el-input v-model="scope.row.url" maxlength="255" placeholder="https://" />
                </template>
              </el-table-column>
              <el-table-column width="100" align="center">
                <template #header>
                  <HintLabel text="新窗口" hint="开启后，前台点击该链接会在新标签页打开。" />
                </template>
                <template #default="scope">
                  <el-switch v-model="scope.row.openInNew" active-value="0" inactive-value="1" />
                </template>
              </el-table-column>
              <el-table-column width="90" align="center">
                <template #header>
                  <HintLabel text="显示" hint="关闭后这条链接不会出现在前台左侧导航。" />
                </template>
                <template #default="scope">
                  <el-switch v-model="scope.row.enabled" active-value="0" inactive-value="1" />
                </template>
              </el-table-column>
              <el-table-column width="120" align="center">
                <template #header>
                  <HintLabel text="排序" hint="数字越小越靠前。多条第三方链接按此顺序排列。" />
                </template>
                <template #default="scope">
                  <el-input-number v-model="scope.row.sort" :min="0" :max="99" controls-position="right" style="width: 90px" />
                </template>
              </el-table-column>
              <el-table-column label="操作" width="80" align="center">
                <template #default="scope">
                  <el-button link type="danger" @click="removeNavLink(scope.$index)">删除</el-button>
                </template>
              </el-table-column>
            </el-table>
          </div>
        </el-form-item>
        <el-form-item prop="hotLimit">
          <template #label>
            <HintLabel text="热门条数" hint="右侧栏「热门」列表最多显示几篇文章。" />
          </template>
          <el-input-number v-model="form.hotLimit" :min="1" :max="50" controls-position="right" />
        </el-form-item>
        <el-form-item prop="homePageSize">
          <template #label>
            <HintLabel text="首页每页" hint="首页文章列表每一页展示多少篇。" />
          </template>
          <el-input-number v-model="form.homePageSize" :min="1" :max="50" controls-position="right" />
        </el-form-item>
      </el-card>
    </el-form>
    <div class="footer-btns">
      <el-button type="primary" :loading="saving" v-hasPermi="['cms:site:edit']" @click="submitForm">保 存</el-button>
    </div>
  </div>
</template>

<script setup lang="ts" name="CmsSite">
import { getSiteSetting, updateSiteSetting } from "@/api/cms/site"
import type { CmsSiteSetting } from "@/types"
import HintLabel from "./HintLabel.vue"
import ThemePicker from "./ThemePicker.vue"
import resumeTemplate from "./resume.md?raw"

const { proxy } = getCurrentInstance()
const saving = ref(false)

const data = reactive({
  form: {} as CmsSiteSetting,
  rules: {
    siteName: [{ required: true, message: "站点名称不能为空", trigger: "blur" }]
  }
})

const { form, rules } = toRefs(data)

function fillResumeTemplate() {
  const apply = () => {
    form.value.aboutContent = resumeTemplate
    if (!form.value.aboutTitle) {
      form.value.aboutTitle = "\u5173\u4e8e\u6211"
    }
  }
  if ((form.value.aboutContent || "").trim()) {
    proxy.$modal.confirm("\u5c06\u8986\u76d6\u5f53\u524d\u300c\u5173\u4e8e\u6211\u300d\u6b63\u6587\uff0c\u662f\u5426\u7ee7\u7eed\uff1f").then(apply).catch(() => {})
    return
  }
  apply()
}

function load() {
  getSiteSetting().then(res => {
    form.value = { extraNavLinks: [], themeId: "paper", ...(res.data || {}) }
    if (!form.value.themeId) {
      form.value.themeId = "paper"
    }
    if (!form.value.extraNavLinks) {
      form.value.extraNavLinks = []
    }
  })
}

function addNavLink() {
  if (!form.value.extraNavLinks) {
    form.value.extraNavLinks = []
  }
  form.value.extraNavLinks.push({ name: "", url: "", openInNew: "0", enabled: "0", sort: form.value.extraNavLinks.length + 1 })
}

function removeNavLink(index: number) {
  form.value.extraNavLinks?.splice(index, 1)
}

function submitForm() {
  proxy.$refs["siteRef"].validate((valid: boolean) => {
    if (!valid) {
      return
    }
    saving.value = true
    updateSiteSetting(form.value).then(() => {
      proxy.$modal.msgSuccess("保存成功")
    }).finally(() => {
      saving.value = false
    })
  })
}

load()
</script>

<style scoped>
.mb8 {
  margin-bottom: 16px;
}
.mt8 {
  margin-top: 8px;
}
.card-sub {
  margin-left: 10px;
  font-size: 12px;
  font-weight: normal;
  color: #909399;
}
.footer-btns {
  position: sticky;
  bottom: 0;
  padding: 12px 0;
  background: var(--el-bg-color);
}
</style>
