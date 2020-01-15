
/opt/ogg


80(slave3)上放的是 flink_submit,   安装有flink平台服务
84  数据库mock脚本

# 源端  84
a:  start/stop mgr
b:  start/stop extkafka
c:  start/stop pukafka

INFO EXTTRAIL *

# 目标端  81
d:  start/stop mgr
e:  start/stop rekafka

INFO replicat *

# 启动顺序  ad,bc,e

info all

info extkafka,detail
view report rekafka

# 重置Extract 和Replicat 进程的Trail 序列号
<!-- 先停进程，然后使用如下命令，将trail 文件的编号都重置为0. -->
alter extract extkafka,begin now
alter extract pukafka,begin now
alter replicat  rekafka,begin now

alter extract pukafka,extseqno 0,extrba 0
alter extract extkafka,extseqno 0,extrba 0
alter replicat rekafka,extseqno 0,extrba 0



alter replicat rekafka,extseqno 21,extrba 0




<!-- 查看检查点状态 -->
GGSCI (rhlinux) 3> info rekafka,showch

<!-- 删除trail文件到replicate进程 -->
delete replicat rekafka exttrail /opt/ogg/dirdat/to
<!-- 添加trail文件到replicate进程 -->
add replicat rekafka exttrail /opt/ogg/dirdat/to,checkpointtable test_ogg.checkpoint






#修复trail文件
./logdump
pos 1252定位到trail文件中错误行提示的位置

n:显示下一条，
sfh prev  显示上一条  找到这条的RBA值  

修复操作：
./ggsci
GGSCI> ALTER REPLICAT rekafka, EXTRBA 1165
GGSCI> START REPLICAT rekafka,  --- #ATCSN 15572172378　　--完成恢复


GGSCI> ALTER extract pukafka, EXTRBA 1165
GGSCI> START extract pukafka,  --- #ATCSN 15572172378　　--完成恢复


#没有日志文件产生时，/opt/ogg/dirdat
--前滚重新生成一个新的队列文件
alter extract extkafka etrollover
alter extract pukafka etrollover



logdump 查看trail文件信息
open ./dirdat/to000010
Logdump 9 >open ./dirdat/si009180   ---打开文件
Logdump 15 >ghdr on     ---查看header record信息    
Logdump 16 >detail on   ---查看列信息，包括number和长度
Logdump 17 >detail data    -----To add hex and ASCII data values to the column information
Logdump 18 >usertoken on   ---查看用户定义的信
Logdump 19 >n   ---显示下一条记录


create tablespace oggtbs datafile '/u01/app/oracle/oggdata/oracle/oggtbs01.dbf' size 1000M autoextend on;

/opt/cloudera/parcels/CDH-6.0.1-1.cdh6.0.1.p0.590678/lib/kafka/bin/kafka-console-consumer.sh --bootstrap-server slave2:9092 --topic test_ogg --from-beginning

 

/opt/cloudera/parcels/CDH-6.0.1-1.cdh6.0.1.p0.590678/lib/kafka/bin/kafka-topics.sh --bootstrap-server slave2:9092 --topic test_ogg 


/opt/cloudera/parcels/CDH-6.0.1-1.cdh6.0.1.p0.590678/lib/kafka/bin/kafka-topics.sh --delete --zookeeper slave1:2181 --topic test_ogg


/opt/cloudera/parcels/CDH-6.0.1-1.cdh6.0.1.p0.590678/lib/kafka/bin/kafka-topics.sh --list --zookeeper slave1:2181



add replicat rekafka exttrail /opt/ogg/dirdat/to,checkpointtable test_ogg.checkpoint



/opt/cloudera/parcels/CDH-6.0.1-1.cdh6.0.1.p0.590678/lib/kafka/bin/kafka-console-producer.sh --broker-list slave2:9092 --topic test_ogg


 add replicat rekafka exttrail /opt/ogg/dirdat/to,checkpointtable test_ogg.checkpoint











#目标端

mgr:

PORT 7809
DYNAMICPORTLIST 7810-7909
AUTORESTART EXTRACT *,RETRIES 5,WAITMINUTES 3
PURGEOLDEXTRACTS ./dirdat/*,usecheckpoints, minkeepdays 3



#
PORT 7809
DYNAMICPORTLIST 7810-7909
AUTORESTART REPLICAT *, RETRIES 5, WAITMINUTES 3, RESETMINUTES 60
PURGEOLDEXTRACTS ./dirdat/*,usecheckpoints, minkeepdays 3
LAGREPORTHOURS 1
LAGINFOMINUTES 30
LAGCRITICALMINUTES 45;




10.158.5.80:9092,10.158.5.83:9092,10.158.5.81:9092




{"CATEGORY_ID":"4757812","BEHAVIOR":"pv","USER_ID":176,"ITEM_ID":"ogg-kafka-flink-176","TS":"2017-11-26T01:00:15Z"}

{"user_id": "315321", "item_id":"942195", "category_id": "4339722", "behavior": "pv", "ts": "2017-11-26T01:00:00Z"}



{"user_id": "74745", "item_id":"2231297", "category_id": "323851", "behavior": "fav", "ts": "2017-11-26T01:00:15Z"}
{"user_id": "326607", "item_id":"3693156", "category_id": "2066955", "behavior": "pv", "ts": "2017-11-26T01:00:15Z"}
{"user_id": "651189", "item_id":"4000666", "category_id": "886203", "behavior": "pv", "ts": "2017-11-26T01:00:15Z"}
{"user_id": "778396", "item_id":"3607696", "category_id": "5012555", "behavior": "pv", "ts": "2017-11-26T01:00:16Z"}
{"user_id": "493284", "item_id":"127403", "category_id": "359388", "behavior": "pv", "ts": "2017-11-26T01:00:16Z"}
{"user_id": "254349", "item_id":"4445002", "category_id": "2355072", "behavior": "pv", "ts": "2017-11-26T01:00:16Z"}
{"user_id": "415381", "item_id":"3520931", "category_id": "2419959", "behavior": "pv", "ts": "2017-11-26T01:00:16Z"}


{"CATEGORY_ID":"886203","BEHAVIOR":"pv","USER_ID":651189,"ITEM_ID":"4000666","TS":"2017-11-26T01:00:15Z"}

{"user_id": "651189", "item_id":"4000666", "category_id": "886203", "behavior": "pv", "ts": "2017-11-26T01:00:15Z"}

insert into test_ogg.test_ogg values('74745','2231297','323851','pv','2017-11-26T01:00:15Z');
insert into test_ogg.test_ogg values('326607','3693156','2066955','pv','2017-11-26T01:00:15Z');
insert into test_ogg.test_ogg values('651189','4000666','886203','pv','2017-11-26T01:00:15Z');
insert into test_ogg.test_ogg values('778396','3607696','5012555','pv','2017-11-26T01:00:16Z');
insert into test_ogg.test_ogg values('493284','127403','359388','pv','2017-11-26T01:00:16Z');





同步部分列

extract extkafka
dynamicresolution
SETENV (ORACLE_SID = "oracle")
SETENV (NLS_LANG = "american_america.AL32UTF8")
userid ogg,password ogg
exttrail /opt/ogg/dirdat/to
table test_ogg.test_ogg
TABLE test_ogg.OPR_REGISTRATION, COLS(ID,REGISTRATION_DATE,REFUND,S_BRLX_DM,REGISTRATION_TYPE,HEALTH_SERVICE_ORG_ID);
GETUPDATEBEFORES
NOCOMPRESSDELETES
NOCOMPRESSUPDATES;








-
-- 添加表

1、dblogin userid ogg, password ogg

--给表添加附加日志
2、delete trandata test_ogg.opc_drug_presc_d_charge
   add trandata test_ogg.opc_drug_presc_d_charge
   info trandata test_ogg.opc_drug_presc_d_charge
3、edit param test_ogg(源端)
   table test_ogg.opc_drug_presc_d_charge
4、edit param pukafka
   table test_ogg.opc_drug_presc_d_charge;
5、cd /opt/ogg
    su - oracle
   ./defgen paramfile dirprm/test_ogg.prm
6、scp -r /opt/ogg/dirdef/test_ogg.test_ogg root@10.158.5.81:/opt/ogg/dirdef/ 

7、edit param rekafka  添加表映射信息
   MAP test_ogg.OPR_REGISTRATION, TARGET test_ogg.OPR_REGISTRATION; 

8、重启源端和目标端



