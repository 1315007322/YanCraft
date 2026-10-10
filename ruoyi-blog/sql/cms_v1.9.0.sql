-- cms v1.9.0 stock review menu switch
-- encoding: UTF-8

insert into cms_site_config(config_key, config_value, update_time)
select 'stockReviewEnabled', '0', sysdate() from dual
where not exists (select 1 from cms_site_config where config_key = 'stockReviewEnabled');

insert into cms_site_config(config_key, config_value, update_time)
select 'stockReviewCoverCalm', '', sysdate() from dual
where not exists (select 1 from cms_site_config where config_key = 'stockReviewCoverCalm');

insert into cms_site_config(config_key, config_value, update_time)
select 'stockReviewCoverOptimistic', '', sysdate() from dual
where not exists (select 1 from cms_site_config where config_key = 'stockReviewCoverOptimistic');

insert into cms_site_config(config_key, config_value, update_time)
select 'stockReviewCoverCautious', '', sysdate() from dual
where not exists (select 1 from cms_site_config where config_key = 'stockReviewCoverCautious');

insert into cms_site_config(config_key, config_value, update_time)
select 'stockReviewCoverChase', '', sysdate() from dual
where not exists (select 1 from cms_site_config where config_key = 'stockReviewCoverChase');

insert into cms_site_config(config_key, config_value, update_time)
select 'stockReviewCoverPanic', '', sysdate() from dual
where not exists (select 1 from cms_site_config where config_key = 'stockReviewCoverPanic');
