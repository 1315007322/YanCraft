# 功能 Changelog

版本号只描述博客业务，与若依框架版本无关。

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
