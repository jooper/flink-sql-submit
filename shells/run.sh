#!/usr/bin/env bash
#提交单个job，执行相关sql文件中的代码
#$FLINK_DIR/bin/flink run -d -p 4 target/flink-sql-submit.jar -w "${PROJECT_DIR}"/src/main/resources/ -f "$1".sql -jn "$2"
################################################################################
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################
#-jn  jobname
#./flink run --help
#客户端提交作业的时候 断开，session会话也会断开，加上这个参数后，会继续保持会话
#eg： flink run -d
#-p  并行度   -p,--parallelism <parallelism>

source "$(dirname "$0")"/env.sh

PROJECT_DIR=`cd .. && pwd`
#  $1  :sql脚本文件名称 如：a1.sql
# -jn  :运行当前sql文件的job名称
#$FLINK_DIR/bin/flink run -d -p 4 target/flink-sql-submit.jar -w "${PROJECT_DIR}"/src/main/resources/ -f "$1".sql -jn "$2"

$FLINK_DIR/bin/flink run -d -p 4 ../target/flink-sql-submit.jar -w "${PROJECT_DIR}"/src/main/resources/sql/dml/ -f "$1" -jn "$2"




#$FLINK_DIR/bin/flink run -d -p 4 target/flink-sql-submit.jar -w "${PROJECT_DIR}"/src/main/resources/ -f "$1".sql -jn "$2"
#$FLINK_DIR/bin/flink run -d -p 4 target/flink-sql-submit.jar -w "${PROJECT_DIR}"/src/main/resources/ -f "oracle_to_mysql".sql -jn "oracle_to_mysql"
#$FLINK_DIR/bin/flink run -d -p 4 target/flink-sql-submit.jar -w "${PROJECT_DIR}"/src/main/resources/ -f "mysql_to_kafka".sql -jn "mysql_to_kafka"