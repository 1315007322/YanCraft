-- cms v1.7.0 frontend theme
-- encoding: UTF-8

insert into cms_site_config(config_key, config_value, update_time)
select 'themeId', 'paper', sysdate()
from dual where not exists (select 1 from cms_site_config where config_key = 'themeId');
