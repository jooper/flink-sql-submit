package com.github.wuchong.Excuete;

import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;
import org.apache.flink.api.common.serialization.SimpleStringSchema;
import org.apache.flink.api.common.typeinfo.TypeInformation;
import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.api.java.typeutils.RowTypeInfo;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.streaming.api.datastream.DataStreamSink;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.ProcessFunction;
import org.apache.flink.streaming.api.functions.sink.RichSinkFunction;
import org.apache.flink.streaming.connectors.kafka.FlinkKafkaConsumer;
import org.apache.flink.table.api.DataTypes;
import org.apache.flink.table.api.EnvironmentSettings;
import org.apache.flink.table.api.Table;
import org.apache.flink.table.api.TableSchema;
import org.apache.flink.table.api.java.StreamTableEnvironment;
import org.apache.flink.table.sinks.TableSink;
import org.apache.flink.table.sinks.UpsertStreamTableSink;
import org.apache.flink.table.types.DataType;
import org.apache.flink.types.Row;
import org.apache.flink.util.Collector;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import java.util.Properties;

/**
 * Summary:
 * 自定义UpsertStreamTableSink 查看从有Insert/Update的Table到DataStream的消息编码
 */
@Slf4j
class UpsertStreamTableSinkDemo {
    private final static String SOURCE_TOPIC = "user_browelog";
    private final static String SINK_TOPIC = "user_behavior_sink";
    private final static String ZOOKEEPER_CONNECT = "slave1:2181";
    private final static String GROUP_ID = "group1";
    private final static String METADATA_BROKER_LIST = "slave2:9092";

    public static void main(String[] args) throws Exception {

        args = new String[]{"--application", "flink/src/main/java/com/bigdata/flink/dataStreamWindowJoin/application.properties"};

        //1、解析命令行参数
//        ParameterTool fromArgs = ParameterTool.fromArgs(args);
//        ParameterTool parameterTool = ParameterTool.fromPropertiesFile(fromArgs.getRequired("application"));

//        String kafkaBootstrapServers = parameterTool.getRequired("kafkaBootstrapServers");
//        String browseTopic = parameterTool.getRequired("browseTopic");
//        String browseTopicGroupID = parameterTool.getRequired("browseTopicGroupID");

        String kafkaBootstrapServers = METADATA_BROKER_LIST;
        String browseTopic = SOURCE_TOPIC;
        String browseTopicGroupID = GROUP_ID;


        //2、设置运行环境
        EnvironmentSettings settings = EnvironmentSettings.newInstance().inStreamingMode().useBlinkPlanner().build();
        StreamExecutionEnvironment streamEnv = StreamExecutionEnvironment.getExecutionEnvironment();
        StreamTableEnvironment tableEnv = StreamTableEnvironment.create(streamEnv, settings);
        streamEnv.setParallelism(1);

        //3、注册Kafka数据源
        Properties browseProperties = new Properties();
        browseProperties.put("bootstrap.servers", METADATA_BROKER_LIST);
//        browseProperties.put("group.id", GROUP_ID);
        browseProperties.put("zookeeper.connect", ZOOKEEPER_CONNECT);
        DataStream<UserBrowseLog> browseStream = streamEnv
                .addSource(new FlinkKafkaConsumer<>("user_browelog", new SimpleStringSchema(), browseProperties))
                .process(new BrowseKafkaProcessFunction());
        tableEnv.registerDataStream("source_kafka_browse_log", browseStream, "userID,eventTime,eventType,productID,productPrice");

        Table source_kafka_browse_log = tableEnv.scan("source_kafka_browse_log").select("*");

        DataStream<Tuple2<Boolean, Row>> tuple2DataStream = tableEnv.toRetractStream(source_kafka_browse_log, Row.class);
        tuple2DataStream.print();


        String ss = "select * from source_kafka_browse_log";
        Table table = tableEnv.sqlQuery(ss);
        tableEnv.toAppendStream(table, Row.class).print();
        table.printSchema();
        tableEnv.toAppendStream(table.select("userID"), Row.class);
        tableEnv.execute("xx");

        //4、注册UpsertStreamTableSink
        String[] sinkFieldNames = {"userID", "browseNumber"};
        DataType[] sinkFieldTypes = {DataTypes.STRING(), DataTypes.BIGINT()};
        UpsertStreamTableSink<Row> myUpsertStreamTableSink = new MyUpsertStreamTableSink(sinkFieldNames, sinkFieldTypes);
        tableEnv.registerTableSink("sink_stdout", myUpsertStreamTableSink);


        //5、连续查询
        //统计每个Uid的浏览次数
//        String sql = "insert into sink_stdout select userID,count(1) as browseNumber from source_kafka_browse_log where userID in ('user_1','user_2') group by userID ";
        String sql = "insert into sink_stdout select userID,count(1) as browseNumber from source_kafka_browse_log where userID is not null group by userID ";
        tableEnv.sqlUpdate(sql);

        //6、开始执行
        tableEnv.execute(UpsertStreamTableSinkDemo.class.getSimpleName());

//        streamEnv.execute("xx");
    }


    /**
     * 解析Kafka数据
     * 将Kafka JSON String 解析成JavaBean: UserBrowseLog
     * UserBrowseLog(String userID, String eventTime, String eventType, String productID, int productPrice, long eventTimeTimestamp)
     */
    private static class BrowseKafkaProcessFunction extends ProcessFunction<String, UserBrowseLog> {
        @Override
        public void processElement(String value, Context ctx, Collector<UserBrowseLog> out) throws Exception {
            try {

                UserBrowseLog log = JSON.parseObject(value, UserBrowseLog.class);

                // 增加一个long类型的时间戳
                DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
                DateTime dateTime = DateTime.parse(log.getEventTime(), dateTimeFormatter);
                log.setEventTimeTimestamp(dateTime.getMillis());


                out.collect(log);
            } catch (Exception ex) {
                log.error("解析Kafka数据异常...", ex);
            }
        }
    }

    /**
     * 自定义UpsertStreamTableSink
     * Table在内部被转换成具有Add(增加)和Retract(撤消/删除)的消息流，最终交由DataStream的SinkFunction处理。
     * Boolean是Add(增加)或Retract(删除)的flag(标识)。Row是真正的数据类型。
     * Table中的Insert被编码成一条Add消息。如Tuple2<True, Row>。
     * Table中的Update被编码成一条Add消息。如Tuple2<True, Row>。
     * 在SortLimit(即order by ... limit ...)的场景下，被编码成两条消息。一条删除消息Tuple2<False, Row>，一条增加消息Tuple2<True, Row>。
     */
    private static class MyUpsertStreamTableSink implements UpsertStreamTableSink<Row> {

        private TableSchema tableSchema;

        public MyUpsertStreamTableSink(String[] fieldNames, DataType[] fieldTypes) {
            this.tableSchema = TableSchema.builder().fields(fieldNames, fieldTypes).build();
        }

        @Override
        public TableSchema getTableSchema() {
            return tableSchema;
        }


        // 设置Unique Key
        // 如上SQL中有GroupBy，则这里的唯一键会自动被推导为GroupBy的字段
        @Override
        public void setKeyFields(String[] keys) {
        }

        // 是否只有Insert
        // 如上SQL场景，需要Update，则这里被推导为isAppendOnly=false
        @Override
        public void setIsAppendOnly(Boolean isAppendOnly) {
        }

        @Override
        public TypeInformation<Row> getRecordType() {
            return new RowTypeInfo(tableSchema.getFieldTypes(), tableSchema.getFieldNames());
        }

        // 已过时
        @Override
        public void emitDataStream(DataStream<Tuple2<Boolean, Row>> dataStream) {
        }

        // 最终会转换成DataStream处理
        @Override
        public DataStreamSink<Tuple2<Boolean, Row>> consumeDataStream(DataStream<Tuple2<Boolean, Row>> dataStream) {
            return dataStream.addSink(new SinkFunction());
        }

        @Override
        public TableSink<Tuple2<Boolean, Row>> configure(String[] fieldNames, TypeInformation<?>[] fieldTypes) {
            return null;
        }

        private static class SinkFunction extends RichSinkFunction<Tuple2<Boolean, Row>> {
            public SinkFunction() {
            }

            @Override
            public void invoke(Tuple2<Boolean, Row> value, Context context) throws Exception {
                Boolean flag = value.f0;
                if (flag) {
                    System.out.println("增加... " + value);
                } else {
                    System.out.println("删除... " + value);
                }
            }
        }
    }
}
