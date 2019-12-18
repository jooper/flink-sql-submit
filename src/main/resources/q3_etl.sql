

-- source
CREATE TABLE test_ogg (
    table VARCHAR,
    op_type VARCHAR,
    op_ts VARCHAR,
    current_ts VARCHAR,
    pos VARCHAR,
    primary_keys VARCHAR,
    after VARCHAR
) WITH (
    'connector.type' = 'kafka',
    'connector.version' = 'universal',
    'connector.topic' = 'test_ogg',
    'connector.startup-mode' = 'earliest-offset',
    'connector.properties.0.key' = 'zookeeper.connect',
    'connector.properties.0.value' = 'slave1:2181',
    'connector.properties.1.key' = 'bootstrap.servers',
    'connector.properties.1.value' = 'slave2:9092',
    'update-mode' = 'append',
    'format.type' = 'json',
    'format.derive-schema' = 'true'
);

-- sink kafka
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





INSERT INTO pvuv_sink_mysql
SELECT after FROM test_ogg






