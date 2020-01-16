
CREATE TABLE OPC_DIAG_SERVICE_D_CHARGE (
  diag_service_h_charge_id VARCHAR,
  total_amt BIGINT
) WITH (
    'connector.type' = 'kafka',
    'connector.version' = 'universal',
    'connector.topic' = 'OPC_DIAG_SERVICE_D_CHARGE_AfterData',
    'connector.startup-mode' = 'earliest-offset',
    'connector.properties.0.key' = 'zookeeper.connect',
    'connector.properties.0.value' = 'slave1:2181',
    'connector.properties.1.key' = 'bootstrap.servers',
    'connector.properties.1.value' = 'slave2:9092',
    'update-mode' = 'append',
    'format.type' = 'json',
    'format.derive-schema' = 'true'
);


CREATE TABLE OPC_DIAG_SERVICE_H_CHARGE (
  id VARCHAR,
  charge_date VARCHAR,
  health_service_org_id VARCHAR
) WITH (
    'connector.type' = 'kafka',
    'connector.version' = 'universal',
    'connector.topic' = 'OPC_DIAG_SERVICE_H_CHARGE_AfterData',
    'connector.startup-mode' = 'earliest-offset',
    'connector.properties.0.key' = 'zookeeper.connect',
    'connector.properties.0.value' = 'slave1:2181',
    'connector.properties.1.key' = 'bootstrap.servers',
    'connector.properties.1.value' = 'slave2:9092',
    'update-mode' = 'append',
    'format.type' = 'json',
    'format.derive-schema' = 'true'
);



CREATE TABLE fee (
    id      VARCHAR,
    account BIGINT
) WITH (
    'connector.type' = 'jdbc',
    'connector.url' = 'jdbc:mysql://master:3306/flink-test',
    'connector.table' = 'fee',
    'connector.username' = 'hive',
    'connector.password' = '123456',
    'connector.write.flush.max-rows' = '1'
);


-- ok
-- INSERT INTO fee
-- SELECT
--    h.health_service_org_id AS id,
--    sum(d.total_amt) AS account
-- FROM OPC_DIAG_SERVICE_H_CHARGE h
--      inner join OPC_DIAG_SERVICE_D_CHARGE d
--      on d.diag_service_h_charge_id=h.id
-- GROUP BY h.health_service_org_id;

INSERT INTO fee
SELECT
h.health_service_org_id AS id,
sum(d.total_amt) AS account
FROM OPC_DIAG_SERVICE_H_CHARGE h
inner join OPC_DIAG_SERVICE_D_CHARGE d
on d.diag_service_h_charge_id=h.id
WHERE TO_DATE(SUBSTRING(h.charge_date,0,20))>=CURRENT_DATE
and h.health_service_org_id in ('RSS20171211000000001')
GROUP BY h.health_service_org_id;