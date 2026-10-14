# 功能 Changelog

版本号只描述博客业务，与若依框架版本无关。

## 1.12.0 - 2026-10-14

新增考公言语积累：后台录卡，前台每天自动排卡组，支持随机抽卡，三类卡片样式分开。复盘「复制上一日」跳过空白日并带入正文，后台文章按修改时间倒序，前台引用块有了样式。

- 设计说明：[versions/v1.12.0.md](versions/v1.12.0.md)

## 1.11.0 - 2026-10-10

前台补上页面描述、分享信息和站点地图。文章标题统一为「标题 · 站点名」。

- 设计说明：[versions/v1.11.0.md](versions/v1.11.0.md)

## 1.10.0 - 2026-10-10

前台复盘按情绪封面和当日收益展示，标签云改为文章数热力，文章编辑按钮固定在底部。发布时强制重打后台包，并在 Docker 引擎无响应时自动拉起。

- 设计说明：[versions/v1.10.0.md](versions/v1.10.0.md)

## 1.9.0 - 2026-10-09

前台增加股票复盘列表和详情，站点配置可开关该菜单。

- 设计说明：[versions/v1.9.0.md](versions/v1.9.0.md)
- 数据脚本：[sql/cms_v1.9.0.sql](../sql/cms_v1.9.0.sql)

## 1.8.2 - 2026-10-08

后台可用对话 AI 从正文提取文章摘要。

- 设计说明：[versions/v1.8.2.md](versions/v1.8.2.md)

## 1.8.1 - 2026-10-08

前台文章详情头图支持全屏预览。

- 设计说明：[versions/v1.8.1.md](versions/v1.8.1.md)

## 1.8.0 - 2026-10-08

文章封面拆成列表 1:1 与详情宽图。

- 设计说明：[versions/v1.8.0.md](versions/v1.8.0.md)
- SQL：[sql/cms_v1.8.0.sql](../sql/cms_v1.8.0.sql)

## 1.7.2 - 2026-10-08

文章封面可选 AI 配置，按摘要和正文生成卡通像素风格图片。

- 设计说明：[versions/v1.7.2.md](versions/v1.7.2.md)

## 1.7.1 - 2026-10-08

前台文章列表和详情显示浏览次数。

- 设计说明：[versions/v1.7.1.md](versions/v1.7.1.md)

## 1.7.0 - 2026-10-08

前台预留多套主题，可在站点配置里带缩略图选择。

- 设计说明：[versions/v1.7.0.md](versions/v1.7.0.md)
- SQL：[sql/cms_v1.7.0.sql](../sql/cms_v1.7.0.sql)

## 1.6.0 - 2026-10-08

前台移动端菜单可收起，视觉改成暖纸朱印风格。

- 设计说明：[versions/v1.6.0.md](versions/v1.6.0.md)

## 1.5.2 - 2026-09-28

前台文章 Markdown 表格补齐边框和横向滚动，避免表格内容看起来像没渲染。

- 设计说明：[versions/v1.5.2.md](versions/v1.5.2.md)

## 1.5.1 - 2026-09-22

后台 Markdown 编辑器改用 @yancraft/vue 的 CodeEditor。

- 文章正文、站点「关于我」支持分栏预览
- 设计说明：[versions/v1.5.1.md](versions/v1.5.1.md)

## 1.5.0 - 2026-09-21

实验室全链路：后台维护项目，前台菜单和项目卡片页展示。

- 表 `cms_lab_project`，接口 `/cms/lab`、`/portal/cms/lab/list`
- 前台 `/lab` 展示封面、项目名称、项目描述、仓库地址和预览地址
- 站点配置 `labEnabled` 控制实验室菜单
- SQL：[sql/cms_v1.5.0.sql](../sql/cms_v1.5.0.sql)
- 设计说明：[versions/v1.5.0.md](versions/v1.5.0.md)

## 1.4.0 - 2026-09-20

后台站点配置：单页分卡表单（基础信息 / 关于我 / 导航开关）。

- 表 `cms_site_config`，接口 `/cms/site`、`/portal/cms/site`
- SQL：[sql/cms_v1.4.0.sql](../sql/cms_v1.4.0.sql)
- 设计说明：[versions/v1.4.0.md](versions/v1.4.0.md)

## 1.3.0 - 2026-09-20

后台友链管理：昵称、描述、网站地址、启用、排序。

- 表 `cms_friend_link`，接口 `/cms/link`
- SQL：[sql/cms_v1.3.0.sql](../sql/cms_v1.3.0.sql)
- 设计说明：[versions/v1.3.0.md](versions/v1.3.0.md)

## 1.2.0 - 2026-09-20

新增独立博客前台 `ruoyi-blog-web`（Nuxt 3）。

- 列表 / 正文 / 分类 / 标签 / 关于
- 设计说明：[versions/v1.2.0.md](versions/v1.2.0.md)

## 1.1.2 - 2026-09-20

文章新增/修改改为独立页面，不再使用弹窗。

- 隐藏路由 `/cms/article-edit/index`，修改带文章 ID
- 设计说明：[versions/v1.1.2.md](versions/v1.1.2.md)

## 1.1.1 - 2026-09-18

预置技术博客常用分类与标签种子数据。

- 分类 8 条，标签 16 条，可重复执行
- SQL：[sql/cms_v1.1.1.sql](../sql/cms_v1.1.1.sql)
- 设计说明：[versions/v1.1.1.md](versions/v1.1.1.md)

## 1.1.0 - 2026-09-18

补齐管理端文章、分类、标签三个 CRUD 页面。

- 页面路径对齐菜单：cms/article/index、cms/category/index、cms/tag/index
- 文章支持 Markdown 正文、封面上传、发布/下线
- 设计说明：[versions/v1.1.0.md](versions/v1.1.0.md)

## 1.0.1 - 2026-09-18

补齐 Java 注释，并修正源码中文编码（注释、校验文案、业务异常）。

- Controller / Service / Mapper / 实体字段补充 JavaDoc
- 不改接口路径、表结构、业务规则
- 设计说明：[versions/v1.0.1.md](versions/v1.0.1.md)

## 1.0.0 - 2026-09-18

首版。独立 Maven 模块，后台管理分类/标签/文章，前台匿名只读已发布内容。

- 文章落库字数 `word_count`、阅读时长 `reading_time`（保存时按 Markdown 自动计算）
- 文章状态：草稿 / 已发布 / 下线；逻辑删除
- 分类、标签、文章-标签多对多
- 设计说明：[versions/v1.0.0.md](versions/v1.0.0.md)
- DDL：[sql/cms_v1.0.0.sql](../sql/cms_v1.0.0.sql)
