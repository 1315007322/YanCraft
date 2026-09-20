
-- cms v1.3.0 友链管理
-- encoding: UTF-8 with BOM
-- incremental; menus skipped if menu_id exists

create table if not exists cms_friend_link (
  link_id           bigint(20)      not null auto_increment    comment '友链ID',
  nickname          varchar(50)     not null                   comment '昵称',
  description       varchar(200)    default null               comment '描述',
  site_url          varchar(255)    not null                   comment '网站地址',
  sort              int(4)          default 0                  comment '显示顺序',
  status            char(1)         default '0'                comment '状态（0启用 1停用）',
  del_flag          char(1)         default '0'                comment '删除标志（0存在 2删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (link_id),
  key idx_cms_friend_link_status_sort (status, sort)
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci comment = '博客友链表';

insert into sys_menu
select '2004', '友链管理', '2000', '4', 'link', 'cms/link/index', '', '', 1, 0, 'C', '0', '0', 'cms:link:list', 'link', 'admin', sysdate(), '', null, '友链管理菜单'
from dual where not exists (select 1 from sys_menu where menu_id = 2004);

insert into sys_menu
select '2040', '友链查询', '2004', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:link:query', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 2040);

insert into sys_menu
select '2041', '友链新增', '2004', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:link:add', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 2041);

insert into sys_menu
select '2042', '友链修改', '2004', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:link:edit', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 2042);

insert into sys_menu
select '2043', '友链删除', '2004', '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:link:remove', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 2043);
