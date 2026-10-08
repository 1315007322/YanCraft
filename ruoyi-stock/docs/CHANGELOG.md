# 功能 Changelog

版本号只描述股票复盘业务，与若依框架版本无关。

## 1.0.3 - 2026-10-08

复盘拆成看板预览页和编写页。

- 设计说明：[versions/v1.0.3.md](versions/v1.0.3.md)
- SQL：[sql/stock_v1.0.3.sql](../sql/stock_v1.0.3.sql)

## 1.0.2 - 2026-10-08

当日交易支持按代码或名称搜索下拉。

- 接口 `GET /stock/review/symbols?q=`
- 优先出自己用过的标的，再补全市场代码/名称
- 设计说明：[versions/v1.0.2.md](versions/v1.0.2.md)

## 1.0.1 - 2026-09-29

复盘模板：系统预置几类常见交易日，也可以存自己的模板。

- 表 `stock_review_template`
- 接口 `GET/POST /stock/review/templates`，`DELETE /stock/review/templates/{id}`
- SQL：[sql/stock_v1.0.1.sql](../sql/stock_v1.0.1.sql)
- 设计说明：[versions/v1.0.1.md](versions/v1.0.1.md)

## 1.0.0 - 2026-09-29

个人股票每日复盘首版。

- 月历、结论三栏、可选交易明细
- 每用户每日一行，不做行情和券商接入
- SQL：[sql/stock_v1.0.0.sql](../sql/stock_v1.0.0.sql)
- 设计说明：[versions/v1.0.0.md](versions/v1.0.0.md)
