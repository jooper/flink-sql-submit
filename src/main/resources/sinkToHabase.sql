CREATE TABLE user_log (
    user_id VARCHAR,
    item_id VARCHAR,
    category_id VARCHAR,
    behavior VARCHAR,
    ts TIMESTAMP
) WITH (
    'connector.type' = 'kafka',
    'connector.version' = 'universal',
    'connector.topic' = 'user_behavior',
    'connector.startup-mode' = 'earliest-offset',
    'connector.properties.0.key' = 'zookeeper.connect',
    'connector.properties.0.value' = 'slave1:2181',
    'connector.properties.1.key' = 'bootstrap.servers',
    'connector.properties.1.value' = 'slave2:9092',
    'update-mode' = 'append',
    'format.type' = 'json',
    'format.derive-schema' = 'true'
);


create table sink (
    id    TINYINT,
    name  BIGINT,
    primary key (id)
) with (
    type = 'cloudhbase',
    zkQuorum = 'slave1:2181',
    columnFamily = 'f1',
    tableName = 'department'
)

--暂时不支持，需要在1.11版本中

INSERT INTO sink
SELECT user_id, item_id FROM user_log