CREATE TABLE IPC_DIAG_SERVICE_D (
  ID     VARCHAR,
  DIAG_ITEM_CNAME     VARCHAR
) WITH (
    'connector.type' = 'kafka',
    'connector.version' = 'universal',
    'connector.topic' = 'IPC_DIAG_SERVICE_D',
    'connector.startup-mode' = 'latest-offset',--'earliest-offset',
    'connector.properties.0.key' = 'zookeeper.connect',
    'connector.properties.0.value' = 'slave1:2181',
    'connector.properties.1.key' = 'bootstrap.servers',
    'connector.properties.1.value' = 'slave2:9092',
    'update-mode' = 'append',
    'format.type' = 'json',
    'format.derive-schema' = 'true'
);


-- CREATE TABLE metric (
--   DIAG     VARCHAR,
--   CNT      BIGINT
-- ) WITH (
--     'connector.type' = 'kafka',
--     'connector.version' = 'universal',
--     'connector.topic' = 'metric',
--     'connector.startup-mode' = 'latest-offset',--'earliest-offset',
--     'connector.properties.0.key' = 'zookeeper.connect',
--     'connector.properties.0.value' = 'slave1:2181',
--     'connector.properties.1.key' = 'bootstrap.servers',
--     'connector.properties.1.value' = 'slave2:9092',
--     'update-mode' = 'append',
--     'format.type' = 'json',
--     'format.derive-schema' = 'true'
-- );

CREATE TABLE metric (
    `identity` VARCHAR,
    `metric`   VARCHAR,
    `dt`       VARCHAR,
    `key`      VARCHAR,
    `value`    Double
) WITH (
    'connector.type' = 'jdbc',
    'connector.url' = 'jdbc:mysql://master:3306/flink-test?characterEncoding=utf-8',
    'connector.table' = 'metric',
    'connector.username' = 'hive',
    'connector.password' = '123456',
    'connector.write.flush.max-rows' = '1'
);

-- INSERT INTO metric
-- select DIAG_ITEM_CNAME AS DIAG,COUNT(1) AS CNT from IPC_DIAG_SERVICE_D GROUP BY DIAG_ITEM_CNAME;


INSERT INTO metric
SELECT
'1' AS `identity`,
'DIAG' AS metric,
'2020-10-21 00:00:00' AS dt,
DIAG_ITEM_CNAME AS ky,
cast(25.6 AS DOUBLE) AS vl
FROM IPC_DIAG_SERVICE_D
GROUP BY DIAG_ITEM_CNAME;




