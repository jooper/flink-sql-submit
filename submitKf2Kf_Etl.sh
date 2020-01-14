#!/usr/bin/env bash
source "$(dirname "$0")"/env.sh
#use case * $FLINK_DIR/bin/flink run -d -p 4 -c com.github.wuchong.ETL.ETL_OGG_DATA_SINKTO_KAFKA  target/flink-sql-submit.jar "sourceTopicId" "sinkTopicId" "jobname"
#use case * $FLINK_DIR/bin/flink run -d -p 4 -c com.github.wuchong.ETL.ETL_OGG_DATA_SINKTO_KAFKA  target/flink-sql-submit.jar "$1" "$2" "$3"
# 对ogg抽取到kafka中的数据进行抽取清洗，拿取after之后的数据放到相应的topic中
topics=(TEST_OGG OPR_REGISTRATION)

for topic in ${topics[@]}; do
    if [ topic != "" ]; then
        echo topic
        $FLINK_DIR/bin/flink run -d -p 4 -c com.github.wuchong.ETL.ETL_OGG_DATA_SINKTO_KAFKA target/flink-sql-submit.jar "${topic}" "${topic}_AfterData" "ETL_ORACLE_TABLE_${topic}_JOB"
    fi
done

# $FLINK_DIR/bin/flink run -d -p 4 -c com.github.wuchong.ETL.ETL_OGG_DATA_SINKTO_KAFKA  target/flink-sql-submit.jar "TEST_OGG" "user_behavior" "ETL_ORACLE_TABLE_TEST_OGG_JOB"
