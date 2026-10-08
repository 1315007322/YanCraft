-- stock v1.0.3 split board and write pages
-- encoding: UTF-8

update sys_menu
   set menu_name = '复盘看板',
       remark = '个人股票复盘看板与预览'
 where menu_id = 3101;

insert into sys_menu
select 3102, '写复盘', 3100, 2, 'write', 'stock/review/write', '', '', 1, 1, 'C', '0', '0', 'stock:review:add', 'edit', 'admin', sysdate(), '', null, '编写每日股票复盘'
from dual where not exists (select 1 from sys_menu where menu_id = 3102);

insert into sys_role_menu (role_id, menu_id)
select 1, 3102 from dual
where not exists (select 1 from sys_role_menu rm where rm.role_id = 1 and rm.menu_id = 3102);
