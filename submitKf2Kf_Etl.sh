#!/usr/bin/env bash
source "$(dirname "$0")"/env.sh



#use case * $FLINK_DIR/bin/flink run -d -p 4 -c com.github.wuchong.ETL.ETL_OGG_DATA_SINKTO_KAFKA  target/flink-sql-submit.jar "sourceTopicId" "sinkTopicId" "jobname"
#use case * $FLINK_DIR/bin/flink run -d -p 4 -c com.github.wuchong.ETL.ETL_OGG_DATA_SINKTO_KAFKA  target/flink-sql-submit.jar "$1" "$2" "$3"


$FLINK_DIR/bin/flink run -d -p 4 -c com.github.wuchong.ETL.ETL_OGG_DATA_SINKTO_KAFKA  target/flink-sql-submit.jar "test_ogg" "user_behavior" "elt_ogg_data_sinkto_kafka"

