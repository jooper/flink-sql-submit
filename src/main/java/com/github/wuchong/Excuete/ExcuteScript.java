package com.github.wuchong.Excuete;

import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.table.api.EnvironmentSettings;
import org.apache.flink.table.api.Table;
import org.apache.flink.table.api.TableEnvironment;
import org.apache.flink.table.api.java.StreamTableEnvironment;


public class ExcuteScript {
    public static void main(String[] args) throws Exception {

        EnvironmentSettings settings = EnvironmentSettings.newInstance()
                .useBlinkPlanner()
                .inStreamingMode()
                .build();

        TableEnvironment tEnv = TableEnvironment.create(settings);

//        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
//        StreamTableEnvironment tEnv = StreamTableEnvironment.create(env);

        String sql_create_user_log = "CREATE TABLE user_log (\n" +
                "    user_id VARCHAR,\n" +
                "    item_id VARCHAR,\n" +
                "    category_id VARCHAR,\n" +
                "    behavior VARCHAR,\n" +
                "    ts TIMESTAMP\n" +
                ") WITH (\n" +
                "    'connector.type' = 'kafka',\n" +
                "    'connector.version' = 'universal',\n" +
                "    'connector.topic' = 'user_behavior',\n" +
                "    'connector.properties.0.key' = 'zookeeper.connect',\n" +
                "    'connector.properties.0.value' = 'slave1:2181',\n" +
                "    'connector.properties.1.key' = 'bootstrap.servers',\n" +
                "    'connector.properties.1.value' = 'slave2:9092',\n" +
                "    'update-mode' = 'append',\n" +
                "    'format.type' = 'json',\n" +
                "    'format.derive-schema' = 'true'\n" +
                ")";

        tEnv.sqlUpdate(sql_create_user_log);


//        Table result = tEnv.sqlQuery("select * from user_log");

        tEnv.execute("sink_to_kakfa");


//        String Sql_create_kafka_sink_table = "CREATE TABLE pvuv_sk (\n" +
//                "    dt VARCHAR,\n" +
//                "    pv BIGINT,\n" +
//                "    uv BIGINT\n" +
//                ") WITH (\n" +
//                "    'connector.type' = 'kafka',\n" +
//                "    'connector.version' = 'universal',\n" +
//                "    'connector.topic' = 'pvuv_sk',\n" +
//                "    'connector.startup-mode' = 'earliest-offset',\n" +
//                "    'connector.properties.0.key' = 'zookeeper.connect',\n" +
//                "    'connector.properties.0.value' = 'slave1:2181',\n" +
//                "    'connector.properties.1.key' = 'bootstrap.servers',\n" +
//                "    'connector.properties.1.value' = 'slave2:9092',\n" +
//                "    'update-mode' = 'append',\n" +
//                "    'format.type' = 'json',\n" +
//                "    'format.derive-schema' = 'true'\n" +
//                ")";
//        tEnv.sqlUpdate(Sql_create_kafka_sink_table);
//
//        String insert_to_Kafka_sink_table = "INSERT INTO pvuv_sk\n" +
//                "SELECT\n" +
//                "  DATE_FORMAT(ts, 'yyyy-MM-dd HH:00') dt,\n" +
//                "  COUNT(*) AS pv,\n" +
//                "  COUNT(DISTINCT user_id) AS uv\n" +
//                "FROM user_log\n" +
//                "GROUP BY DATE_FORMAT(ts, 'yyyy-MM-dd HH:00')";
//
//        tEnv.sqlUpdate(insert_to_Kafka_sink_table);
//
//        tEnv.execute("sink_to_kakfa");

    }
}
