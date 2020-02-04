select * from public.user_table;
select * from dw.user_pvp_1012 limit 1;
select * from dw.user_order_1012 limit 1;
select * from dw.user_session_1012 limit 1;
select * from dw.vir_money_logs_1012 where log_type = 2 limit 1;
select * from dw.user_daily_1012 limit 1;
select * from dw.user_login_logs_1012 limit 1;
select * from dw.product_logs_1012 limit 1;
#
select * from pvp;
select user_id from player where pay>0;
#
select (select * from (select * from pvp) t1 
left join (select user_id from player  where pay>0) t2 
on t1.user_id=t2.user_id where t2.user_id not null)

#付费玩家pvp情况
select sum(pvp_atk_times),sum(pvp_atk_win_times),sum(t1_wounded),sum(t2_wounded),sum(t3_wounded),sum(t4_w
ounded),sum(t5_wounded),sum(def_t1_wounded),sum(def_t2_wounded),sum(def_t3_wounded),sum(def_t4_wounded),sum(def_t5_wound
ed),sum(t1_killed),sum(t2_killed),sum(t3_killed),sum(t4_killed),sum(t5_killed),sum(def_t1_killed),sum(def_t2_killed),sum
(def_t3_killed),sum(def_t4_killed),sum(def_t5_killed),created_date from  
(select pvp_atk.user_id,pvp_atk.server_id,total_payed,pvp_atk_times,pvp_atk_win_times,t1_wounded,
t2_wounded,t3_wounded,t4_wounded,t5_wounded,def_t1_wounded,def_t2_wounded,def_t3_wounded,def_t4_wounded,
def_t5_wounded,t1_killed,t2_killed,t3_killed,t4_killed,t5_killed,def_t1_killed,def_t2_
killed,def_t3_killed,def_t4_killed,def_t5_killed,created_date from 
 (select user_id,sum(price) as total_payed,server_id
from dw.user_order_1012 where server_id in ('1004302','1003702','1004002','1004402','1004602','1004802','1004702','10041
02','1003802','1004202','1004502','1003502','1003402','1005102','1004902','1005002','1003602','1003902','1003302','10032
02') and created_date > '2017-1-1' group by user_id,server_id) as month_payed 
 right join  (select
user_id,server_id,count(user_id) as pvp_atk_times,sum(atk_win) as pvp_atk_win_times,created_date,sum(atk_t1_wounded) as
t1_wounded,sum(atk_t2_wounded) as t2_wounded,sum(atk_t3_wounded) as t3_wounded,sum(atk_t4_wounded) as
t4_wounded,sum(atk_t5_wounded) as t5_wounded,sum(def_t1_wounded) as def_t1_wounded,sum(def_t2_wounded) as
def_t2_wounded,sum(def_t3_wounded) as def_t3_wounded,sum(def_t4_wounded) as def_t4_wounded,sum(def_t5_wounded) as
def_t5_wounded,sum(atk_t1_killed) as t1_killed,sum(atk_t2_killed) as t2_killed,sum(atk_t3_killed) as
t3_killed,sum(atk_t4_killed) as t4_killed,sum(atk_t5_killed) as t5_killed,sum(def_t1_killed) as
def_t1_killed,sum(def_t2_killed) as def_t2_killed,sum(def_t3_killed) as def_t3_killed,sum(def_t4_killed) as
def_t4_killed,sum(def_t5_killed) as def_t5_killed from dw.user_pvp_1012 where server_id in ('1004302','1003702','1004002
','1004402','1004602','1004802','1004702','1004102','1003802','1004202','1004502','1003502','1003402','1005102','1004902
','1005002','1003602','1003902','1003302','1003202') and created_date > '2017-3-1' group by
user_id,server_id,created_date) as pvp_atk on month_payed.user_id = pvp_atk.user_id) payed_pvp_atk where total_payed > 0
group by created_date;

#所有玩家pvp情况
select sum(pvp_atk_times),sum(pvp_atk_win_times),sum(t1_wounded),sum(t2_wounded),sum(t3_wounded),sum(t4_wounded),sum(t5_wounded),sum(def_t1_wounded),sum(def_t2_wounded),sum(def_t3_wounded),sum(def_t4_wounded),sum(def_t5_wounded),sum(t1_killed),sum(t2_killed),sum(t3_killed),sum(t4_killed),sum(t5_killed),sum(def_t1_killed),sum(def_t2_killed),sum(def_t3_killed),sum(def_t4_killed),sum(def_t5_killed),created_date from (select user_id,server_id,pvp_atk_times,pvp_atk_win_times,t1_wounded,t2_wounded,t3_wounded,t4_wounded,t5_wounded,def_t1_wounded,def_t2_wounded,def_t3_wounded,def_t4_wounded,def_t5_wounded,t1_killed,t2_killed,t3_killed,t4_killed,t5_killed,def_t1_killed,def_t2_killed,def_t3_killed,def_t4_killed,def_t5_killed,created_date from  
(select user_id,server_id,count(user_id) as pvp_atk_times,sum(atk_win) as pvp_atk_win_times,created_date,sum(atk_t1_wounded) as t1_wounded,sum(atk_t2_wounded) as t2_wounded,sum(atk_t3_wounded) as t3_wounded,sum(atk_t4_wounded) as t4_wounded,sum(atk_t5_wounded) as t5_wounded,sum(def_t1_wounded) as def_t1_wounded,sum(def_t2_wounded) as def_t2_wounded,sum(def_t3_wounded) as def_t3_wounded,sum(def_t4_wounded) as def_t4_wounded,sum(def_t5_wounded) as def_t5_wounded,sum(atk_t1_killed) as t1_killed,sum(atk_t2_killed) as t2_killed,sum(atk_t3_killed) as t3_killed,sum(atk_t4_killed) as t4_killed,sum(atk_t5_killed) as t5_killed,sum(def_t1_killed) as def_t1_killed,sum(def_t2_killed) as def_t2_killed,sum(def_t3_killed) as def_t3_killed,sum(def_t4_killed) as def_t4_killed,sum(def_t5_killed) as def_t5_killed from dw.user_pvp_1012 where server_id in ('1000502','1001502','1001002','1000602','1001102','1001702','1000702','1000302','1001202','1002002','1002102','1002802','1002202','1001902','1002302','1002602','1002402','1000902','1002502','1000402','1001802','1003002','1002902','1002702','1003102','1001602') and created_date > '2017-3-1' group by user_id,server_id,created_date))as pvp_atk group by created_date;

#付费数据
select user_id,sum(price) as total_payed,server_id from dw.user_order_1012 where server_id in ('1004302','1003702','1004002','1004402','1004602','1004802','1004702','1004102','1003802','1004202','1004502','1003502','1003402','1005102','1004902','1005002','1003602','1003902','1003302','1003202') and created_date > '2017-1-29' group by user_id,server_id;

#登录数据
select count(distinct user_id),date(created_at),server_id from dw.user_daily_1012 where server_id in ('4','1000102','1000302','1000402','1000502','1000602','1000702','1000902','1001002','1001102','1001202','1001302','1001402','1001502','1001602','1001702','1001802','1001902','1002002','1002102','1002202','1002302','1002402','1002502','1002602','1002702','1002802','1002902','1003002','1003102','1003202','1003302','1003402','1003502','1003602','1003702','1003802','1003902','1004002','1004102','1004202','1004302','1004402','1004502','1004602','1004702','1004802','1004902','1005002','1005102') and created_date = '2017-04-14' group by date(created_at),server_id;

#zvz分组数据;
select sum(power),sum(t1),sum(t2),sum(t3),sum(t4),sum(t5),sum(research_t2),sum(research_t3),sum(research_t4),sum(research_t5),sum(iap_total) from (select a.user_id,user_name,server_id,power,iap_total,t1,t2,t3,t4,t5,research_t2,research_t3,research_t4,research_t5 from 
(select user_id,created_date,user_name,server_id,power,iap_total,(coalesce(troop_normal_infantry_tier_1,0)+coalesce(troop_normal_cavalry_tier_1,0)+coalesce(troop_normal_shaman_tier_1,0)) as t1,(coalesce(troop_normal_infantry_tier_2,0)+coalesce(troop_normal_cavalry_tier_2,0)+coalesce(troop_normal_shaman_tier_2,0)) as t2,(coalesce(troop_normal_infantry_tier_3,0)+coalesce(troop_normal_cavalry_tier_3,0)+coalesce(troop_normal_shaman_tier_3,0)) as t3,(coalesce(troop_normal_infantry_tier_4,0)+coalesce(troop_normal_cavalry_tier_4,0)+coalesce(troop_normal_shaman_tier_4,0)) as t4,(coalesce(troop_normal_infantry_tier_5,0)+coalesce(troop_normal_cavalry_tier_5,0)+coalesce(troop_normal_shaman_tier_5,0)) as t5,(coalesce(research_infantry_tier_2,0)+coalesce(research_cavalry_tier_2,0)+coalesce(research_shaman_tier_2,0))/1 as research_t2,(coalesce(research_infantry_tier_3,0)+coalesce(research_cavalry_tier_3,0)+coalesce(research_shaman_tier_3,0))/1 as research_t3,(coalesce(research_infantry_tier_4,0)+coalesce(research_cavalry_tier_4,0)+coalesce(research_shaman_tier_4,0))/1 as research_t4,(coalesce(research_infantry_tier_5,0)+coalesce(research_cavalry_tier_5,0)+coalesce(research_shaman_tier_5,0))/1 as research_t5 from dw.user_daily_1012) a,(select user_id,max(created_date) as created_date from dw.user_daily_1012 group by user_id) b where a.user_id = b.user_id and a.created_date = b.created_date and b.created_date > '2017-04-26' and server_id = '1006102' order by power desc limit 20) c;

#立即训练士兵、立即治疗伤兵、OP熄火宝石消耗;
select date(created_at),sum(vm_num) from dw.vir_money_logs_1012 where log_type = 2 and vm_type = 17 and channel in ('51106001','51506001','51606001') and server_id in ('1000502','1001502','1001002','1000602','1001102','1001702','1000702','1000302','1001202','1002002','1002102','1002802','1002202','1001902','1002302','1002602','1002402','1000902','1002502','1000402','1001802','1003002','1002902','1002702','1003102','1001602') group by date(created_at) having date(created_at) > '2017-04-01';

#总宝石消耗;
select date(created_at),sum(vm_num) from dw.vir_money_logs_1012 where log_type = 2 and vm_type = 17 and server_id in ('1000502','1001502','1001002','1000602','1001102','1001702','1000702','1000302','1001202','1002002','1002102','1002802','1002202','1001902','1002302','1002602','1002402','1000902','1002502','1000402','1001802','1003002','1002902','1002702','1003102','1001602') group by date(created_at) having date(created_at) > '2017-04-01';

服务器power前50玩家平均兵力情况；
select server_id,avg(power),avg(t1),avg(t2),avg(t3),avg(t4),avg(t5),avg(research_t2),avg(research_t3),avg(research_t4),avg(research_t5),avg(iap_total) from
(
select a.user_id,user_name,server_id,power,iap_total,t1,t2,t3,t4,t5,research_t2,research_t3,research_t4,research_t5 from 
(select user_id,created_date,user_name,server_id,power,iap_total,(coalesce(troop_normal_infantry_tier_1,0)+coalesce(troop_normal_cavalry_tier_1,0)+coalesce(troop_normal_shaman_tier_1,0)) as t1,(coalesce(troop_normal_infantry_tier_2,0)+coalesce(troop_normal_cavalry_tier_2,0)+coalesce(troop_normal_shaman_tier_2,0)) as t2,(coalesce(troop_normal_infantry_tier_3,0)+coalesce(troop_normal_cavalry_tier_3,0)+coalesce(troop_normal_shaman_tier_3,0)) as t3,(coalesce(troop_normal_infantry_tier_4,0)+coalesce(troop_normal_cavalry_tier_4,0)+coalesce(troop_normal_shaman_tier_4,0)) as t4,(coalesce(troop_normal_infantry_tier_5,0)+coalesce(troop_normal_cavalry_tier_5,0)+coalesce(troop_normal_shaman_tier_5,0)) as t5,(coalesce(research_infantry_tier_2,0)+coalesce(research_cavalry_tier_2,0)+coalesce(research_shaman_tier_2,0))/1 as research_t2,(coalesce(research_infantry_tier_3,0)+coalesce(research_cavalry_tier_3,0)+coalesce(research_shaman_tier_3,0))/1 as research_t3,(coalesce(research_infantry_tier_4,0)+coalesce(research_cavalry_tier_4,0)+coalesce(research_shaman_tier_4,0))/1 as research_t4,(coalesce(research_infantry_tier_5,0)+coalesce(research_cavalry_tier_5,0)+coalesce(research_shaman_tier_5,0))/1 as research_t5 from dw.user_daily_1012) a,
(select user_id,max(created_date) as created_date from dw.user_daily_1012 group by user_id) b
where a.user_id = b.user_id and a.created_date = b.created_date and b.created_date > '2017-05-03' and server_id in ('1000602') order by power desc limit 50) c group by server_id order by server_id::int;

#服务器活跃玩家中power中位玩家的兵力情况;
SELECT user_id,user_name,server_id,power,iap_total,t1,t2,t3,t4,t5,research_t2,research_t3,research_t4,research_t5,x.Rank FROM 
(SELECT c1.user_id,c1.user_name,c1.server_id,c1.power,c1.iap_total,c1.t1,c1.t2,c1.t3,c1.t4,c1.t5,c1.research_t2,c1.research_t3,c1.research_t4,c1.research_t5,COUNT(c1.power) Rank 
FROM (select a.user_id,user_name,server_id,power,iap_total,t1,t2,t3,t4,t5,research_t2,research_t3,research_t4,research_t5 from 
(select user_id,created_date,user_name,server_id,power,iap_total,(coalesce(troop_normal_infantry_tier_1,0)+coalesce(troop_normal_cavalry_tier_1,0)+coalesce(troop_normal_shaman_tier_1,0)) as t1,(coalesce(troop_normal_infantry_tier_2,0)+coalesce(troop_normal_cavalry_tier_2,0)+coalesce(troop_normal_shaman_tier_2,0)) as t2,(coalesce(troop_normal_infantry_tier_3,0)+coalesce(troop_normal_cavalry_tier_3,0)+coalesce(troop_normal_shaman_tier_3,0)) as t3,(coalesce(troop_normal_infantry_tier_4,0)+coalesce(troop_normal_cavalry_tier_4,0)+coalesce(troop_normal_shaman_tier_4,0)) as t4,(coalesce(troop_normal_infantry_tier_5,0)+coalesce(troop_normal_cavalry_tier_5,0)+coalesce(troop_normal_shaman_tier_5,0)) as t5,(coalesce(research_infantry_tier_2,0)+coalesce(research_cavalry_tier_2,0)+coalesce(research_shaman_tier_2,0))/1 as research_t2,(coalesce(research_infantry_tier_3,0)+coalesce(research_cavalry_tier_3,0)+coalesce(research_shaman_tier_3,0))/1 as research_t3,(coalesce(research_infantry_tier_4,0)+coalesce(research_cavalry_tier_4,0)+coalesce(research_shaman_tier_4,0))/1 as research_t4,(coalesce(research_infantry_tier_5,0)+coalesce(research_cavalry_tier_5,0)+coalesce(research_shaman_tier_5,0))/1 as research_t5 from dw.user_daily_1012) a,
(select user_id,max(created_date) as created_date from dw.user_daily_1012 group by user_id) b
where a.user_id = b.user_id and a.created_date = b.created_date and b.created_date > '2017-05-03' and server_id in ('1000602')) c1, (select a.user_id,user_name,server_id,power,iap_total,t1,t2,t3,t4,t5,research_t2,research_t3,research_t4,research_t5 from 
(select user_id,created_date,user_name,server_id,power,iap_total,(coalesce(troop_normal_infantry_tier_1,0)+coalesce(troop_normal_cavalry_tier_1,0)+coalesce(troop_normal_shaman_tier_1,0)) as t1,(coalesce(troop_normal_infantry_tier_2,0)+coalesce(troop_normal_cavalry_tier_2,0)+coalesce(troop_normal_shaman_tier_2,0)) as t2,(coalesce(troop_normal_infantry_tier_3,0)+coalesce(troop_normal_cavalry_tier_3,0)+coalesce(troop_normal_shaman_tier_3,0)) as t3,(coalesce(troop_normal_infantry_tier_4,0)+coalesce(troop_normal_cavalry_tier_4,0)+coalesce(troop_normal_shaman_tier_4,0)) as t4,(coalesce(troop_normal_infantry_tier_5,0)+coalesce(troop_normal_cavalry_tier_5,0)+coalesce(troop_normal_shaman_tier_5,0)) as t5,(coalesce(research_infantry_tier_2,0)+coalesce(research_cavalry_tier_2,0)+coalesce(research_shaman_tier_2,0))/1 as research_t2,(coalesce(research_infantry_tier_3,0)+coalesce(research_cavalry_tier_3,0)+coalesce(research_shaman_tier_3,0))/1 as research_t3,(coalesce(research_infantry_tier_4,0)+coalesce(research_cavalry_tier_4,0)+coalesce(research_shaman_tier_4,0))/1 as research_t4,(coalesce(research_infantry_tier_5,0)+coalesce(research_cavalry_tier_5,0)+coalesce(research_shaman_tier_5,0))/1 as research_t5 from dw.user_daily_1012) a,
(select user_id,max(created_date) as created_date from dw.user_daily_1012 group by user_id) b
where a.user_id = b.user_id and a.created_date = b.created_date and b.created_date > '2017-05-03' and server_id in ('1000602')) c2 
WHERE c1.power < c2.power OR (c1.power=c2.power AND c1.user_id <= c2.user_id) 
GROUP BY c1.user_id,c1.user_id,c1.user_name,c1.server_id,c1.power,c1.iap_total,c1.t1,c1.t2,c1.t3,c1.t4,c1.t5,c1.research_t2,c1.research_t3,c1.research_t4,c1.research_t5 
ORDER BY c1.power desc) x,(SELECT ((COUNT(*)+1)/2) as rank FROM (select a.user_id,user_name,server_id,power,iap_total,t1,t2,t3,t4,t5,research_t2,research_t3,research_t4,research_t5 from 
(select user_id,created_date,user_name,server_id,power,iap_total,(coalesce(troop_normal_infantry_tier_1,0)+coalesce(troop_normal_cavalry_tier_1,0)+coalesce(troop_normal_shaman_tier_1,0)) as t1,(coalesce(troop_normal_infantry_tier_2,0)+coalesce(troop_normal_cavalry_tier_2,0)+coalesce(troop_normal_shaman_tier_2,0)) as t2,(coalesce(troop_normal_infantry_tier_3,0)+coalesce(troop_normal_cavalry_tier_3,0)+coalesce(troop_normal_shaman_tier_3,0)) as t3,(coalesce(troop_normal_infantry_tier_4,0)+coalesce(troop_normal_cavalry_tier_4,0)+coalesce(troop_normal_shaman_tier_4,0)) as t4,(coalesce(troop_normal_infantry_tier_5,0)+coalesce(troop_normal_cavalry_tier_5,0)+coalesce(troop_normal_shaman_tier_5,0)) as t5,(coalesce(research_infantry_tier_2,0)+coalesce(research_cavalry_tier_2,0)+coalesce(research_shaman_tier_2,0))/1 as research_t2,(coalesce(research_infantry_tier_3,0)+coalesce(research_cavalry_tier_3,0)+coalesce(research_shaman_tier_3,0))/1 as research_t3,(coalesce(research_infantry_tier_4,0)+coalesce(research_cavalry_tier_4,0)+coalesce(research_shaman_tier_4,0))/1 as research_t4,(coalesce(research_infantry_tier_5,0)+coalesce(research_cavalry_tier_5,0)+coalesce(research_shaman_tier_5,0))/1 as research_t5 from dw.user_daily_1012) a,
(select user_id,max(created_date) as created_date from dw.user_daily_1012 group by user_id) b
where a.user_id = b.user_id and a.created_date = b.created_date and b.created_date > '2017-05-03' and server_id in ('1000602')) c) y
WHERE x.rank = y.rank;

#服务器pwoer中位数;
select server_id,avg(power) from
(select e.server_id, e.power from (select a.user_id,user_name,server_id,power from 
(select user_id,created_date,user_name,server_id,power from dw.user_daily_1012) a,
(select user_id,max(created_date) as created_date from dw.user_daily_1012 group by user_id) b
where a.user_id = b.user_id and a.created_date = b.created_date and b.created_date > '2017-05-03' and server_id in ('1000602')) e, (select a.user_id,user_name,server_id,power from 
(select user_id,created_date,user_name,server_id,power from dw.user_daily_1012) a,
(select user_id,max(created_date) as created_date from dw.user_daily_1012 group by user_id) b
where a.user_id = b.user_id and a.created_date = b.created_date and b.created_date > '2017-05-03' and server_id in ('1000602')) d where e.server_id = d.server_id group by e.server_id, e.power having sum(case when e.power = d.power then 1 else 0 end)>= abs(sum(sign(e.power - d.power))))t group by server_id;

服务器pwoer平均数;
select server_id,avg(power) from
(
select a.user_id,user_name,server_id,power from 
(select user_id,created_date,user_name,server_id,power from dw.user_daily_1012) a,
(select user_id,max(created_date) as created_date from dw.user_daily_1012 group by user_id) b
where a.user_id = b.user_id and a.created_date = b.created_date and b.created_date > '2017-05-03' and server_id in ('1000602')) c group by server_id order by server_id::int;


#在某服付费的所有玩家信息；
SELECT open_udid, user_id, sum(price) as total_payed from  dw.user_order_1012 where  created_date between '2017-04-01' and '2017-04-08' and server_id in ('1006902') GROUP BY user_id, open_udid; 
##在69服之前付费玩家的设备信息；
SELECT open_udid, user_id, sum(price) as total_payed from dw.user_order_1012 where server_id in ('4','1000102','1000302','1000402','1000502','1000602','1000702','1000902','1001002','1001102','1001202','1001302','1001402','1001502','1001602','1001702','1001802','1001902','1002002','1002102','1002202','1002302','1002402','1002502','1002602','1002702','1002802','1002902','1003002','1003102','1003202','1003302','1003402','1003502','1003602','1003702','1003802','1003902','1004002','1004102','1004202','1004302','1004402','1004502','1004602','1004702','1004802','1004902','1005002','1005102','1005202','1005302','1005402','1005502','1005602','1005702','1005802','1005902','1006002','1006102','1006202','1006302','1006402','1006502','1006602','1006702','1006802') and created_date between '2017-04-01' and '2017-04-08' GROUP BY user_id, open_udid; 

##在某服付费的所有玩家信息；
SELECT open_udid, user_id, sum(price) as total_payed from  dw.user_order_1012 where  created_date between '2017-04-01' and '2017-04-08' and server_id in ('1006902') GROUP BY user_id, open_udid; 

##在某服之前付费玩家的设备信息；
SELECT open_udid, user_id, sum(price) as total_payed from dw.user_order_1012 where server_id in ('4','1000102','1000302','1000402','1000502','1000602','1000702','1000902','1001002','1001102','1001202','1001302','1001402','1001502','1001602','1001702','1001802','1001902','1002002','1002102','1002202','1002302','1002402','1002502','1002602','1002702','1002802','1002902','1003002','1003102','1003202','1003302','1003402','1003502','1003602','1003702','1003802','1003902','1004002','1004102','1004202','1004302','1004402','1004502','1004602','1004702','1004802','1004902','1005002','1005102','1005202','1005302','1005402','1005502','1005602','1005702','1005802','1005902','1006002','1006102','1006202','1006302','1006402','1006502','1006602','1006702','1006802') and created_date between '2017-04-01' and '2017-04-08' GROUP BY user_id, open_udid; 

#合并两表
Select open_udid INTO TABLE_3  from  (select open_udid from TABLE_1 UNION ALL SELECT open_udid from TABLE_2) 
SELECT

SELECT TABLE_1.open_udid,TABLE_1.total_payed from
(SELECT open_udid, user_id, sum(price) as total_payed from  dw.user_order_1012 where  created_date between '2017-04-01' and '2017-04-08' and server_id in ('1006902') GROUP BY user_id, open_udid ）as TABLE_1,
(SELECT open_udid, count(distinct user_id) from dw.user_daily_1012 where server_id in ('4','1000102','1000302','1000402','1000502','1000602','1000702','1000902','1001002','1001102','1001202','1001302','1001402','1001502','1001602','1001702','1001802','1001902','1002002','1002102','1002202','1002302','1002402','1002502','1002602','1002702','1002802','1002902','1003002','1003102','1003202','1003302','1003402','1003502','1003602','1003702','1003802','1003902','1004002','1004102','1004202','1004302','1004402','1004502','1004602','1004702','1004802','1004902','1005002','1005102','1005202','1005302','1005402','1005502','1005602','1005702','1005802','1005902','1006002','1006102','1006202','1006302','1006402','1006502','1006602','1006702','1006802','1006902') GROUP BY open_udid having count(distinct user_id) > 1) as TABLE_2
where TABLE_1.open_udid = TABLE_2.open_udid;


#正确
SELECT TABLE_1.open_udid,TABLE_1.total_payed from (SELECT open_udid, user_id, sum(price) as total_payed from  dw.user_order_1012 where  created_date between '2017-04-01' and '2017-04-08' and server_id in ('1006902') GROUP BY user_id, open_udid) TABLE_1,(SELECT open_udid, count(distinct user_id) from dw.user_daily_1012 where server_id in ('4','1000102','1000302','1000402','1000502','1000602','1000702','1000902','1001002','1001102','1001202','1001302','1001402','1001502','1001602','1001702','1001802','1001902','1002002','1002102','1002202','1002302','1002402','1002502','1002602','1002702','1002802','1002902','1003002','1003102','1003202','1003302','1003402','1003502','1003602','1003702','1003802','1003902','1004002','1004102','1004202','1004302','1004402','1004502','1004602','1004702','1004802','1004902','1005002','1005102','1005202','1005302','1005402','1005502','1005602','1005702','1005802','1005902','1006002','1006102','1006202','1006302','1006402','1006502','1006602','1006702','1006802','1006902') GROUP BY open_udid having count(distinct user_id) > 1) TABLE_2 where TABLE_1.open_udid = TABLE_2.open_udid;

#
select TABLE_1.user_id, TABLE_1.iap_show, TABLE_2.research_t2,TABLE_2.research_t3,TABLE_2.research_t4,TABLE_2.research_t5 from
(SELECT user_id, server_id, date(created_date),iap_show FROM dw.user_order_1012 WHERE server_id in ('1006902','1007002','1007102','1007202','1007302','1007402','1007502','1007602','1007702','1007802','1007902','1008002','1008102','1008202','1008302','1008402','1008502','1008602','1008702','1008802') and created_date > '2017-04-01'and iap_show between 0.00001 and 100 GROUP BY created_date, user_id, server_id, iap_show) TABLE_1,(SELECT a.user_id,a.server_id,a.created_date,research_t2,research_t3,research_t4,research_t5 FROM (SELECT user_id, server_id, created_date,(coalesce(research_cavalry_tier_2,0)+coalesce(research_infantry_tier_2,0)
+coalesce(research_shaman_tier_2,0)) as research_t2,
(coalesce(research_cavalry_tier_3,0)+coalesce(research_infantry_tier_3,0)+coalesce(research_shaman_tier_3,0)) as research_t3,
(coalesce(research_cavalry_tier_4,0)+coalesce(research_infantry_tier_4,0)+coalesce(research_shaman_tier_4,0)) as research_t4,
(coalesce(research_cavalry_tier_5,0)+coalesce(research_infantry_tier_5,0)+coalesce(research_shaman_tier_5,0))
 as research_t5 from dw.user_daily_1012 where server_id in ('1006902','1007002','1007102','1007202','1007302','1007402','1007502','1007602','1007702','1007802','1007902','1008002','1008102','1008202','1008302','1008402','1008502','1008602','1008702','1008802')) a,(SELECT max(created_date) as last_login,user_id,server_id FROM dw.user_daily_1012 where  server_id in ('1006902','1007002','1007102','1007202','1007302','1007402','1007502','1007602','1007702','1007802','1007902','1008002','1008102','1008202','1008302','1008402','1008502','1008602','1008702','1008802') and created_date > '2017-05-23' group by user_id,server_id) b where a.user_id = b.user_id and a.server_id = b.server_id and a.created_date = last_login) TABLE_2 WHERE TABLE_1.user_id = TABLE_2.user_id;

#
select user_id ,goods_id,date(created_at),user_name,group_concat(distinct(ip)),
sum(if(channel=1,change_num,0 )) as GD_BUY,sum(if(channel=23301001,change_num,0 )) as GD_CHAN_INC_FREE_AUTOGROW,
sum(if(channel=23401001,change_num,0 )) as GD_CHAN_INC_FREE_ROB, sum(if(channel=42005002,change_num,0 )) as GD_CHAN_INC_PLAYER_EXCHANGE, sum(if(channel=51006001,change_num,0 )) as GD_CHAN_DEC_ROB_RSS, sum(if(channel=60305003,change_num,0 )) as GD_CHAN_DEC_OWN_EXCHANGE  from goods_logs_201708 where goods_id='res_rss_a'
and created_at >'2017-08-01 20:12:48'  and created_at<'2017-08-21 20:44:25'group by user_id,goods_id,date(created_at)  
#
SELECT user_id FROM dw.user_daily_1012 where server_id='1018602' and user_name like '% 龙琦樱乃%'
