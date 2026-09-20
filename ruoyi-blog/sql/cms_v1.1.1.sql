-- cms v1.1.1 常用分类、标签种子
-- 编码：UTF-8 with BOM
-- 在 craft 库执行；按 name/slug 去重，可重复执行，不修改已有数据

-- ----------------------------
-- 分类（扁平）
-- ----------------------------
insert into cms_category(parent_id, name, slug, sort, status, del_flag, create_by, create_time, remark)
select 0, '后端', 'backend', 1, '0', '0', 'admin', sysdate(), '服务端开发'
from dual where not exists (select 1 from cms_category where slug = 'backend' or name = '后端');

insert into cms_category(parent_id, name, slug, sort, status, del_flag, create_by, create_time, remark)
select 0, '前端', 'frontend', 2, '0', '0', 'admin', sysdate(), '页面与交互'
from dual where not exists (select 1 from cms_category where slug = 'frontend' or name = '前端');

insert into cms_category(parent_id, name, slug, sort, status, del_flag, create_by, create_time, remark)
select 0, '数据库', 'database', 3, '0', '0', 'admin', sysdate(), '库表与 SQL'
from dual where not exists (select 1 from cms_category where slug = 'database' or name = '数据库');

insert into cms_category(parent_id, name, slug, sort, status, del_flag, create_by, create_time, remark)
select 0, '运维', 'devops', 4, '0', '0', 'admin', sysdate(), '部署与运维'
from dual where not exists (select 1 from cms_category where slug = 'devops' or name = '运维');

insert into cms_category(parent_id, name, slug, sort, status, del_flag, create_by, create_time, remark)
select 0, '架构', 'architecture', 5, '0', '0', 'admin', sysdate(), '设计与演进'
from dual where not exists (select 1 from cms_category where slug = 'architecture' or name = '架构');

insert into cms_category(parent_id, name, slug, sort, status, del_flag, create_by, create_time, remark)
select 0, '算法与面试', 'algorithm', 6, '0', '0', 'admin', sysdate(), '算法、面试与手写'
from dual where not exists (select 1 from cms_category where slug = 'algorithm' or name = '算法与面试');

insert into cms_category(parent_id, name, slug, sort, status, del_flag, create_by, create_time, remark)
select 0, '工具与效率', 'tools', 7, '0', '0', 'admin', sysdate(), '工具链与工作流'
from dual where not exists (select 1 from cms_category where slug = 'tools' or name = '工具与效率');

insert into cms_category(parent_id, name, slug, sort, status, del_flag, create_by, create_time, remark)
select 0, '随笔', 'essay', 8, '0', '0', 'admin', sysdate(), '杂谈与记录'
from dual where not exists (select 1 from cms_category where slug = 'essay' or name = '随笔');

-- ----------------------------
-- 标签
-- ----------------------------
insert into cms_tag(name, slug, del_flag, create_by, create_time, remark)
select 'Java', 'java', '0', 'admin', sysdate(), NULL
from dual where not exists (select 1 from cms_tag where slug = 'java' or name = 'Java');

insert into cms_tag(name, slug, del_flag, create_by, create_time, remark)
select 'Spring Boot', 'spring-boot', '0', 'admin', sysdate(), NULL
from dual where not exists (select 1 from cms_tag where slug = 'spring-boot' or name = 'Spring Boot');

insert into cms_tag(name, slug, del_flag, create_by, create_time, remark)
select 'Spring Security', 'spring-security', '0', 'admin', sysdate(), NULL
from dual where not exists (select 1 from cms_tag where slug = 'spring-security' or name = 'Spring Security');

insert into cms_tag(name, slug, del_flag, create_by, create_time, remark)
select 'MyBatis', 'mybatis', '0', 'admin', sysdate(), NULL
from dual where not exists (select 1 from cms_tag where slug = 'mybatis' or name = 'MyBatis');

insert into cms_tag(name, slug, del_flag, create_by, create_time, remark)
select 'Vue', 'vue', '0', 'admin', sysdate(), NULL
from dual where not exists (select 1 from cms_tag where slug = 'vue' or name = 'Vue');

insert into cms_tag(name, slug, del_flag, create_by, create_time, remark)
select 'TypeScript', 'typescript', '0', 'admin', sysdate(), NULL
from dual where not exists (select 1 from cms_tag where slug = 'typescript' or name = 'TypeScript');

insert into cms_tag(name, slug, del_flag, create_by, create_time, remark)
select 'Element Plus', 'element-plus', '0', 'admin', sysdate(), NULL
from dual where not exists (select 1 from cms_tag where slug = 'element-plus' or name = 'Element Plus');

insert into cms_tag(name, slug, del_flag, create_by, create_time, remark)
select 'MySQL', 'mysql', '0', 'admin', sysdate(), NULL
from dual where not exists (select 1 from cms_tag where slug = 'mysql' or name = 'MySQL');

insert into cms_tag(name, slug, del_flag, create_by, create_time, remark)
select 'Redis', 'redis', '0', 'admin', sysdate(), NULL
from dual where not exists (select 1 from cms_tag where slug = 'redis' or name = 'Redis');

insert into cms_tag(name, slug, del_flag, create_by, create_time, remark)
select 'Docker', 'docker', '0', 'admin', sysdate(), NULL
from dual where not exists (select 1 from cms_tag where slug = 'docker' or name = 'Docker');

insert into cms_tag(name, slug, del_flag, create_by, create_time, remark)
select 'Linux', 'linux', '0', 'admin', sysdate(), NULL
from dual where not exists (select 1 from cms_tag where slug = 'linux' or name = 'Linux');

insert into cms_tag(name, slug, del_flag, create_by, create_time, remark)
select 'Git', 'git', '0', 'admin', sysdate(), NULL
from dual where not exists (select 1 from cms_tag where slug = 'git' or name = 'Git');

insert into cms_tag(name, slug, del_flag, create_by, create_time, remark)
select 'Nginx', 'nginx', '0', 'admin', sysdate(), NULL
from dual where not exists (select 1 from cms_tag where slug = 'nginx' or name = 'Nginx');

insert into cms_tag(name, slug, del_flag, create_by, create_time, remark)
select 'JVM', 'jvm', '0', 'admin', sysdate(), NULL
from dual where not exists (select 1 from cms_tag where slug = 'jvm' or name = 'JVM');

insert into cms_tag(name, slug, del_flag, create_by, create_time, remark)
select '设计模式', 'design-pattern', '0', 'admin', sysdate(), NULL
from dual where not exists (select 1 from cms_tag where slug = 'design-pattern' or name = '设计模式');

insert into cms_tag(name, slug, del_flag, create_by, create_time, remark)
select '面试', 'interview', '0', 'admin', sysdate(), NULL
from dual where not exists (select 1 from cms_tag where slug = 'interview' or name = '面试');
