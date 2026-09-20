-- cms v1.4.2 author signature, idempotent
insert into cms_site_config(config_key, config_value, update_time)
select 'authorSignature', '', sysdate() from dual where not exists (select 1 from cms_site_config where config_key = 'authorSignature');
