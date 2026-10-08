-- sys AI config v1.0.0
-- encoding: UTF-8

create table if not exists sys_ai_config (
  config_id         bigint(20)      not null auto_increment    comment 'config id',
  config_name       varchar(50)     not null                   comment 'display name',
  purpose           varchar(16)     not null                   comment 'chat or image',
  base_url          varchar(255)    not null                   comment 'OpenAI-compatible base url',
  api_key           varchar(512)    not null                   comment 'api key',
  model_name        varchar(100)    not null                   comment 'model',
  timeout_seconds   int(11)         default 60                 comment 'timeout seconds',
  max_tokens        int(11)         default 4096               comment 'chat max tokens',
  image_size        varchar(32)     default '1024x1024'        comment 'image size',
  system_prompt     varchar(2000)   default null               comment 'optional system prompt',
  is_default        char(1)         default 'N'                comment 'Y default for purpose',
  status            char(1)         default '0'                comment '0 enabled 1 disabled',
  sort              int(11)         default 0                  comment 'sort',
  create_by         varchar(64)     default ''                 comment 'create by',
  create_time       datetime                                   comment 'create time',
  update_by         varchar(64)     default ''                 comment 'update by',
  update_time       datetime                                   comment 'update time',
  remark            varchar(500)    default null               comment 'remark',
  primary key (config_id),
  unique key uk_ai_config_name (config_name)
) engine=innodb comment='AI provider profiles';

insert into sys_menu
select 118, 'AI配置', 1, 10, 'ai', 'system/ai/index', '', '', 1, 0, 'C', '0', '0', 'system:ai:list', 'online', 'admin', sysdate(), '', null, 'AI调用配置'
from dual where not exists (select 1 from sys_menu where menu_id = 118);

insert into sys_menu
select 1181, 'AI查询', 118, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:ai:query', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 1181);

insert into sys_menu
select 1182, 'AI新增', 118, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:ai:add', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 1182);

insert into sys_menu
select 1183, 'AI修改', 118, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:ai:edit', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 1183);

insert into sys_menu
select 1184, 'AI删除', 118, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:ai:remove', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 1184);

insert into sys_role_menu (role_id, menu_id)
select 1, m.menu_id from (select 118 as menu_id union all select 1181 union all select 1182 union all select 1183 union all select 1184) m
where not exists (select 1 from sys_role_menu rm where rm.role_id = 1 and rm.menu_id = m.menu_id);
