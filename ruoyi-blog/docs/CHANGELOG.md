# 功能 Changelog

版本号只描述博客业务，与若依框架版本无关。

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
