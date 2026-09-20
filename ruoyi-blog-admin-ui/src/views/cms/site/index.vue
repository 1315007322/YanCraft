<template>
  <div class="app-container">
    <el-form ref="siteRef" :model="form" :rules="rules" label-width="120px">
      <el-card shadow="never" class="mb8">
        <template #header><span>基础信息</span></template>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="站点名称" prop="siteName">
              <el-input v-model="form.siteName" maxlength="50" show-word-limit />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="默认作者" prop="author">
              <el-input v-model="form.author" maxlength="64" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="Logo 前缀" prop="logoPrefix">
              <el-input v-model="form.logoPrefix" maxlength="40" placeholder="SUPER" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="Logo 高亮" prop="logoHighlight">
              <el-input v-model="form.logoHighlight" maxlength="40" placeholder="YAN" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="一句话简介" prop="tagline">
              <el-input v-model="form.tagline" maxlength="200" show-word-limit />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="头像" prop="avatarUrl">
              <image-upload v-model="form.avatarUrl" :limit="1" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="头像字母" prop="avatarLetter">
              <el-input v-model="form.avatarLetter" maxlength="8" placeholder="无图时显示" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="页脚文案" prop="footerText">
              <el-input v-model="form.footerText" maxlength="200" placeholder="版权 / 站名" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="站点 URL" prop="siteUrl">
              <el-input v-model="form.siteUrl" maxlength="255" placeholder="https://example.com" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="备案文案" prop="beianText">
              <el-input v-model="form.beianText" maxlength="100" placeholder="京ICP备xxxxxxxx号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="备案链接" prop="beianUrl">
              <el-input v-model="form.beianUrl" maxlength="255" placeholder="https://beian.miit.gov.cn/" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-card>

      <el-card shadow="never" class="mb8">
        <template #header><span>关于我</span></template>
        <el-form-item label="显示菜单" prop="aboutEnabled">
          <el-switch v-model="form.aboutEnabled" active-value="0" inactive-value="1" />
        </el-form-item>
        <el-form-item label="页面标题" prop="aboutTitle">
          <el-input v-model="form.aboutTitle" maxlength="50" />
        </el-form-item>
        <el-form-item label="正文" prop="aboutContent">
          <el-input v-model="form.aboutContent" type="textarea" :rows="10" placeholder="Markdown" />
        </el-form-item>
      </el-card>

      <el-card shadow="never" class="mb8">
        <template #header><span>导航与模块</span></template>
        <el-form-item label="搜索" prop="searchEnabled">
          <el-switch v-model="form.searchEnabled" active-value="0" inactive-value="1" />
        </el-form-item>
        <el-form-item label="分类菜单" prop="categoryEnabled">
          <el-switch v-model="form.categoryEnabled" active-value="0" inactive-value="1" />
        </el-form-item>
        <el-form-item label="友链菜单" prop="friendLinkEnabled">
          <el-switch v-model="form.friendLinkEnabled" active-value="0" inactive-value="1" />
        </el-form-item>
                <el-form-item label="第三方链接">
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
              <el-table-column label="新窗口" width="90" align="center">
                <template #default="scope">
                  <el-switch v-model="scope.row.openInNew" active-value="0" inactive-value="1" />
                </template>
              </el-table-column>
              <el-table-column label="显示" width="80" align="center">
                <template #default="scope">
                  <el-switch v-model="scope.row.enabled" active-value="0" inactive-value="1" />
                </template>
              </el-table-column>
              <el-table-column label="排序" width="110" align="center">
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
<el-form-item label="热门条数" prop="hotLimit">
          <el-input-number v-model="form.hotLimit" :min="1" :max="50" controls-position="right" />
        </el-form-item>
        <el-form-item label="首页每页" prop="homePageSize">
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

const { proxy } = getCurrentInstance()
const saving = ref(false)

const data = reactive({
  form: {} as CmsSiteSetting,
  rules: {
    siteName: [{ required: true, message: "站点名称不能为空", trigger: "blur" }]
  }
})

const { form, rules } = toRefs(data)

function load() {
  getSiteSetting().then(res => {
    form.value = { extraNavLinks: [], ...(res.data || {}) }
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
.footer-btns {
  position: sticky;
  bottom: 0;
  padding: 12px 0;
  background: var(--el-bg-color);
}
</style>
