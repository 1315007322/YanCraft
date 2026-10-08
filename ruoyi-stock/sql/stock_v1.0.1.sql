-- stock v1.0.1 review templates
-- encoding: UTF-8

create table if not exists stock_review_template (
  template_id     bigint(20)      not null auto_increment    comment 'template id',
  owner_user_id   bigint(20)      not null default 0         comment '0 system, else user',
  template_code   varchar(32)     default null               comment 'system code',
  template_name   varchar(40)     not null                   comment 'name',
  summary         varchar(200)    default null               comment 'summary',
  mood            char(1)         default '0'                comment 'default mood',
  score           int(1)          default null               comment 'default score',
  conclusion      mediumtext                                 comment 'conclusion md',
  mistake         mediumtext                                 comment 'mistake md',
  next_plan       mediumtext                                 comment 'next plan md',
  sort            int(4)          default 0                  comment 'sort',
  del_flag        char(1)         default '0'                comment '0 exist 2 deleted',
  create_by       varchar(64)     default ''                 comment 'create by',
  create_time     datetime                                   comment 'create time',
  update_by       varchar(64)     default ''                 comment 'update by',
  update_time     datetime                                   comment 'update time',
  remark          varchar(500)    default null               comment 'remark',
  primary key (template_id),
  key idx_stock_tpl_owner (owner_user_id, del_flag, sort),
  unique key uk_stock_tpl_code (template_code)
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci comment='stock review template';
