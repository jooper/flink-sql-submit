#!/usr/bin/env bash

source "$(dirname "$0")"/env.sh
PROJECT_DIR=`pwd`

# 运行resource下的q1.sql中的脚本，进行消费kafka中的数据，到mysql，在通过mysql的canal实时同步到kafka中
$FLINK_DIR/bin/flink run -d -p 4 target/flink-sql-submit.jar -w "${PROJECT_DIR}"/src/main/resources/ -f q1.sql -jn "COMSUMER_TEST_OGG_AFTERDATA_SINKTO_MYSQL_JOB"



