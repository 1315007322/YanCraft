# 功能 Changelog

版本号只描述博客业务，与若依框架版本无关。

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
