
--将数据有上一个留的表中添加到这里的kafka结果数据表中
CREATE TABLE pvuv_sink_kafka (
    dt VARCHAR,
     pv BIGINT,
     uv BIGINT
) WITH (
    'connector.type' = 'kafka',
    'connector.version' = 'universal',
    'connector.topic' = 'user_behavior_sink',
    'connector.startup-mode' = 'earliest-offset',
    'connector.properties.0.key' = 'zookeeper.connect',
    'connector.properties.0.value' = 'slave1:2181',
    'connector.properties.1.key' = 'bootstrap.servers',
    'connector.properties.1.value' = 'slave2:9092',
    'update-mode' = 'append',
    'format.type' = 'json',
    'format.derive-schema' = 'true'
);


CREATE TABLE pvuv_sink_mysql (
    dt VARCHAR,
    pv BIGINT,
    uv BIGINT
) WITH (
    'connector.type' = 'jdbc',
    'connector.url' = 'jdbc:mysql://master:3306/flink-test',
    'connector.table' = 'pvuv_sink',
    'connector.username' = 'hive',
    'connector.password' = '123456',
    'connector.write.flush.max-rows' = '1'
);


INSERT INTO pvuv_sink_kafka SELECT * FROM pvuv_sink_mysql;

