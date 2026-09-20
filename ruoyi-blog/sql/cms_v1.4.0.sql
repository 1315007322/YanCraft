
-- cms v1.4.0 site setting
-- encoding: UTF-8 with BOM
-- incremental

create table if not exists cms_site_config (
  config_id         bigint(20)      not null auto_increment    comment '配置ID',
  config_key        varchar(64)     not null                   comment '配置键',
  config_value      mediumtext                                 comment '配置值',
  update_time       datetime                                   comment '更新时间',
  primary key (config_id),
  unique key uk_cms_site_config_key (config_key)
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci comment = '博客站点配置';

insert into cms_site_config(config_key, config_value, update_time)
select 'siteName', 'SuperYan', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'siteName');
insert into cms_site_config(config_key, config_value, update_time)
select 'logoPrefix', 'SUPER', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'logoPrefix');
insert into cms_site_config(config_key, config_value, update_time)
select 'logoHighlight', 'YAN', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'logoHighlight');
insert into cms_site_config(config_key, config_value, update_time)
select 'tagline', 'Going to try and get something up eventually I hope', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'tagline');
insert into cms_site_config(config_key, config_value, update_time)
select 'author', 'SuperYan', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'author');
insert into cms_site_config(config_key, config_value, update_time)
select 'avatarUrl', '', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'avatarUrl');
insert into cms_site_config(config_key, config_value, update_time)
select 'avatarLetter', 'SY', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'avatarLetter');
insert into cms_site_config(config_key, config_value, update_time)
select 'footerText', 'SuperYan', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'footerText');
insert into cms_site_config(config_key, config_value, update_time)
select 'siteUrl', '', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'siteUrl');
insert into cms_site_config(config_key, config_value, update_time)
select 'aboutTitle', 'SuperYan', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'aboutTitle');
insert into cms_site_config(config_key, config_value, update_time)
select 'aboutContent', '写作在若依后台完成，这里只读已发布的 Markdown 文章。', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'aboutContent');
insert into cms_site_config(config_key, config_value, update_time)
select 'aboutEnabled', '0', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'aboutEnabled');
insert into cms_site_config(config_key, config_value, update_time)
select 'searchEnabled', '0', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'searchEnabled');
insert into cms_site_config(config_key, config_value, update_time)
select 'categoryEnabled', '0', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'categoryEnabled');
insert into cms_site_config(config_key, config_value, update_time)
select 'friendLinkEnabled', '0', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'friendLinkEnabled');
insert into cms_site_config(config_key, config_value, update_time)
select 'hotLimit', '6', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'hotLimit');
insert into cms_site_config(config_key, config_value, update_time)
select 'homePageSize', '8', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'homePageSize');

insert into cms_site_config(config_key, config_value, update_time)
select 'beianText', '', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'beianText');
insert into cms_site_config(config_key, config_value, update_time)
select 'beianUrl', 'https://beian.miit.gov.cn/', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'beianUrl');

insert into sys_menu
select '2005', '站点配置', '2000', '5', 'site', 'cms/site/index', '', '', 1, 0, 'C', '0', '0', 'cms:site:query', 'edit', 'admin', sysdate(), '', null, '站点配置菜单'
from dual where not exists (select 1 from sys_menu where menu_id = 2005);

insert into sys_menu
select '2050', '站点查询', '2005', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:site:query', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 2050);

insert into sys_menu
select '2051', '站点修改', '2005', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:site:edit', '#', 'admin', sysdate(), '', null, ''
from dual where not exists (select 1 from sys_menu where menu_id = 2051);

insert into cms_site_config(config_key, config_value, update_time)
select 'extraNavLinks', '[]', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'extraNavLinks');
