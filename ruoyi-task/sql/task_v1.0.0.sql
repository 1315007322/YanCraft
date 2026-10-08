-- task v1.0.0 个人任务管理
-- encoding: UTF-8

create table if not exists task_item (
  task_id           bigint(20)      not null auto_increment    comment '任务ID',
  parent_id         bigint(20)      default 0                  comment '父任务ID，0为主任务',
  owner_user_id     bigint(20)      not null                   comment '所属用户ID',
  task_name         varchar(120)    not null                   comment '任务名称',
  description       varchar(1000)   default null               comment '任务描述',
  status            char(1)         default '0'                comment '状态（0待开始 1进行中 2已完成 3已取消）',
  priority          char(1)         default '1'                comment '优先级（0低 1普通 2高 3紧急）',
  progress          int(3)          default 0                  comment '进度（0-100）',
  total_quantity    int(11)         default null               comment '任务总数量',
  completed_quantity int(11)        default null               comment '已完成数量',
  plan_start_date   date            default null               comment '计划开始日期',
  due_date          date            default null               comment '截止日期',
  completed_time    datetime        default null               comment '完成时间',
  sort              int(4)          default 0                  comment '显示顺序',
  del_flag          char(1)         default '0'                comment '删除标志（0存在 2删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (task_id),
  key idx_task_owner_parent_status (owner_user_id, parent_id, status),
  key idx_task_owner_due_date (owner_user_id, due_date)
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci comment='个人任务';

insert into sys_dict_type(dict_name, dict_type, status, create_by, create_time, remark)
select '任务状态', 'task_status', '0', 'admin', sysdate(), '个人任务状态'
from dual where not exists (select 1 from sys_dict_type where dict_type = 'task_status');

insert into sys_dict_type(dict_name, dict_type, status, create_by, create_time, remark)
select '任务优先级', 'task_priority', '0', 'admin', sysdate(), '个人任务优先级'
from dual where not exists (select 1 from sys_dict_type where dict_type = 'task_priority');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 1, '待开始', '0', 'task_status', '', 'info', 'Y', '0', 'admin', sysdate(), '任务尚未开始'
from dual where not exists (select 1 from sys_dict_data where dict_type = 'task_status' and dict_value = '0');
insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 2, '进行中', '1', 'task_status', '', 'primary', 'N', '0', 'admin', sysdate(), '任务正在进行'
from dual where not exists (select 1 from sys_dict_data where dict_type = 'task_status' and dict_value = '1');
insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 3, '已完成', '2', 'task_status', '', 'success', 'N', '0', 'admin', sysdate(), '任务已经完成'
from dual where not exists (select 1 from sys_dict_data where dict_type = 'task_status' and dict_value = '2');
insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 4, '已取消', '3', 'task_status', '', 'danger', 'N', '0', 'admin', sysdate(), '任务已经取消'
from dual where not exists (select 1 from sys_dict_data where dict_type = 'task_status' and dict_value = '3');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 1, '低', '0', 'task_priority', '', 'info', 'N', '0', 'admin', sysdate(), '低优先级'
from dual where not exists (select 1 from sys_dict_data where dict_type = 'task_priority' and dict_value = '0');
insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 2, '普通', '1', 'task_priority', '', 'primary', 'Y', '0', 'admin', sysdate(), '普通优先级'
from dual where not exists (select 1 from sys_dict_data where dict_type = 'task_priority' and dict_value = '1');
insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 3, '高', '2', 'task_priority', '', 'warning', 'N', '0', 'admin', sysdate(), '高优先级'
from dual where not exists (select 1 from sys_dict_data where dict_type = 'task_priority' and dict_value = '2');
insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 4, '紧急', '3', 'task_priority', '', 'danger', 'N', '0', 'admin', sysdate(), '紧急优先级'
from dual where not exists (select 1 from sys_dict_data where dict_type = 'task_priority' and dict_value = '3');

insert into sys_menu
select 3000, '任务管理', 0, 4, 'task', null, '', '', 1, 0, 'M', '0', '0', '', 'clipboard', 'admin', sysdate(), '', null, '个人任务管理目录'
from dual where not exists (select 1 from sys_menu where menu_id = 3000);
insert into sys_menu
select 3001, '我的任务', 3000, 1, 'item', 'task/item/index', '', '', 1, 0, 'C', '0', '0', 'task:item:list', 'list', 'admin', sysdate(), '', null, '个人任务管理菜单'
from dual where not exists (select 1 from sys_menu where menu_id = 3001);
insert into sys_menu
select 3010, '任务查询', 3001, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'task:item:query', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 3010);
insert into sys_menu
select 3011, '任务新增', 3001, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'task:item:add', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 3011);
insert into sys_menu
select 3012, '任务修改', 3001, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'task:item:edit', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 3012);
insert into sys_menu
select 3013, '任务删除', 3001, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'task:item:remove', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 3013);
