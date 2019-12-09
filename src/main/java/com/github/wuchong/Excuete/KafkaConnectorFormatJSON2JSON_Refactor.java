package com.github.wuchong.Excuete;


import org.apache.flink.api.common.typeinfo.TypeInformation;
import org.apache.flink.api.common.typeinfo.Types;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.table.api.EnvironmentSettings;
import org.apache.flink.table.api.Table;
import org.apache.flink.table.api.java.StreamTableEnvironment;
import org.apache.flink.table.descriptors.Json;
import org.apache.flink.table.descriptors.Kafka;
import org.apache.flink.table.descriptors.Schema;
import org.apache.flink.types.Row;

public class KafkaConnectorFormatJSON2JSON_Refactor {
    private final static String SOURCE_TOPIC = "user_browelog";
    private final static String SINK_TOPIC = "sink";
    private final static String ZOOKEEPER_CONNECT = "slave1:2181";
    private final static String GROUP_ID = "group1";
    private final static String METADATA_BROKER_LIST = "slave2:9092";


    public static void main(String[] args) throws Exception {
//        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
//        StreamTableEnvironment tEnv = TableEnvironment.getTableEnvironment(env);

        EnvironmentSettings settings = EnvironmentSettings.newInstance().inStreamingMode().useBlinkPlanner().build();
        StreamExecutionEnvironment streamEnv = StreamExecutionEnvironment.getExecutionEnvironment();
        StreamTableEnvironment tEnv = StreamTableEnvironment.create(streamEnv, settings);
        streamEnv.setParallelism(1);


        tEnv.connect(
                new Kafka()
                        .version("0.10")
                        .topic(SOURCE_TOPIC)
                        .startFromEarliest()
                        .property("zookeeper.connect", ZOOKEEPER_CONNECT)
                        .property("bootstrap.servers", METADATA_BROKER_LIST)
        )
                .withFormat(
                        new Json()
                                .schema(
                                        org.apache.flink.table.api.Types.ROW(
                                                new String[]{"userID", "eventTime", "eventType", "productID", "productPrice"},
                                                new TypeInformation[]{
                                                        org.apache.flink.table.api.Types.STRING()
                                                        , org.apache.flink.table.api.Types.STRING()
                                                        , org.apache.flink.table.api.Types.STRING()
                                                        , org.apache.flink.table.api.Types.STRING()
                                                        , org.apache.flink.table.api.Types.STRING()

                                                }))
                                .failOnMissingField(true)   // optional: flag whether to fail if a field is missing or not, false by default
                )
                .withSchema(
                        new Schema()
                                .field("userID", Types.STRING)
                                .field("eventTime", Types.STRING)
                                .field("eventType", Types.STRING)
                                .field("productID", Types.STRING)
                                .field("productPrice", Types.STRING)
                )
                .inAppendMode()
                .registerTableSource("sourceTable");

////        String Sql="SELECT DATE_FORMAT(ts,'yyyy-MM-dd HH:00') dt ,COUNT(*) AS pv,COUNT(DISTINCT user_id) AS uv FROM sourceTable GROUP BY DATE_FORMAT(ts, 'yyyy-MM-dd HH:00')";
//        String Sql = "SELECT ts ,COUNT(*) AS pv,COUNT(DISTINCT user_id) AS uv FROM sourceTable GROUP BY ts";
////        Table result = tEnv.sqlQuery("select * from sourceTable");
//        Table result = tEnv.sqlQuery(Sql);
////        DataStream<Row> rowDataStream = tEnv.toAppendStream(result, Row.class);
//        DataStream<Tuple2<Boolean, Row>> rowDataStream = tEnv.toRetractStream(result, Row.class);
//
//        rowDataStream.print();
        Table select_userID_from_sourceTable = tEnv.sqlQuery("select * from sourceTable where userID is not null");

        tEnv.toAppendStream(select_userID_from_sourceTable, Row.class).print();

        tEnv.execute("tesst kafka connector demo");

//
//        tEnv.connect(
//                new Kafka()
//                        .version("0.10")    // required: valid connector versions are
//                        //   "0.8", "0.9", "0.10", "0.11", and "universal"
//                        .topic(SINK_TOPIC)       // required: topic name from which the table is read
//                        // optional: connector specific properties
//                        .property("zookeeper.connect", ZOOKEEPER_CONNECT)
//                        .property("bootstrap.servers", METADATA_BROKER_LIST)
//                        .property("group.id", GROUP_ID)
//                        // optional: select a startup mode for Kafka offsets
//                        .startFromEarliest()
//                        .sinkPartitionerFixed()         // each Flink partition ends up in at-most one Kafka partition (default)
//        ).withFormat(
//                new Json()
//                        .schema(
//                                org.apache.flink.table.api.Types.ROW(
//                                        new String[]{"dt", "pv", "uv"},
//                                        new TypeInformation[]{
//                                                org.apache.flink.table.api.Types.SQL_TIMESTAMP()
//                                                , org.apache.flink.table.api.Types.LONG()
//                                                , org.apache.flink.table.api.Types.LONG()
//                                        }))
//                        .failOnMissingField(true)   // optional: flag whether to fail if a field is missing or not, false by default
//        )
//                .withSchema(
//                        new Schema()
//                                .field("dt", Types.SQL_TIMESTAMP)
//                                .field("pv", Types.LONG)
//                                .field("uv", Types.LONG)
//                )
//                .inAppendMode()
//                .registerTableSink("sinkTable");
////
////
////        tEnv.sqlUpdate("insert into sinkTable(id,product,amount) select id,product,33 from sourceTable  ");
//
////
////        String updataStrSql = "INSERT INTO sinkTable SELECT ts ,COUNT(*) AS pv,COUNT(DISTINCT user_id) AS uv FROM sourceTable GROUP BY ts";
//        String updataStrSql = "INSERT INTO sinkTable SELECT ts ,COUNT(*) AS pv,COUNT(DISTINCT user_id) AS uv  FROM sourceTable  GROUP BY ts";
//        tEnv.sqlUpdate(updataStrSql);
//
//        env.execute(" tesst kafka connector demo");

    }
}
