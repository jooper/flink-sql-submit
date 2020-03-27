#!/usr/bin/env bash

#functaion:添加新表信息到ogg的映射文件中,自动化脚本
#use case: ./addNewMappingTable.sh table_name
#ps:需要在oracle账号下进行以下操作，  su - oracle
# su - oracle


ogg_home=/opt/ogg
#table_name="OPR_REGISTRATION_D"
table_name=$1
receive_host=root@10.158.5.81

#/home/oracle  注意需要在oracle账户下的相关目录下才有创建文件的权限，否则会报错
#info trandata test_ogg.${table_name}

echo "dblogin userid ogg, password ogg
delete trandata test_ogg.${table_name}
add trandata test_ogg.${table_name}
exit" >/home/oracle/tmp.txt

ogg_cm="/home/oracle/tmp.txt"
# cat $ogg_cm
${ogg_home}/ggsci <<EOD
OBEY $ogg_cm
EOD

echo "table test_ogg.${table_name};" >>${ogg_home}/dirprm/test_ogg.prm

cat ${ogg_home}/dirprm/test_ogg.prm

#删除结构文件，重新生成
rm -rf ${ogg_home}/dirdef/test_ogg.test_ogg

${ogg_home}/defgen paramfile ${ogg_home}/dirprm/test_ogg.prm

scp -r /opt/ogg/dirdef/test_ogg.test_ogg ${receive_host}:/opt/ogg/dirdef/

# (info all;info all,task;exit)|${ogg_home}/ggsci

# ${ogg_home}/ggsci << EOD
# info all
# info all,task
# exit
# EOD

# ${ogg_home}/ggsci << EOD
# dblogin userid ogg, password ogg
# delete trandata test_ogg.${table_name}
# add trandata test_ogg.${table_name}
# exit
# EOD