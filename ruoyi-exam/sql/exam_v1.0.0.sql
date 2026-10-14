-- exam verbal cards v1.0.0
-- encoding: UTF-8

create table if not exists exam_verbal_card (
  card_id bigint not null auto_increment,
  owner_user_id bigint not null,
  card_type char(1) not null default '0' comment '0 word 1 linker 2 gist',
  prompt varchar(80) not null,
  difference varchar(500) not null,
  collocation varchar(200) default null,
  confusion varchar(200) default null,
  own_sentence varchar(300) default null,
  interval_days int not null default 0,
  due_date date not null,
  review_count int not null default 0,
  del_flag char(1) default '0',
  create_by varchar(64) default '',
  create_time datetime default null,
  update_by varchar(64) default '',
  update_time datetime default null,
  remark varchar(500) default null,
  primary key (card_id),
  key idx_exam_verbal_due (due_date, card_id)
) engine=innodb comment='verbal memory card';

create table if not exists exam_verbal_daily (
  deck_date date not null,
  card_id bigint not null,
  sort int not null default 0,
  missed char(1) not null default '0' comment '1 pushed back to tomorrow',
  create_time datetime default null,
  primary key (deck_date, card_id)
) engine=innodb comment='verbal daily deck';

insert into cms_site_config(config_key, config_value, update_time)
select 'verbalEnabled', '0', sysdate() from dual
where not exists (select 1 from cms_site_config where config_key = 'verbalEnabled');

insert into sys_menu
select 3200, '考公', 0, 6, 'exam', null, '', '', 1, 0, 'M', '0', '0', '', 'education', 'admin', sysdate(), '', null, '考公记忆目录'
from dual where not exists (select 1 from sys_menu where menu_id = 3200);
insert into sys_menu
select 3201, '言语积累', 3200, 1, 'verbal', 'exam/verbal/index', '', '', 1, 0, 'C', '0', '0', 'exam:verbal:list', 'edit', 'admin', sysdate(), '', null, '言语积累卡片'
from dual where not exists (select 1 from sys_menu where menu_id = 3201);
insert into sys_menu
select 3210, '卡片查询', 3201, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'exam:verbal:query', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 3210);
insert into sys_menu
select 3211, '卡片新增', 3201, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'exam:verbal:add', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 3211);
insert into sys_menu
select 3212, '卡片修改', 3201, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'exam:verbal:edit', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 3212);
insert into sys_menu
select 3213, '卡片删除', 3201, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'exam:verbal:remove', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 3213);
insert into sys_role_menu (role_id, menu_id)
select 1, m.menu_id from (
  select 3200 as menu_id union all select 3201 union all select 3210 union all select 3211 union all select 3212 union all select 3213
) m
where not exists (select 1 from sys_role_menu rm where rm.role_id = 1 and rm.menu_id = m.menu_id);
