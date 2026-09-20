-- cms v1.4.1 beian fields, idempotent
insert into cms_site_config(config_key, config_value, update_time)
select 'beianText', '', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'beianText');
insert into cms_site_config(config_key, config_value, update_time)
select 'beianUrl', 'https://beian.miit.gov.cn/', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'beianUrl');

insert into cms_site_config(config_key, config_value, update_time)
select 'extraNavLinks', '[]', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'extraNavLinks');
