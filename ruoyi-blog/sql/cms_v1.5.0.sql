-- cms v1.5.0 实验室项目
-- encoding: UTF-8
-- incremental; menus skipped if menu_id exists

create table if not exists cms_lab_project (
  project_id        bigint(20)      not null auto_increment    comment '项目ID',
  project_name      varchar(100)    not null                   comment '项目名称',
  description       varchar(500)    default null               comment '项目描述',
  repo_url          varchar(500)    not null                   comment '仓库地址',
  preview_url       varchar(500)    default null               comment '预览地址',
  cover             varchar(500)    default null               comment '封面',
  sort              int(4)          default 0                  comment '显示顺序',
  status            char(1)         default '0'                comment '状态（0启用 1停用）',
  del_flag          char(1)         default '0'                comment '删除标志（0存在 2删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (project_id),
  key idx_cms_lab_project_status_sort (status, sort)
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci comment = '实验室项目';

-- Compatibility for databases that ran an earlier v1.5.0 script
set @description_column_exists = (
  select count(*) from information_schema.columns
  where table_schema = database()
    and table_name = 'cms_lab_project'
    and column_name = 'description'
);
set @description_column_sql = if(
  @description_column_exists = 0,
  'alter table cms_lab_project add column description varchar(500) default null after project_name',
  'select 1'
);
prepare description_column_statement from @description_column_sql;
execute description_column_statement;
deallocate prepare description_column_statement;

insert into cms_site_config(config_key, config_value, update_time)
select 'labEnabled', '0', sysdate() from dual
where not exists (select 1 from cms_site_config where config_key = 'labEnabled');

insert into sys_menu
select '2006', '实验室', '2000', '6', 'lab', 'cms/lab/index', '', '', 1, 0, 'C', '0', '0', 'cms:lab:list', 'tool', 'admin', sysdate(), '', null, '实验室菜单'
from dual where not exists (select 1 from sys_menu where menu_id = 2006);

insert into sys_menu
select '2060', '实验室查询', '2006', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:lab:query', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 2060);

insert into sys_menu
select '2061', '实验室新增', '2006', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:lab:add', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 2061);

insert into sys_menu
select '2062', '实验室修改', '2006', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:lab:edit', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 2062);

insert into sys_menu
select '2063', '实验室删除', '2006', '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:lab:remove', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 2063);
