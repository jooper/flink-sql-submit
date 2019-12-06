//package com.github.wuchong.Excuete;
//
//import org.apache.flink.api.common.typeinfo.TypeInformation;
//import org.apache.flink.api.common.typeinfo.Types;
//import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
//import org.apache.flink.table.api.Table;
//import org.apache.flink.table.api.java.StreamTableEnvironment;
//import org.apache.flink.table.descriptors.Json;
//import org.apache.flink.table.descriptors.Kafka;
//import org.apache.flink.table.descriptors.Schema;
//
//
//public class KafkaConnectorFormatJSON2JSON {
//    private final static String SOURCE_TOPIC = "user_behavior_source";
//    private final static String SINK_TOPIC = "user_behavior_sink";
//    private final static String ZOOKEEPER_CONNECT = "slave1:2181";
//    private final static String GROUP_ID = "group1";
//    private final static String METADATA_BROKER_LIST = "slave2:9092";
//
//    public static void main(String[] args) throws Exception {
//        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
//        StreamTableEnvironment tEnv = StreamTableEnvironment.create(env);
//        RegisterKafkaSourceTable(tEnv);
////        RegisterKafkaSinkTable(tEnv);
//        Insert2KafkaSinkFromKafkaSource(env, tEnv);
//    }
//
//    private static void Insert2KafkaSinkFromKafkaSource(StreamExecutionEnvironment env, StreamTableEnvironment tEnv) throws Exception {
//        String sql = "INSERT INTO sinkTable\n" +
//                "SELECT\n" +
//                "  DATE_FORMAT(ts, 'yyyy-MM-dd HH:00') dt,\n" +
//                "  COUNT(*) AS pv,\n" +
//                "  COUNT(DISTINCT user_id) AS uv\n" +
//                "FROM sourceTable\n" +
//                "GROUP BY DATE_FORMAT(ts, 'yyyy-MM-dd HH:00');";
//
//        String querySqlStr = "select * from sourceTable";
////"insert into sinkTable(id,product,amount) select id,product,33 from sourceTable  "
////        tEnv.sqlUpdate(sql);
//
//        Table result = tEnv.sqlQuery(querySqlStr);
//
//        env.execute(" tesst kafka connector demo");
//    }
//
//    private static void RegisterKafkaSinkTable(StreamTableEnvironment tEnv) {
//        //註冊kafka類型的SINK表
//        tEnv.connect(new Kafka()
//                .version("0.10")    // required: valid connector versions are
//                .topic(SINK_TOPIC)       // required: topic name from which the table is read
//                // optional: connector specific properties
//                .property("zookeeper.connect", ZOOKEEPER_CONNECT)
//                .property("bootstrap.servers", METADATA_BROKER_LIST)
//                .property("group.id", GROUP_ID)
//                // optional: select a startup mode for Kafka offsets
//                .startFromEarliest()
//                .sinkPartitionerFixed()// each Flink partition ends up in at-most one Kafka partition (default)
//        ).withFormat(new Json()
//                .schema(
//                        org.apache.flink.table.api.Types.ROW(
//                                new String[]{"dt", "pv", "uv"},
//                                new TypeInformation[]{
//                                        org.apache.flink.table.api.Types.STRING()
//                                        , org.apache.flink.table.api.Types.INT()
//                                        , org.apache.flink.table.api.Types.INT()
//                                }))
//                .failOnMissingField(true)   // optional: flag whether to fail if a field is missing or not, false by default
//        ).withSchema(new Schema()
//                .field("dt", Types.STRING)
//                .field("pv", Types.INT)
//                .field("uv", Types.INT)
//        ).inAppendMode().registerTableSink("sinkTable");
//    }
//
//    private static void RegisterKafkaSourceTable(StreamTableEnvironment tEnv) {
//        //註冊kafka類型的SOURCE表
//        tEnv.connect(
//                new Kafka()
//                        .version("0.10")
//                        .topic(SOURCE_TOPIC)
//                        .startFromEarliest()
//                        .property("zookeeper.connect", ZOOKEEPER_CONNECT)
//                        .property("bootstrap.servers", METADATA_BROKER_LIST)
//        ).withFormat(
//                new Json().schema(
//                        org.apache.flink.table.api.Types.ROW(
//                                new String[]{"user_id", "item_id", "category_id", "behavior", "ts"},
//                                new TypeInformation[]{
//                                        org.apache.flink.table.api.Types.STRING()
//                                        , org.apache.flink.table.api.Types.STRING()
//                                        , org.apache.flink.table.api.Types.STRING()
//                                        , org.apache.flink.table.api.Types.STRING()
//                                        , org.apache.flink.table.api.Types.LOCAL_TIME()
//                                }))
//                        .failOnMissingField(true)   // optional: flag whether to fail if a field is missing or not, false by default
//        ).withSchema(
//                new Schema()
//                        .field("user_id", Types.STRING)
//                        .field("item_id", Types.STRING)
//                        .field("category_id", Types.STRING)
//                        .field("behavior", Types.STRING)
//                        .field("ts", Types.LOCAL_TIME)
//        ).inAppendMode().registerTableSource("sourceTable");
//    }
//}
