CREATE TABLE OPC_DRUG_PRESC_H_CHARGE (
  id                           VARCHAR,
  charge_date                  VARCHAR,
  health_service_org_id        VARCHAR
) WITH (
    'connector.type' = 'kafka',
    'connector.version' = 'universal',
    'connector.topic' = 'OPC_DRUG_PRESC_H_CHARGE_AfterData',
    'connector.startup-mode' = 'earliest-offset',
    'connector.properties.0.key' = 'zookeeper.connect',
    'connector.properties.0.value' = 'slave1:2181',
    'connector.properties.1.key' = 'bootstrap.servers',
    'connector.properties.1.value' = 'slave2:9092',
    'update-mode' = 'append',
    'format.type' = 'json',
    'format.derive-schema' = 'true'
);


CREATE TABLE OPC_DRUG_PRESC_D_CHARGE (
  drug_presc_h_charge_id     VARCHAR,
  total_amt                  BIGINT
) WITH (
    'connector.type' = 'kafka',
    'connector.version' = 'universal',
    'connector.topic' = 'OPC_DRUG_PRESC_D_CHARGE_AfterData',
    'connector.startup-mode' = 'earliest-offset',
    'connector.properties.0.key' = 'zookeeper.connect',
    'connector.properties.0.value' = 'slave1:2181',
    'connector.properties.1.key' = 'bootstrap.servers',
    'connector.properties.1.value' = 'slave2:9092',
    'update-mode' = 'append',
    'format.type' = 'json',
    'format.derive-schema' = 'true'
);


CREATE TABLE metric (
    `identity` VARCHAR,
    `metric`   VARCHAR,
    `dt`       VARCHAR,
    `key`      VARCHAR,
    `value`    VARCHAR
) WITH (
    'connector.type' = 'jdbc',
    'connector.url' = 'jdbc:mysql://master:3306/flink-test?characterEncoding=utf-8',
    'connector.table' = 'metric',
    'connector.username' = 'hive',
    'connector.password' = '123456',
    'connector.write.flush.max-rows' = '1'
);



--药品费
INSERT INTO metric
SELECT
hh.health_service_org_id AS `identity`,
'Today_opc_ypf' AS metric,
SUBSTRING(hh.charge_date,0,19)  AS dt,
'今日门诊药品费' AS ky,
CAST(sum(dd.total_amt) AS VARCHAR) AS vl
FROM OPC_DRUG_PRESC_H_CHARGE hh
inner join OPC_DRUG_PRESC_D_CHARGE dd
on dd.drug_presc_h_charge_id=hh.id
WHERE TO_TIMESTAMP(SUBSTRING(hh.charge_date,0,19))<=CURRENT_TIMESTAMP
and hh.health_service_org_id in ('RSS20171211000000001')
GROUP BY hh.health_service_org_id,SUBSTRING(hh.charge_date,0,19);