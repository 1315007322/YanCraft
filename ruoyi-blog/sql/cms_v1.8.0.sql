-- cms v1.8.0 article list cover + detail banner
-- encoding: UTF-8
-- incremental

alter table cms_article
  add column cover_wide varchar(500) default null comment '详情头图' after cover;
