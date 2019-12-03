package com.github.wuchong.Excuete;

import com.github.wuchong.sqlsubmit.cli.CliOptions;
import com.github.wuchong.sqlsubmit.cli.CliOptionsParser;
import com.github.wuchong.sqlsubmit.cli.SqlCommandParser;
import com.github.wuchong.sqlsubmit.cli.SqlCommandParser.SqlCommandCall;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.table.api.EnvironmentSettings;
import org.apache.flink.table.api.SqlParserException;
import org.apache.flink.table.api.TableEnvironment;
import com.github.wuchong.sqlsubmit.cli.SqlCommandParser.SqlCommandCall;
import org.apache.flink.table.api.java.StreamTableEnvironment;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;


public class ExcuteScript {
    public static void main(String[] args) throws Exception {

//        EnvironmentSettings settings = EnvironmentSettings.newInstance()
//                .useBlinkPlanner()
//                .inStreamingMode()
//                .build();
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        TableEnvironment tEnv = StreamTableEnvironment.create(env);


        String sql = "CREATE TABLE user_log (\n" +
                "    user_id VARCHAR,\n" +
                "    item_id VARCHAR,\n" +
                "    category_id VARCHAR,\n" +
                "    behavior VARCHAR,\n" +
                "    ts TIMESTAMP\n" +
                ") WITH (\n" +
                "    'connector.type' = 'kafka',\n" +
                "    'connector.version' = 'universal',\n" +
                "    'connector.topic' = 'user_behavior',\n" +
                "    'connector.startup-mode' = 'earliest-offset',\n" +
                "    'connector.properties.0.key' = 'zookeeper.connect',\n" +
                "    'connector.properties.0.value' = 'slave1:2181',\n" +
                "    'connector.properties.1.key' = 'bootstrap.servers',\n" +
                "    'connector.properties.1.value' = 'slave2:9092',\n" +
                "    'update-mode' = 'append',\n" +
                "    'format.type' = 'json',\n" +
                "    'format.derive-schema' = 'true'\n" +
                ");";

//        List<String> sqls = new LinkedList<>();
//        sqls.add(sql);
//
//        List<SqlCommandCall> calls = com.github.wuchong.sqlsubmit.cli.SqlCommandParser.parse(sqls);
//        for (SqlCommandCall call : calls) {
//
//            String ddl = sql;
//            try {
//                tEnv.sqlUpdate(ddl);
//            } catch (SqlParserException e) {
//                throw new RuntimeException("SQL parse failed:\n" + ddl + "\n", e);
//            }
//        }
//
//
//        tEnv.sqlUpdate(sql);
//        tEnv.execute("SQL Job");

    }
}
