-- 言语积累：成语速记口诀 1-4，共 393 张卡（已去重）
-- 先执行 exam_v1.0.0.sql；可重复执行，同名卡不会重复插入

insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '美轮美奂', '指房屋', '美轮美奂指房屋，不胫而走是消息', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '美轮美奂' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不胫而走', '是消息', '美轮美奂指房屋，不胫而走是消息', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不胫而走' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '空谷足音', '难得讯', '空谷足音难得讯，安土重迁恋故土', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '空谷足音' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '安土重迁', '恋故土', '空谷足音难得讯，安土重迁恋故土', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '安土重迁' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不以为意', '不在意', '不以为意不在意，师出有名有理由', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不以为意' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '师出有名', '有理由', '不以为意不在意，师出有名有理由', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '师出有名' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不知所云', '指说者', '不知所云指说者，危言危行事事直', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不知所云' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '危言危行', '事事直', '不知所云指说者，危言危行事事直', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '危言危行' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '改弦更张', '制度变', '改弦更张制度变，评头品足挑毛病', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '改弦更张' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '评头品足', '挑毛病', '改弦更张制度变，评头品足挑毛病', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '评头品足' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '韦编三绝', '太刻苦', '韦编三绝太刻苦，庆父不死制动乱', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '韦编三绝' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '庆父不死', '制动乱', '韦编三绝太刻苦，庆父不死制动乱', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '庆父不死' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '倚马可待', '文思敏', '倚马可待文思敏，万人空巷真热闹', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '倚马可待' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '万人空巷', '真热闹', '倚马可待文思敏，万人空巷真热闹', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '万人空巷' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '首当其冲', '遭头炮', '首当其冲遭头炮，不名一文太贫穷', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '首当其冲' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不名一文', '太贫穷', '首当其冲遭头炮，不名一文太贫穷', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不名一文' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '以邻为壑', '嫁祸人', '以邻为壑嫁祸人，望其项背可赶上', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '以邻为壑' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '望其项背', '可赶上', '以邻为壑嫁祸人，望其项背可赶上', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '望其项背' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '感同身受', '代谢人', '感同身受代谢人，言不及义话无聊', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '感同身受' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '言不及义', '话无聊', '感同身受代谢人，言不及义话无聊', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '言不及义' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '暴虎冯河', '勇无谋', '暴虎冯河勇无谋，得意忘言相默契', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '暴虎冯河' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '得意忘言', '相默契', '暴虎冯河勇无谋，得意忘言相默契', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '得意忘言' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '步人后尘', '模仿人', '步人后尘模仿人，开门揖盗招祸患', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '步人后尘' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '开门揖盗', '招祸患', '步人后尘模仿人，开门揖盗招祸患', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '开门揖盗' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '七月流火', '天气凉', '七月流火天气凉，仰事俯畜养一家', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '七月流火' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '仰事俯畜', '养一家', '七月流火天气凉，仰事俯畜养一家', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '仰事俯畜' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '得陇望蜀', '贪无厌', '得陇望蜀贪无厌，移花接木暗更换', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '得陇望蜀' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '移花接木', '暗更换', '得陇望蜀贪无厌，移花接木暗更换', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '移花接木' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '独树一帜', '自一家；自成派', '独树一帜自一家，明火执仗是强盗 / 独树一帜自成派，自成一家有见解', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1、4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '独树一帜' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '明火执仗', '是强盗', '独树一帜自一家，明火执仗是强盗', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '明火执仗' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '鳞次栉比', '屋多齐；排列齐', '鳞次栉比屋多齐，沆瀣一气是小人 / 适得其反反效果，鳞次栉比排列齐', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1、2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '鳞次栉比' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '沆瀣一气', '是小人', '鳞次栉比屋多齐，沆瀣一气是小人', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '沆瀣一气' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '粉墨登场', '政客坏', '粉墨登场政客坏，十室九空人口少', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '粉墨登场' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '十室九空', '人口少', '粉墨登场政客坏，十室九空人口少', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '十室九空' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '噤若寒蝉', '不敢声', '噤若寒蝉不敢声，目无全牛技艺熟', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '噤若寒蝉' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '目无全牛', '技艺熟', '噤若寒蝉不敢声，目无全牛技艺熟', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '目无全牛' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '天马行空', '诗文书', '天马行空诗文书，执迷不悟不省悟', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '天马行空' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '执迷不悟', '不省悟', '天马行空诗文书，执迷不悟不省悟', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '执迷不悟' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '殚精竭虑', '要学习', '殚精竭虑要学习，苦心孤诣勤钻研', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '殚精竭虑' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '苦心孤诣', '勤钻研', '殚精竭虑要学习，苦心孤诣勤钻研', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '苦心孤诣' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '厚此薄彼', '有区别', '厚此薄彼有区别，别无长物是贫穷', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '厚此薄彼' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '别无长物', '是贫穷', '厚此薄彼有区别，别无长物是贫穷', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '别无长物' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '安之若素', '如平常', '安之若素如平常，不可名状说不出', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '安之若素' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不可名状', '说不出', '安之若素如平常，不可名状说不出', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不可名状' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '相得益彰', '是配合；互促进', '相得益彰是配合，卓尔不群超常人 / 相得益彰是配合，潜移默化悄影响 / 相得益彰互促进，相为表里互依存', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1、3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '相得益彰' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '卓尔不群', '超常人', '相得益彰是配合，卓尔不群超常人', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '卓尔不群' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '颐指气使', '态度傲', '颐指气使态度傲，改弦易辙态度变', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '颐指气使' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '改弦易辙', '态度变', '颐指气使态度傲，改弦易辙态度变', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '改弦易辙' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '泥牛入海', '不复返', '泥牛入海不复返，裹足不前有顾虑', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '泥牛入海' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '裹足不前', '有顾虑；不敢动；不敢进', '泥牛入海不复返，裹足不前有顾虑 / 事与愿违事不顺，裹足不前不敢动 / 裹足不前不敢进，举步维艰行路难', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1、2、4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '裹足不前' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '长此以往', '情况坏', '长此以往情况坏，百里挑一人出众', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '长此以往' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '百里挑一', '人出众', '长此以往情况坏，百里挑一人出众', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '百里挑一' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '隔岸观火', '只旁观', '隔岸观火只旁观，更仆难数人事多', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '隔岸观火' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '更仆难数', '人事多', '隔岸观火只旁观，更仆难数人事多', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '更仆难数' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '骨鲠在喉', '好难受', '骨鲠在喉好难受，顾影自怜人失意', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '骨鲠在喉' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '顾影自怜', '人失意', '骨鲠在喉好难受，顾影自怜人失意', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '顾影自怜' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '各司其职', '尽职责', '各司其职尽职责，管窥蠡测小见大', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '各司其职' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '管窥蠡测', '小见大', '各司其职尽职责，管窥蠡测小见大', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '管窥蠡测' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '春意阑珊', '氛围衰', '春意阑珊氛围衰，在劫难逃是灾难', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '春意阑珊' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '在劫难逃', '是灾难', '春意阑珊氛围衰，在劫难逃是灾难', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '在劫难逃' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '痛不欲生', '很悲伤', '痛不欲生很悲伤，大快朵颐享口福', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '痛不欲生' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '大快朵颐', '享口福', '痛不欲生很悲伤，大快朵颐享口福', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '大快朵颐' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '如出一辙', '是相似；是相同', '如出一辙是相似，同室操戈内部争 / 一脉相承有传承，如出一辙是相同', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1、2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '如出一辙' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '同室操戈', '内部争', '如出一辙是相似，同室操戈内部争', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '同室操戈' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '亦步亦趋', '乱模仿', '亦步亦趋乱模仿，歧路亡羊误歧途', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '亦步亦趋' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '歧路亡羊', '误歧途', '亦步亦趋乱模仿，歧路亡羊误歧途', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '歧路亡羊' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '敬谢不敏', '婉推辞', '敬谢不敏婉推辞，耸人听闻多夸大', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '敬谢不敏' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '耸人听闻', '多夸大', '敬谢不敏婉推辞，耸人听闻多夸大', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '耸人听闻' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '罄竹难书', '罪恶多', '罄竹难书罪恶多，汗牛充栋藏书多', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '罄竹难书' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '汗牛充栋', '藏书多', '罄竹难书罪恶多，汗牛充栋藏书多', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '汗牛充栋' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '釜底抽薪', '才彻底', '釜底抽薪才彻底，休戚与共同祸福', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '釜底抽薪' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '休戚与共', '同祸福', '釜底抽薪才彻底，休戚与共同祸福', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '休戚与共' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不可理喻', '太蛮横', '不可理喻太蛮横，如沐春风受教化', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不可理喻' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '如沐春风', '受教化', '不可理喻太蛮横，如沐春风受教化', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '如沐春风' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '胸无城府', '无心机', '胸无城府无心机，空穴来风有根据', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '胸无城府' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '空穴来风', '有根据', '胸无城府无心机，空穴来风有根据', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '空穴来风' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不经之谈', '无根据', '不经之谈无根据，繁文缛节真琐碎', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不经之谈' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '繁文缛节', '真琐碎', '不经之谈无根据，繁文缛节真琐碎', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '繁文缛节' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '改头换面', '是贬义', '改头换面是贬义，锱铢必较气量小', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '改头换面' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '锱铢必较', '气量小；计得失', '改头换面是贬义，锱铢必较气量小 / 严阵以待备就绪，锱铢必较计得失', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1、3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '锱铢必较' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '事倍功半', '效率低', '事倍功半效率低，方兴未艾正发展', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '事倍功半' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '方兴未艾', '正发展', '事倍功半效率低，方兴未艾正发展 / 历久弥新仍鲜活，方兴未艾正发展 / 风起云涌声势大，方兴未艾正发展', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1、4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '方兴未艾' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '跌宕起伏', '变化多', '跌宕起伏变化多，鱼目混珠假乱真', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '跌宕起伏' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '鱼目混珠', '以假乱真', '跌宕起伏变化多，鱼目混珠假乱真 / 良莠不齐有好坏，鱼目混珠以假乱真', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '鱼目混珠' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '自行其是', '自以为对', '自行其是自以为对，捉襟见肘困难多', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '自行其是' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '捉襟见肘', '困难多；穷又窘', '自行其是自以为对，捉襟见肘困难多 / 捉襟见肘穷又窘，力不从心意难成', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1、2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '捉襟见肘' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '耳濡目染', '受影响', '耳濡目染受影响，琴瑟失调是夫妻', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '耳濡目染' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '琴瑟失调', '是夫妻', '耳濡目染受影响，琴瑟失调是夫妻', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '琴瑟失调' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '潜移默化', '悄影响', '相得益彰是配合，潜移默化悄影响', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '潜移默化' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '良莠不齐', '有好坏；好坏混', '良莠不齐有好坏，鱼目混珠以假乱真 / 愈演愈烈变严重，良莠不齐好坏混', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1、3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '良莠不齐' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '历久弥新', '更鲜活；仍鲜活；价值添', '历久弥新更鲜活，一蹴而就难速成 / 历久弥新仍鲜活，方兴未艾正发展 / 生生不息不停止，历久弥新更鲜活 / 博大精深学问深，历久弥新价值添', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1、4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '历久弥新' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '一蹴而就', '难速成；快完成', '历久弥新更鲜活，一蹴而就难速成 / 轻车熟路很熟练，一蹴而就快完成', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1、3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '一蹴而就' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '浑水摸鱼', '乱获利', '浑水摸鱼乱获利，望洋兴叹没办法', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '浑水摸鱼' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '望洋兴叹', '没办法', '浑水摸鱼乱获利，望洋兴叹没办法', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '望洋兴叹' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '相辅相成', '互促进', '相辅相成互促进，妙语连珠话精彩 / 相辅相成互促进，孤注一掷赌一把', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1、2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '相辅相成' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '妙语连珠', '话精彩', '相辅相成互促进，妙语连珠话精彩', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '妙语连珠' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '语焉不详', '说不清', '语焉不详说不清，语重心长话恳切', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '语焉不详' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '语重心长', '话恳切', '语焉不详说不清，语重心长话恳切', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '语重心长' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '寅吃卯粮', '预透支', '寅吃卯粮预透支，饮鸩止渴顾眼前', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '寅吃卯粮' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '饮鸩止渴', '顾眼前', '寅吃卯粮预透支，饮鸩止渴顾眼前', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '饮鸩止渴' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '含糊其辞', '不明确', '含糊其辞不明确，革故鼎新破旧制', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '含糊其辞' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '革故鼎新', '破旧制；大变革', '含糊其辞不明确，革故鼎新破旧制 / 革故鼎新大变革，弃旧图新求改变', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1、4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '革故鼎新' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '杯水车薪', '不够用', '杯水车薪不够用，沧海一粟很渺小', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '杯水车薪' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '沧海一粟', '很渺小', '杯水车薪不够用，沧海一粟很渺小', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 1' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '沧海一粟' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '一脉相承', '有传承', '一脉相承有传承，如出一辙是相同 / 兼容并蓄能包容，一脉相承有传承', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2、4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '一脉相承' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '别无二致', '没差别', '别无二致没差别，不谋而合意相通', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '别无二致' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不谋而合', '意相通', '别无二致没差别，不谋而合意相通', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不谋而合' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '振聋发聩', '醒人心', '振聋发聩醒人心，深入人心影响深', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '振聋发聩' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '深入人心', '影响深', '振聋发聩醒人心，深入人心影响深', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '深入人心' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '高屋建瓴', '格局大', '高屋建瓴格局大，硕果累累成果丰', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '高屋建瓴' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '硕果累累', '成果丰', '高屋建瓴格局大，硕果累累成果丰', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '硕果累累' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不疾不徐', '节奏稳', '不疾不徐节奏稳，如雷贯耳名声盛', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不疾不徐' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '如雷贯耳', '名声盛', '不疾不徐节奏稳，如雷贯耳名声盛', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '如雷贯耳' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '从容不迫', '心态定', '从容不迫心态定，不绝于耳声不停', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '从容不迫' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不绝于耳', '声不停', '从容不迫心态定，不绝于耳声不停', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不绝于耳' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '四平八稳', '不冒进', '四平八稳不冒进，甚嚣尘上议论盛', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '四平八稳' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '甚嚣尘上', '议论盛', '四平八稳不冒进，甚嚣尘上议论盛', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '甚嚣尘上' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '慢条斯理', '节奏慢', '慢条斯理节奏慢，此起彼伏接连生', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '慢条斯理' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '此起彼伏', '接连生', '慢条斯理节奏慢，此起彼伏接连生', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '此起彼伏' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '力不从心', '意难成', '捉襟见肘穷又窘，力不从心意难成', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '力不从心' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '风吹草动', '有动静', '风吹草动有动静，顾此失彼难两全', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '风吹草动' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '顾此失彼', '难两全', '风吹草动有动静，顾此失彼难两全', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '顾此失彼' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '蛛丝马迹', '线索显', '蛛丝马迹线索显，乌烟瘴气环境乱', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '蛛丝马迹' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '乌烟瘴气', '环境乱', '蛛丝马迹线索显，乌烟瘴气环境乱', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '乌烟瘴气' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '泥沙俱下', '好坏混', '泥沙俱下好坏混，鱼龙混杂人难辨', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '泥沙俱下' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '鱼龙混杂', '人难辨', '泥沙俱下好坏混，鱼龙混杂人难辨', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '鱼龙混杂' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '杂乱无章', '秩序崩', '杂乱无章秩序崩，从善如流听劝言', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '杂乱无章' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '从善如流', '听劝言', '杂乱无章秩序崩，从善如流听劝言', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '从善如流' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '群策群力', '众人谋', '群策群力众人谋，集思广益汇智慧', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '群策群力' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '集思广益', '汇智慧', '群策群力众人谋，集思广益汇智慧', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '集思广益' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '广开言路', '纳谏言', '广开言路纳谏言，因势利导顺形势', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '广开言路' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '因势利导', '顺形势', '广开言路纳谏言，因势利导顺形势', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '因势利导' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '总揽全局', '掌方向', '总揽全局掌方向，穿针引线搭桥梁', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '总揽全局' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '穿针引线', '搭桥梁', '总揽全局掌方向，穿针引线搭桥梁', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '穿针引线' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '保驾护航', '保顺畅', '保驾护航保顺畅，大同小异差别小', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '保驾护航' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '大同小异', '差别小', '保驾护航保顺畅，大同小异差别小', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '大同小异' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '相去甚远', '差距大', '相去甚远差距大，千姿百态样式多', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '相去甚远' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '千姿百态', '样式多', '相去甚远差距大，千姿百态样式多', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '千姿百态' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '大相径庭', '差别大', '大相径庭差别大，守株待兔存侥幸', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '大相径庭' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '守株待兔', '存侥幸', '大相径庭差别大，守株待兔存侥幸', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '守株待兔' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '刻舟求剑', '不懂变', '刻舟求剑不懂变，敢为人先敢突破', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '刻舟求剑' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '敢为人先', '敢突破', '刻舟求剑不懂变，敢为人先敢突破', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '敢为人先' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '坐井观天', '见识浅', '坐井观天见识浅，踔厉奋发干劲足', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '坐井观天' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '踔厉奋发', '干劲足', '坐井观天见识浅，踔厉奋发干劲足', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '踔厉奋发' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '望梅止渴', '空安慰', '望梅止渴空安慰，推陈出新弃旧制', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '望梅止渴' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '推陈出新', '弃旧制；去糟粕', '望梅止渴空安慰，推陈出新弃旧制 / 推陈出新去糟粕，吐故纳新迎生机', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2、4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '推陈出新' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '画地为牢', '限自己', '画地为牢限自己，大展拳脚施才干', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '画地为牢' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '大展拳脚', '施才干', '画地为牢限自己，大展拳脚施才干', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '大展拳脚' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '照猫画虎', '机械搬', '照猫画虎机械搬，厚积薄发久积累', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '照猫画虎' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '厚积薄发', '久积累', '照猫画虎机械搬，厚积薄发久积累', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '厚积薄发' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '一哄而上', '盲目跟', '一哄而上盲目跟，谋定后动先规划', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '一哄而上' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '谋定后动', '先规划', '一哄而上盲目跟，谋定后动先规划', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '谋定后动' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '拾人牙慧', '抄别人', '拾人牙慧抄别人，有备无患先准备', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '拾人牙慧' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '有备无患', '先准备', '拾人牙慧抄别人，有备无患先准备', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '有备无患' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '随波逐流', '无主见', '随波逐流无主见，瞻前顾后顾虑多', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '随波逐流' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '瞻前顾后', '顾虑多', '随波逐流无主见，瞻前顾后顾虑多 / 瞻前顾后顾虑多，趑趄不前犹豫多', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2、4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '瞻前顾后' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '畏首畏尾', '怕犯错', '畏首畏尾怕犯错，暮气沉沉无生机', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '畏首畏尾' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '暮气沉沉', '无生机', '畏首畏尾怕犯错，暮气沉沉无生机', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '暮气沉沉' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '浑浑噩噩', '混日子', '浑浑噩噩混日子，唯唯诺诺没主见', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '浑浑噩噩' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '唯唯诺诺', '没主见', '浑浑噩噩混日子，唯唯诺诺没主见', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '唯唯诺诺' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '无所事事', '不做事', '无所事事不做事，无所作为没建树', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '无所事事' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '无所作为', '没建树', '无所事事不做事，无所作为没建树', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '无所作为' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '敷衍了事', '不认真', '敷衍了事不认真，走马观花看个过', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '敷衍了事' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '走马观花', '看个过', '敷衍了事不认真，走马观花看个过', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '走马观花' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '人云亦云', '没主见', '人云亦云没主见，挂一漏万不周全', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '人云亦云' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '挂一漏万', '不周全', '人云亦云没主见，挂一漏万不周全', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '挂一漏万' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '亡羊补牢', '能补救', '亡羊补牢能补救，曲突徙薪先预防', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '亡羊补牢' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '曲突徙薪', '先预防', '亡羊补牢能补救，曲突徙薪先预防', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '曲突徙薪' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '双管齐下', '两手抓', '双管齐下两手抓，未雨绸缪早准备', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '双管齐下' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '未雨绸缪', '早准备', '双管齐下两手抓，未雨绸缪早准备', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '未雨绸缪' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '惩前毖后', '警后人', '惩前毖后警后人，深谋远虑想长远', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '惩前毖后' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '深谋远虑', '想长远', '惩前毖后警后人，深谋远虑想长远', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '深谋远虑' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '补偏救弊', '改偏差', '补偏救弊改偏差，先发制人抢先机', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '补偏救弊' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '先发制人', '抢先机', '补偏救弊改偏差，先发制人抢先机', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '先发制人' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '取长补短', '互补充', '取长补短互补充，标本兼治内外顾', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '取长补短' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '标本兼治', '内外顾', '取长补短互补充，标本兼治内外顾', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '标本兼治' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '开源节流', '增省双', '开源节流增省双，一举两得双重效', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '开源节流' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '一举两得', '双重效', '开源节流增省双，一举两得双重效', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '一举两得' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '孤注一掷', '赌一把', '相辅相成互促进，孤注一掷赌一把', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '孤注一掷' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '避实击虚', '找弱点', '避实击虚找弱点，轻举妄动太鲁莽', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '避实击虚' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '轻举妄动', '太鲁莽', '避实击虚找弱点，轻举妄动太鲁莽', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '轻举妄动' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '以攻为守', '转被动', '以攻为守转被动，刚愎自用太固执', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '以攻为守' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '刚愎自用', '太固执', '以攻为守转被动，刚愎自用太固执', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '刚愎自用' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '攻其不备', '趁不备', '攻其不备趁不备，铤而走险冒风险', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '攻其不备' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '铤而走险', '冒风险', '攻其不备趁不备，铤而走险冒风险', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '铤而走险' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '层出不穷', '接连现', '层出不穷接连现，大浪淘沙留真金 / 危若朝露快灭亡，层出不穷接连现', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2、4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '层出不穷' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '大浪淘沙', '留真金', '层出不穷接连现，大浪淘沙留真金', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '大浪淘沙' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '精挑细选', '选得严', '精挑细选选得严，优胜劣汰适者存', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '精挑细选' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '优胜劣汰', '适者存', '精挑细选选得严，优胜劣汰适者存', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '优胜劣汰' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '千锤百炼', '经考验', '千锤百炼经考验，安于现状不思进', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '千锤百炼' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '安于现状', '不思进', '千锤百炼经考验，安于现状不思进', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '安于现状' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '分身乏术', '顾不暇', '分身乏术顾不暇，固步自封守旧规', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '分身乏术' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '固步自封', '守旧规；不进取', '分身乏术顾不暇，固步自封守旧规 / 因循守旧不改旧，固步自封不进取', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2、4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '固步自封' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '事与愿违', '事不顺', '事与愿违事不顺，裹足不前不敢动', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '事与愿违' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '措手不及', '难应付', '措手不及难应付，自暴自弃自放弃', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '措手不及' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '自暴自弃', '自放弃', '措手不及难应付，自暴自弃自放弃', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '自暴自弃' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '适得其反', '反效果', '适得其反反效果，鳞次栉比排列齐', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '适得其反' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '别具一格', '有特色', '别具一格有特色，色彩斑斓颜色多', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '别具一格' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '色彩斑斓', '颜色多', '别具一格有特色，色彩斑斓颜色多', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '色彩斑斓' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '截然不同', '差别大', '截然不同差别大，绚丽多姿色彩艳', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '截然不同' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '绚丽多姿', '色彩艳', '截然不同差别大，绚丽多姿色彩艳', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '绚丽多姿' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '各有千秋', '有长处', '各有千秋有长处，抽丝剥茧理头绪', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '各有千秋' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '抽丝剥茧', '理头绪', '各有千秋有长处，抽丝剥茧理头绪', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '抽丝剥茧' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '循序渐进', '按步骤', '循序渐进按步骤，进退维谷两难境 / 照本宣科搬条文，循序渐进按步骤', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2、4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '循序渐进' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '进退维谷', '两难境；陷困境', '循序渐进按步骤，进退维谷两难境 / 进退维谷陷困境，进退失据无主张', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2、4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '进退维谷' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '由表及里', '探本质', '由表及里探本质，得不偿失不划算', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '由表及里' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '得不偿失', '不划算', '由表及里探本质，得不偿失不划算', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 2' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '得不偿失' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '自上而下', '上层定', '自上而下上层定，左支右绌顾不暇', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '自上而下' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '左支右绌', '顾不暇', '自上而下上层定，左支右绌顾不暇', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '左支右绌' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '常备不懈', '不松懈', '常备不懈不松懈，一丝不苟很认真', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '常备不懈' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '一丝不苟', '很认真', '常备不懈不松懈，一丝不苟很认真', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '一丝不苟' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '如履薄冰', '很谨慎', '如履薄冰很谨慎，寸步不让不妥协', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '如履薄冰' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '寸步不让', '不妥协', '如履薄冰很谨慎，寸步不让不妥协', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '寸步不让' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '严阵以待', '备就绪', '严阵以待备就绪，锱铢必较计得失', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '严阵以待' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '谨小慎微', '太小心', '谨小慎微太小心，壁垒分明界限清', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '谨小慎微' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '壁垒分明', '界限清', '谨小慎微太小心，壁垒分明界限清', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '壁垒分明' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '各自为政', '不配合', '各自为政不配合，为所欲为无约束', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '各自为政' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '为所欲为', '无约束', '各自为政不配合，为所欲为无约束', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '为所欲为' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '越俎代庖', '超权限', '越俎代庖超权限，文过饰非掩过错', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '越俎代庖' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '文过饰非', '掩过错', '越俎代庖超权限，文过饰非掩过错', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '文过饰非' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '与时俱进', '跟潮流；跟步伐', '与时俱进跟潮流，矫枉过正超限度 / 标新立异想法奇，与时俱进跟步伐', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3、4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '与时俱进' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '矫枉过正', '超限度', '与时俱进跟潮流，矫枉过正超限度', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '矫枉过正' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '实事求是', '讲实际', '实事求是讲实际，避重就轻推责任', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '实事求是' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '避重就轻', '推责任', '实事求是讲实际，避重就轻推责任', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '避重就轻' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '学以致用', '重实践', '学以致用重实践，掩耳盗铃自欺人', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '学以致用' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '掩耳盗铃', '自欺人', '学以致用重实践，掩耳盗铃自欺人', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '掩耳盗铃' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '脚踏实地', '干实事', '脚踏实地干实事，责无旁贷责任在', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '脚踏实地' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '责无旁贷', '责任在', '脚踏实地干实事，责无旁贷责任在', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '责无旁贷' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '义不容辞', '应担当', '义不容辞应担当，当仁不让勇承担', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '义不容辞' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '当仁不让', '勇承担', '义不容辞应担当，当仁不让勇承担', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '当仁不让' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '分崩离析', '散架子', '分崩离析散架子，南辕北辙方向反', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '分崩离析' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '南辕北辙', '方向反', '分崩离析散架子，南辕北辙方向反', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '南辕北辙' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '和衷共济', '齐努力', '和衷共济齐努力，尾大不掉难指挥', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '和衷共济' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '尾大不掉', '难指挥', '和衷共济齐努力，尾大不掉难指挥', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '尾大不掉' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '众志成城', '齐团结', '众志成城齐团结，阳奉阴违表面顺', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '众志成城' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '阳奉阴违', '表面顺', '众志成城齐团结，阳奉阴违表面顺', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '阳奉阴违' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '同仇敌忾', '共对敌', '同仇敌忾共对敌，坐而论道空议论', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '同仇敌忾' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '坐而论道', '空议论', '同仇敌忾共对敌，坐而论道空议论', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '坐而论道' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '光说不练', '假把式', '光说不练假把式，信手拈来很轻松', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '光说不练' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '信手拈来', '很轻松', '光说不练假把式，信手拈来很轻松', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '信手拈来' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '一帆风顺', '很顺利', '一帆风顺很顺利，唾手可得易得到', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '一帆风顺' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '唾手可得', '易得到', '一帆风顺很顺利，唾手可得易得到', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '唾手可得' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '轻车熟路', '很熟练', '轻车熟路很熟练，一蹴而就快完成', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '轻车熟路' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '虚无缥缈', '不真实', '虚无缥缈不真实，海市蜃楼空幻景', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '虚无缥缈' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '海市蜃楼', '空幻景', '虚无缥缈不真实，海市蜃楼空幻景', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '海市蜃楼' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '量体裁衣', '看实际', '量体裁衣看实际，点石成金化腐朽', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '量体裁衣' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '点石成金', '化腐朽', '量体裁衣看实际，点石成金化腐朽', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '点石成金' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '有的放矢', '有目标', '有的放矢有目标，单刀直入不绕弯', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '有的放矢' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '单刀直入', '不绕弯', '有的放矢有目标，单刀直入不绕弯', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '单刀直入' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '餐风宿露', '很艰苦', '餐风宿露很艰苦，筚路蓝缕创事业', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '餐风宿露' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '筚路蓝缕', '创事业', '餐风宿露很艰苦，筚路蓝缕创事业', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '筚路蓝缕' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '栉风沐雨', '受风吹', '栉风沐雨受风吹，艰苦卓绝很艰难', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '栉风沐雨' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '艰苦卓绝', '很艰难', '栉风沐雨受风吹，艰苦卓绝很艰难', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '艰苦卓绝' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '风靡一时', '流行过', '风靡一时流行过，混为一谈分不清', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '风靡一时' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '混为一谈', '分不清', '风靡一时流行过，混为一谈分不清', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '混为一谈' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '蔚然成风', '成风气', '蔚然成风成风气，等量齐观同等看', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '蔚然成风' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '等量齐观', '同等看', '蔚然成风成风气，等量齐观同等看', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '等量齐观' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '大行其道', '流行广', '大行其道流行广，相提并论放一起', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '大行其道' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '相提并论', '放一起', '大行其道流行广，相提并论放一起', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '相提并论' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '大张旗鼓', '声势大', '大张旗鼓声势大，一概而论一刀切', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '大张旗鼓' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '一概而论', '一刀切', '大张旗鼓声势大，一概而论一刀切', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '一概而论' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '独善其身', '顾自己', '独善其身顾自己，袖手旁观不帮忙', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '独善其身' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '袖手旁观', '不帮忙', '独善其身顾自己，袖手旁观不帮忙', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '袖手旁观' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '明哲保身', '避风险', '明哲保身避风险，置身事外不参与', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '明哲保身' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '置身事外', '不参与', '明哲保身避风险，置身事外不参与', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '置身事外' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '交相辉映', '互衬托', '交相辉映互衬托，相映成趣有情趣', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '交相辉映' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '相映成趣', '有情趣', '交相辉映互衬托，相映成趣有情趣', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '相映成趣' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '相为表里', '互依存', '相得益彰互促进，相为表里互依存', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '相为表里' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '攻坚克难', '破难题', '攻坚克难破难题，持之以恒能坚持', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '攻坚克难' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '持之以恒', '能坚持', '攻坚克难破难题，持之以恒能坚持', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '持之以恒' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '叹为观止', '夸得绝', '叹为观止夸得绝，登峰造极到顶点', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '叹为观止' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '登峰造极', '到顶点', '叹为观止夸得绝，登峰造极到顶点', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '登峰造极' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '绝无仅有', '独一份', '绝无仅有独一份，史无前例从未有', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '绝无仅有' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '史无前例', '从未有', '绝无仅有独一份，史无前例从未有', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '史无前例' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '兢兢业业', '很认真', '兢兢业业很认真，克勤克俭勤又俭', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '兢兢业业' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '克勤克俭', '勤又俭', '兢兢业业很认真，克勤克俭勤又俭', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '克勤克俭' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '勤学苦练', '肯用功', '勤学苦练肯用功，夜以继日连轴转', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '勤学苦练' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '夜以继日', '连轴转', '勤学苦练肯用功，夜以继日连轴转', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '夜以继日' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '愈演愈烈', '变严重', '愈演愈烈变严重，良莠不齐好坏混', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '愈演愈烈' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '竭泽而渔', '短视利', '竭泽而渔短视利，变本加厉更严重', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '竭泽而渔' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '变本加厉', '更严重', '竭泽而渔短视利，变本加厉更严重', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '变本加厉' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '人人自危', '心不安', '人人自危心不安，难以为继难持续', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '人人自危' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '难以为继', '难持续', '人人自危心不安，难以为继难持续 / 后继无人无传人，难以为继难持续', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3、4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '难以为继' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '睹物思人', '念故人', '睹物思人念故人，鉴往知来知未来', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '睹物思人' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '鉴往知来', '知未来', '睹物思人念故人，鉴往知来知未来', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '鉴往知来' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '抚今追昔', '忆过去', '抚今追昔忆过去，慎终追远念先祖', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '抚今追昔' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '慎终追远', '念先祖', '抚今追昔忆过去，慎终追远念先祖', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '慎终追远' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '按部就班', '按步骤；按次序', '按部就班按步骤，分门别类分清楚 / 食古不化死读书，按部就班按次序', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3、4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '按部就班' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '分门别类', '分清楚', '按部就班按步骤，分门别类分清楚', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '分门别类' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '一板一眼', '守规矩', '一板一眼守规矩，中规中矩不越界', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '一板一眼' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '中规中矩', '不越界', '一板一眼守规矩，中规中矩不越界', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '中规中矩' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '追名逐利', '求名利', '追名逐利求名利，不伦不类不成样', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '追名逐利' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不伦不类', '不成样', '追名逐利求名利，不伦不类不成样', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不伦不类' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '夸大其词', '说大话', '夸大其词说大话，哗众取宠博眼球', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '夸大其词' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '哗众取宠', '博眼球', '夸大其词说大话，哗众取宠博眼球', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '哗众取宠' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '山穷水尽', '路走绝', '山穷水尽路走绝，不进则退要进步', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '山穷水尽' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不进则退', '要进步', '山穷水尽路走绝，不进则退要进步', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不进则退' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '退无可退', '没退路', '退无可退没退路，寸步难行走不动', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '退无可退' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '寸步难行', '走不动；处境难', '退无可退没退路，寸步难行走不动 / 寸步难行处境难，岌岌可危形势险', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3、4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '寸步难行' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '迎难而上', '敢挑战', '迎难而上敢挑战，绝地反击反败局', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '迎难而上' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '绝地反击', '反败局', '迎难而上敢挑战，绝地反击反败局', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '绝地反击' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '背水一战', '决胜负', '背水一战决胜负，浑然一体融一起', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '背水一战' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '浑然一体', '融一起', '背水一战决胜负，浑然一体融一起', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '浑然一体' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '水乳交融', '融一起', '水乳交融融一起，难分难解分不清', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '水乳交融' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '难分难解', '分不清', '水乳交融融一起，难分难解分不清', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '难分难解' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '如数家珍', '很熟悉', '如数家珍很熟悉，了如指掌很清楚', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '如数家珍' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '了如指掌', '很清楚', '如数家珍很熟悉，了如指掌很清楚', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '了如指掌' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '心领神会', '懂意思', '心领神会懂意思，心中有数有把握', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '心领神会' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '心中有数', '有把握', '心领神会懂意思，心中有数有把握', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '心中有数' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '一马当先', '冲在前', '一马当先冲在前，一气呵成不间断', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '一马当先' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '一气呵成', '不间断', '一马当先冲在前，一气呵成不间断', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 3' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '一气呵成' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '一鼓作气', '趁势上', '一鼓作气趁势上，一以贯之守到底', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '一鼓作气' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '一以贯之', '守到底', '一鼓作气趁势上，一以贯之守到底', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '一以贯之' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '举一反三', '类旁通', '举一反三类旁通，融会贯通融一起', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '举一反三' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '融会贯通', '融一起', '举一反三类旁通，融会贯通融一起', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '融会贯通' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '见微知著', '看细节', '见微知著看细节，引人入胜很吸引', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '见微知著' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '引人入胜', '很吸引', '见微知著看细节，引人入胜很吸引', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '引人入胜' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '此呼彼应', '互配合', '此呼彼应互配合，经久不衰长久存', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '此呼彼应' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '经久不衰', '长久存', '此呼彼应互配合，经久不衰长久存', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '经久不衰' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '生生不息', '不停止', '生生不息不停止，历久弥新更鲜活', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '生生不息' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '耳目一新', '有新意', '耳目一新有新意，百听不厌听不够', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '耳目一新' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '百听不厌', '听不够', '耳目一新有新意，百听不厌听不够', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '百听不厌' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '脍炙人口', '人人夸', '脍炙人口人人夸，耳熟能详听得多', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '脍炙人口' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '耳熟能详', '听得多', '脍炙人口人人夸，耳熟能详听得多', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '耳熟能详' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '喜闻乐见', '受欢迎', '喜闻乐见受欢迎，错落有致有层次', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '喜闻乐见' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '错落有致', '有层次', '喜闻乐见受欢迎，错落有致有层次', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '错落有致' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '浑然天成', '自然成', '浑然天成自然成，兼容并蓄能包容', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '浑然天成' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '兼容并蓄', '能包容', '浑然天成自然成，兼容并蓄能包容 / 兼容并蓄能包容，一脉相承有传承', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '兼容并蓄' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不可扭转', '难改变', '不可扭转难改变，不可阻挡势难挡', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不可扭转' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不可阻挡', '势难挡', '不可扭转难改变，不可阻挡势难挡', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不可阻挡' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不可逆转', '难回头', '不可逆转难回头，不可颠覆难推翻', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不可逆转' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不可颠覆', '难推翻', '不可逆转难回头，不可颠覆难推翻', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不可颠覆' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '驾轻就熟', '很熟练', '驾轻就熟很熟练，天公地道很公道', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '驾轻就熟' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '天公地道', '很公道', '驾轻就熟很熟练，天公地道很公道', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '天公地道' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '一应俱全', '样样有', '一应俱全样样有，应有尽有都齐全', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '一应俱全' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '应有尽有', '都齐全', '一应俱全样样有，应有尽有都齐全', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '应有尽有' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '无所不包', '范围广', '无所不包范围广，包罗万象内容全', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '无所不包' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '包罗万象', '内容全', '无所不包范围广，包罗万象内容全', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '包罗万象' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '毋庸置喙', '别插嘴', '毋庸置喙别插嘴，不容小觑别小看', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '毋庸置喙' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不容小觑', '别小看', '毋庸置喙别插嘴，不容小觑别小看', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不容小觑' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '举足轻重', '很重要', '举足轻重很重要，兹事体大影响深', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '举足轻重' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '兹事体大', '影响深', '举足轻重很重要，兹事体大影响深', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '兹事体大' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '源远流长', '历史久', '源远流长历史久，连绵不绝不间断', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '源远流长' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '连绵不绝', '不间断', '源远流长历史久，连绵不绝不间断', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '连绵不绝' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '博大精深', '学问深', '博大精深学问深，历久弥新价值添', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '博大精深' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '血脉相通', '关系近', '血脉相通关系近，薪火相传续文明', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '血脉相通' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '薪火相传', '续文明', '血脉相通关系近，薪火相传续文明', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '薪火相传' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不绝如缕', '情势危', '不绝如缕情势危，陈陈相因守旧规', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不绝如缕' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '陈陈相因', '守旧规', '不绝如缕情势危，陈陈相因守旧规', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '陈陈相因' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '口耳相传', '靠言说', '口耳相传靠言说，衣钵相传承技艺', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '口耳相传' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '衣钵相传', '承技艺', '口耳相传靠言说，衣钵相传承技艺', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '衣钵相传' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '后继无人', '无传人', '后继无人无传人，难以为继难持续', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '后继无人' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '继往开来', '开新局', '继往开来开新局，承上启下接文意', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '继往开来' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '承上启下', '接文意', '继往开来开新局，承上启下接文意', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '承上启下' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '吐故纳新', '迎生机', '推陈出新去糟粕，吐故纳新迎生机', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '吐故纳新' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '弃旧图新', '求改变', '革故鼎新大变革，弃旧图新求改变', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '弃旧图新' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '去芜存菁', '留精华', '去芜存菁留精华，除旧布新除旧弊', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '去芜存菁' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '除旧布新', '除旧弊', '去芜存菁留精华，除旧布新除旧弊', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '除旧布新' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '激浊扬清', '正风气', '激浊扬清正风气，另辟蹊径找新路', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '激浊扬清' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '另辟蹊径', '找新路', '激浊扬清正风气，另辟蹊径找新路', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '另辟蹊径' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '标新立异', '想法奇', '标新立异想法奇，与时俱进跟步伐', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '标新立异' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '剑走偏锋', '出奇招', '剑走偏锋出奇招，不拘一格破常规', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '剑走偏锋' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不拘一格', '破常规', '剑走偏锋出奇招，不拘一格破常规', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不拘一格' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '匠心独运', '构思巧', '匠心独运构思巧，别出心裁想法妙', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '匠心独运' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '别出心裁', '想法妙', '匠心独运构思巧，别出心裁想法妙', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '别出心裁' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '自成一家', '有见解', '独树一帜自成派，自成一家有见解', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '自成一家' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '别开生面', '开新局', '别开生面开新局，不落窠臼不随俗', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '别开生面' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '不落窠臼', '不随俗', '别开生面开新局，不落窠臼不随俗', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '不落窠臼' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '墨守成规', '守旧法', '墨守成规守旧法，抱残守缺守旧物', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '墨守成规' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '抱残守缺', '守旧物', '墨守成规守旧法，抱残守缺守旧物', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '抱残守缺' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '因循守旧', '不改旧', '因循守旧不改旧，固步自封不进取', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '因循守旧' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '食古不化', '死读书', '食古不化死读书，按部就班按次序', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '食古不化' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '循规蹈矩', '守规矩', '循规蹈矩守规矩，循规拘礼太死板', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '循规蹈矩' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '循规拘礼', '太死板', '循规蹈矩守规矩，循规拘礼太死板', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '循规拘礼' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '照本宣科', '搬条文', '照本宣科搬条文，循序渐进按步骤', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '照本宣科' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '有条不紊', '有条理', '有条不紊有条理，望而生畏心害怕', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '有条不紊' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '望而生畏', '心害怕', '有条不紊有条理，望而生畏心害怕', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '望而生畏' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '望而却步', '退回去', '望而却步退回去，畏葸不前不敢前', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '望而却步' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '畏葸不前', '不敢前', '望而却步退回去，畏葸不前不敢前', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '畏葸不前' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '进退两难', '难抉择', '进退两难难抉择，骑虎难下难停止', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '进退两难' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '骑虎难下', '难停止', '进退两难难抉择，骑虎难下难停止', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '骑虎难下' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '进退失据', '无主张', '进退维谷陷困境，进退失据无主张', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '进退失据' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '趑趄不前', '犹豫多', '瞻前顾后顾虑多，趑趄不前犹豫多', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '趑趄不前' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '举步维艰', '行路难', '裹足不前不敢进，举步维艰行路难', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '举步维艰' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '岌岌可危', '形势险', '寸步难行处境难，岌岌可危形势险', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '岌岌可危' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '危如累卵', '极危险', '危如累卵极危险，命悬一线存危急', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '危如累卵' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '命悬一线', '存危急', '危如累卵极危险，命悬一线存危急', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '命悬一线' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '风雨飘摇', '局势乱', '风雨飘摇局势乱，危在旦夕时不多', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '风雨飘摇' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '危在旦夕', '时不多', '风雨飘摇局势乱，危在旦夕时不多', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '危在旦夕' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '危若朝露', '快灭亡', '危若朝露快灭亡，层出不穷接连现', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '危若朝露' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '风起云涌', '声势大', '风起云涌声势大，方兴未艾正发展', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '风起云涌' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '雨后春笋', '数量多', '雨后春笋数量多，横空出世不一般', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '雨后春笋' and c.del_flag = '0');
insert into exam_verbal_card (owner_user_id, card_type, prompt, difference, own_sentence, interval_days, due_date, review_count, del_flag, create_by, create_time, remark)
select u.user_id, '0', '横空出世', '不一般', '雨后春笋数量多，横空出世不一般', 0, curdate(), 0, '0', 'admin', sysdate(), '成语速记口诀 4' from sys_user u
where u.user_name = 'admin' and not exists (select 1 from exam_verbal_card c where c.owner_user_id = u.user_id and c.prompt = '横空出世' and c.del_flag = '0');
