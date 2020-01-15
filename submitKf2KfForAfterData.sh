#!/usr/bin/env bash

#  /home/soft/flink-1.9.0/conf/flink-conf.yaml
#  这里面要设置slots的数量，否则job太多task不够用，job会自动挂掉

source "$(dirname "$0")"/env.sh
#use case * $FLINK_DIR/bin/flink run -d -p 4 -c com.github.wuchong.ETL.ETL_OGG_DATA_SINKTO_KAFKA  target/flink-sql-submit.jar "sourceTopicId" "sinkTopicId" "jobname"
#use case * $FLINK_DIR/bin/flink run -d -p 4 -c com.github.wuchong.ETL.ETL_OGG_DATA_SINKTO_KAFKA  target/flink-sql-submit.jar "$1" "$2" "$3"
# 对ogg抽取到kafka中的数据进行抽取清洗，拿取after之后的数据放到相应的topic中
topics=(TEST_OGG OPR_REGISTRATION opc_diag_service_d_charge opc_drug_presc_d_charge)

function submitEtlJob() {
    for topic in ${topics[@]}; do
        if [ topic != "" ]; then
            echo "starting topic $topic etl job . . ."
            $FLINK_DIR/bin/flink run -d -p 4 -c com.github.wuchong.ETL.ETL_OGG_DATA_SINKTO_KAFKA target/flink-sql-submit.jar "${topic}" "${topic}_AfterData" "ETL_ORACLE_TABLE_[${topic}]_AfterData_JOB"
        fi
    done
}
# $FLINK_DIR/bin/flink run -d -p 4 -c com.github.wuchong.ETL.ETL_OGG_DATA_SINKTO_KAFKA  target/flink-sql-submit.jar "TEST_OGG" "user_behavior" "ETL_ORACLE_TABLE_TEST_OGG_JOB"

function cancelAllJob() {
    rst=$($FLINK_DIR/bin/flink list | awk '{if($4!="no"&&$4!="-------------------")printf $4;printf"\n" }')
    for jobid in ${rst[@]}; do
        if [ jobid != "" ]; then
            echo "canceling job id is : $jobid"
            $FLINK_DIR/bin/flink cancel $jobid
        fi
    done
}
cancelAllJob
submitEtlJob
