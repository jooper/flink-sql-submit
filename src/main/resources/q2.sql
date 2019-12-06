
CREATE TABLE user_log (
    user_id VARCHAR,
    item_id VARCHAR,
    category_id VARCHAR,
    behavior VARCHAR,
    ts TIMESTAMP
) WITH (
    'connector.type' = 'kafka', -- 使用 kafka connector
    'connector.version' = 'universal',  -- kafka 版本，universal 支持 0.11 以上的版本
    'connector.topic' = 'user_behavior',  -- kafka topic
    'connector.startup-mode' = 'earliest-offset', -- 从起始 offset 开始读取
    'connector.properties.0.key' = 'zookeeper.connect',  -- 连接信息
    'connector.properties.0.value' = 'slave1:2181',
    'connector.properties.1.key' = 'bootstrap.servers',
    'connector.properties.1.value' = 'slave2:9092',
    'update-mode' = 'append',
    'format.type' = 'json',  -- 数据源格式为 json
    'format.derive-schema' = 'true' -- 从 DDL schema 确定 json 解析规则
);


CREATE TABLE pvuv_sk (
    user_id VARCHAR,
    item_id VARCHAR,
    category_id VARCHAR,
    behavior VARCHAR,
    ts TIMESTAMP
) WITH (
    'connector.type' = 'kafka', -- 使用 kafka connector
    'connector.topic' = 'pvuv_sk',  -- kafka topic
    'connector.startup-mode' = 'earliest-offset', -- 从起始 offset 开始读取
    'connector.properties.0.key' = 'zookeeper.connect',  -- 连接信息
    'connector.properties.0.value' = 'slave1:2181',
    'connector.properties.1.key' = 'bootstrap.servers',
    'connector.properties.1.value' = 'slave2:9092'
);
--
--
-- CREATE TABLE pvuv_sk (
--     dt VARCHAR,
--     pv BIGINT,
--     uv BIGINT
-- ) WITH (
-- --     'connector.type' = 'kafka', -- 使用 kafka connector
-- --     'connector.version' = 'universal',  -- kafka 版本，universal 支持 0.11 以上的版本
-- --     'connector.topic' = 'pvuv_sk',  -- kafka topic
-- --     --'connector.group.id' = 'xtwy',
-- --     'connector.startup-mode' = 'earliest-offset', -- 从起始 offset 开始读取
-- --     'connector.properties.0.key' = 'zookeeper.connect',  -- 连接信息
-- --     'connector.properties.0.value' = 'slave1:2181',
-- --     'connector.properties.1.key' = 'bootstrap.servers',
-- --     'connector.properties.1.value' = 'slave2:9092',
-- --     'update-mode' = 'insert',
-- --     'format.type' = 'json',  -- 数据源格式为 json
-- --     'format.derive-schema' = 'true' -- 从 DDL schema 确定 json 解析规则
--     'type' = 'kafka',
--     'topic' = 'pvuv_sk',
--     'bootstrap.servers' = 'slave2:9092'
-- );


create table pvuv_sk (
    dt VARCHAR,
    pv BIGINT,
    uv BIGINT,
    PRIMARY KEY (dt)
) with (
    type = 'kafka',
    topic = 'pvuv_sk',
    bootstrap.servers = 'slave2:9092'
);


-- INSERT INTO pvuv_sk
-- SELECT
--   DATE_FORMAT(ts, 'yyyy-MM-dd HH:00') dt,
--   COUNT(*) AS pv,
--   COUNT(DISTINCT user_id) AS uv
-- FROM user_log
-- GROUP BY DATE_FORMAT(ts, 'yyyy-MM-dd HH:00');


INSERT INTO pvuv_sk
SELECT *
FROM user_log;


