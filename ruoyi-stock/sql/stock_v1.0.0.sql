-- stock v1.0.0 personal daily review
-- encoding: UTF-8

create table if not exists stock_review (
  review_id       bigint(20)      not null auto_increment    comment 'review id',
  owner_user_id   bigint(20)      not null                   comment 'owner user id',
  review_date     date            not null                   comment 'review date',
  mood            char(1)         default '0'                comment 'mood 0-4',
  score           int(1)          default null               comment 'discipline score 1-5',
  conclusion      mediumtext                                 comment 'conclusion markdown',
  mistake         mediumtext                                 comment 'mistake markdown',
  next_plan       mediumtext                                 comment 'next plan markdown',
  del_flag        char(1)         default '0'                comment '0 exist 2 deleted',
  create_by       varchar(64)     default ''                 comment 'create by',
  create_time     datetime                                   comment 'create time',
  update_by       varchar(64)     default ''                 comment 'update by',
  update_time     datetime                                   comment 'update time',
  remark          varchar(500)    default null               comment 'remark',
  primary key (review_id),
  key idx_stock_review_owner_date (owner_user_id, review_date, del_flag)
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci comment='stock daily review';

create table if not exists stock_review_trade (
  trade_id        bigint(20)      not null auto_increment    comment 'trade id',
  review_id       bigint(20)      not null                   comment 'review id',
  owner_user_id   bigint(20)      not null                   comment 'owner user id',
  stock_code      varchar(16)     not null                   comment 'stock code',
  stock_name      varchar(64)     default ''                 comment 'stock name',
  direction       char(1)         default '0'                comment '0 buy 1 sell 2 watch',
  quantity        decimal(18,2)   default null               comment 'quantity',
  price           decimal(18,4)   default null               comment 'price',
  profit_loss     decimal(18,2)   default null               comment 'manual pnl',
  result_tag      char(1)         default null               comment '0 planned 1 chase 2 hold 3 tp 4 sl 5 watch',
  note            varchar(500)    default null               comment 'note',
  sort            int(4)          default 0                  comment 'sort',
  del_flag        char(1)         default '0'                comment '0 exist 2 deleted',
  create_by       varchar(64)     default ''                 comment 'create by',
  create_time     datetime                                   comment 'create time',
  update_by       varchar(64)     default ''                 comment 'update by',
  update_time     datetime                                   comment 'update time',
  remark          varchar(500)    default null               comment 'remark',
  primary key (trade_id),
  key idx_stock_trade_review (review_id, del_flag, sort),
  key idx_stock_trade_owner (owner_user_id, del_flag)
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci comment='stock review trade';

insert into sys_dict_type(dict_name, dict_type, status, create_by, create_time, remark)
select '复盘情绪', 'stock_review_mood', '0', 'admin', sysdate(), '每日复盘市场情绪'
from dual where not exists (select 1 from sys_dict_type where dict_type = 'stock_review_mood');
insert into sys_dict_type(dict_name, dict_type, status, create_by, create_time, remark)
select '交易方向', 'stock_trade_direction', '0', 'admin', sysdate(), '复盘交易方向'
from dual where not exists (select 1 from sys_dict_type where dict_type = 'stock_trade_direction');
insert into sys_dict_type(dict_name, dict_type, status, create_by, create_time, remark)
select '交易结果', 'stock_trade_result', '0', 'admin', sysdate(), '复盘交易结果标签'
from dual where not exists (select 1 from sys_dict_type where dict_type = 'stock_trade_result');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 1, '冷静', '0', 'stock_review_mood', '', 'info', 'Y', '0', 'admin', sysdate(), ''
from dual where not exists (select 1 from sys_dict_data where dict_type = 'stock_review_mood' and dict_value = '0');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 2, '乐观', '1', 'stock_review_mood', '', 'success', 'N', '0', 'admin', sysdate(), ''
from dual where not exists (select 1 from sys_dict_data where dict_type = 'stock_review_mood' and dict_value = '1');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 3, '谨慎', '2', 'stock_review_mood', '', 'warning', 'N', '0', 'admin', sysdate(), ''
from dual where not exists (select 1 from sys_dict_data where dict_type = 'stock_review_mood' and dict_value = '2');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 4, '追涨', '3', 'stock_review_mood', '', 'danger', 'N', '0', 'admin', sysdate(), ''
from dual where not exists (select 1 from sys_dict_data where dict_type = 'stock_review_mood' and dict_value = '3');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 5, '恐慌', '4', 'stock_review_mood', '', 'danger', 'N', '0', 'admin', sysdate(), ''
from dual where not exists (select 1 from sys_dict_data where dict_type = 'stock_review_mood' and dict_value = '4');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 1, '买入', '0', 'stock_trade_direction', '', 'success', 'Y', '0', 'admin', sysdate(), ''
from dual where not exists (select 1 from sys_dict_data where dict_type = 'stock_trade_direction' and dict_value = '0');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 2, '卖出', '1', 'stock_trade_direction', '', 'danger', 'N', '0', 'admin', sysdate(), ''
from dual where not exists (select 1 from sys_dict_data where dict_type = 'stock_trade_direction' and dict_value = '1');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 3, '观察', '2', 'stock_trade_direction', '', 'info', 'N', '0', 'admin', sysdate(), ''
from dual where not exists (select 1 from sys_dict_data where dict_type = 'stock_trade_direction' and dict_value = '2');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 1, '计划内', '0', 'stock_trade_result', '', 'success', 'N', '0', 'admin', sysdate(), ''
from dual where not exists (select 1 from sys_dict_data where dict_type = 'stock_trade_result' and dict_value = '0');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 2, '追涨', '1', 'stock_trade_result', '', 'danger', 'N', '0', 'admin', sysdate(), ''
from dual where not exists (select 1 from sys_dict_data where dict_type = 'stock_trade_result' and dict_value = '1');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 3, '扛单', '2', 'stock_trade_result', '', 'warning', 'N', '0', 'admin', sysdate(), ''
from dual where not exists (select 1 from sys_dict_data where dict_type = 'stock_trade_result' and dict_value = '2');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 4, '止盈', '3', 'stock_trade_result', '', 'success', 'N', '0', 'admin', sysdate(), ''
from dual where not exists (select 1 from sys_dict_data where dict_type = 'stock_trade_result' and dict_value = '3');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 5, '止损', '4', 'stock_trade_result', '', 'danger', 'N', '0', 'admin', sysdate(), ''
from dual where not exists (select 1 from sys_dict_data where dict_type = 'stock_trade_result' and dict_value = '4');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 6, '观察', '5', 'stock_trade_result', '', 'info', 'N', '0', 'admin', sysdate(), ''
from dual where not exists (select 1 from sys_dict_data where dict_type = 'stock_trade_result' and dict_value = '5');

insert into sys_menu
select 3100, '股票复盘', 0, 5, 'stock', null, '', '', 1, 0, 'M', '0', '0', '', 'chart', 'admin', sysdate(), '', null, '个人股票每日复盘目录'
from dual where not exists (select 1 from sys_menu where menu_id = 3100);
insert into sys_menu
select 3101, '每日复盘', 3100, 1, 'review', 'stock/review/index', '', '', 1, 0, 'C', '0', '0', 'stock:review:list', 'date', 'admin', sysdate(), '', null, '个人股票每日复盘菜单'
from dual where not exists (select 1 from sys_menu where menu_id = 3101);
insert into sys_menu
select 3110, '复盘查询', 3101, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'stock:review:query', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 3110);
insert into sys_menu
select 3111, '复盘新增', 3101, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'stock:review:add', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 3111);
insert into sys_menu
select 3112, '复盘修改', 3101, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'stock:review:edit', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 3112);
insert into sys_menu
select 3113, '复盘删除', 3101, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'stock:review:remove', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 3113);
insert into sys_role_menu (role_id, menu_id)
select 1, m.menu_id from (select 3100 as menu_id union all select 3101 union all select 3110 union all select 3111 union all select 3112 union all select 3113) m
where not exists (select 1 from sys_role_menu rm where rm.role_id = 1 and rm.menu_id = m.menu_id);
