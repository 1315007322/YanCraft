-- cms v1.0.0 博客模块
-- 在 craft 库执行；可重复执行会先 drop 业务表（仅首次建库使用）

-- ----------------------------
-- 分类
-- ----------------------------
drop table if exists cms_article_tag;
drop table if exists cms_article;
drop table if exists cms_tag;
drop table if exists cms_category;

create table cms_category (
  category_id       bigint(20)      not null auto_increment    comment '分类ID',
  parent_id         bigint(20)      default 0                  comment '父分类ID（首版扁平，默认0）',
  name              varchar(50)     not null                   comment '分类名称',
  slug              varchar(80)     default null               comment '访问标识',
  sort              int(4)          default 0                  comment '显示顺序',
  status            char(1)         default '0'                comment '状态（0正常 1停用）',
  del_flag          char(1)         default '0'                comment '删除标志（0存在 2删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (category_id),
  unique key uk_cms_category_slug (slug)
) engine=innodb comment = '博客分类表';

create table cms_tag (
  tag_id            bigint(20)      not null auto_increment    comment '标签ID',
  name              varchar(50)     not null                   comment '标签名称',
  slug              varchar(80)     default null               comment '访问标识',
  del_flag          char(1)         default '0'                comment '删除标志（0存在 2删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (tag_id),
  unique key uk_cms_tag_name (name),
  unique key uk_cms_tag_slug (slug)
) engine=innodb comment = '博客标签表';

create table cms_article (
  article_id        bigint(20)      not null auto_increment    comment '文章ID',
  title             varchar(200)    not null                   comment '标题',
  slug              varchar(120)    default null               comment '访问标识',
  summary           varchar(500)    default ''                 comment '摘要',
  cover             varchar(255)    default ''                 comment '封面',
  content           mediumtext                                 comment 'Markdown正文',
  category_id       bigint(20)      default null               comment '分类ID',
  author            varchar(64)     default ''                 comment '作者',
  status            char(1)         default '0'                comment '状态（0草稿 1已发布 2下线）',
  is_top            char(1)         default '0'                comment '是否置顶（0否 1是）',
  view_count        int(11)         default 0                  comment '浏览量',
  word_count        int(11)         default 0                  comment '字数（中文按字，英文按词）',
  reading_time      int(11)         default 0                  comment '预计阅读分钟数',
  publish_time      datetime                                   comment '首次发布时间',
  del_flag          char(1)         default '0'                comment '删除标志（0存在 2删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (article_id),
  unique key uk_cms_article_slug (slug),
  key idx_cms_article_category (category_id),
  key idx_cms_article_status_time (status, publish_time)
) engine=innodb comment = '博客文章表';

create table cms_article_tag (
  article_id        bigint(20)      not null                   comment '文章ID',
  tag_id            bigint(20)      not null                   comment '标签ID',
  primary key (article_id, tag_id)
) engine=innodb comment = '文章标签关联表';

-- ----------------------------
-- 字典：文章状态
-- ----------------------------
insert into sys_dict_type(dict_name, dict_type, status, create_by, create_time, remark)
select '博客文章状态', 'cms_article_status', '0', 'admin', sysdate(), '草稿/已发布/下线'
from dual where not exists (select 1 from sys_dict_type where dict_type = 'cms_article_status');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 1, '草稿', '0', 'cms_article_status', '', 'info', 'Y', '0', 'admin', sysdate(), '草稿'
from dual where not exists (select 1 from sys_dict_data where dict_type = 'cms_article_status' and dict_value = '0');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 2, '已发布', '1', 'cms_article_status', '', 'success', 'N', '0', 'admin', sysdate(), '已发布'
from dual where not exists (select 1 from sys_dict_data where dict_type = 'cms_article_status' and dict_value = '1');

insert into sys_dict_data(dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
select 3, '下线', '2', 'cms_article_status', '', 'danger', 'N', '0', 'admin', sysdate(), '下线'
from dual where not exists (select 1 from sys_dict_data where dict_type = 'cms_article_status' and dict_value = '2');

-- ----------------------------
-- 菜单（menu_id 从 2000 起，避开若依初始数据）
-- ----------------------------
insert into sys_menu values('2000', '博客管理', '0', '5', 'cms', null, '', '', 1, 0, 'M', '0', '0', '', 'documentation', 'admin', sysdate(), '', null, '博客管理目录');

insert into sys_menu values('2001', '文章管理', '2000', '1', 'article', 'cms/article/index', '', '', 1, 0, 'C', '0', '0', 'cms:article:list', 'edit', 'admin', sysdate(), '', null, '文章管理菜单');
insert into sys_menu values('2002', '分类管理', '2000', '2', 'category', 'cms/category/index', '', '', 1, 0, 'C', '0', '0', 'cms:category:list', 'tree', 'admin', sysdate(), '', null, '分类管理菜单');
insert into sys_menu values('2003', '标签管理', '2000', '3', 'tag', 'cms/tag/index', '', '', 1, 0, 'C', '0', '0', 'cms:tag:list', 'dict', 'admin', sysdate(), '', null, '标签管理菜单');

insert into sys_menu values('2010', '文章查询', '2001', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:article:query', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2011', '文章新增', '2001', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:article:add', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2012', '文章修改', '2001', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:article:edit', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2013', '文章删除', '2001', '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:article:remove', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2014', '文章发布', '2001', '5', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:article:publish', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2015', '文章下线', '2001', '6', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:article:offline', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu values('2020', '分类查询', '2002', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:category:query', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2021', '分类新增', '2002', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:category:add', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2022', '分类修改', '2002', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:category:edit', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2023', '分类删除', '2002', '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:category:remove', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu values('2030', '标签查询', '2003', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:tag:query', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2031', '标签新增', '2003', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:tag:add', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2032', '标签修改', '2003', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:tag:edit', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2033', '标签删除', '2003', '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'cms:tag:remove', '#', 'admin', sysdate(), '', null, '');
