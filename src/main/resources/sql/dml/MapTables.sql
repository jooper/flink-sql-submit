--对kafka进行表映射

CREATE TABLE PUB_HLLX (
  s_hllx_dm  VARCHAR,
  s_hllx_cmc VARCHAR,
  s_hllx_ebm VARCHAR,
  s_pyjm     VARCHAR,
  s_bz       VARCHAR
) WITH (
    'connector.type' = 'kafka',
    'connector.version' = 'universal',
    'connector.topic' = 'PUB_HLLX_AfterData',
    'connector.startup-mode' = 'earliest-offset',
    'connector.properties.0.key' = 'zookeeper.connect',
    'connector.properties.0.value' = 'slave1:2181',
    'connector.properties.1.key' = 'bootstrap.servers',
    'connector.properties.1.value' = 'slave2:9092',
    'update-mode' = 'append',
    'format.type' = 'json',
    'format.derive-schema' = 'true'
);




CREATE TABLE HRA00_DEPARTMENT (
  id                      VARCHAR,
  department_chinese_name VARCHAR
) WITH (
    'connector.type' = 'kafka',
    'connector.version' = 'universal',
    'connector.topic' = 'HRA00_DEPARTMENT_AfterData',
    'connector.startup-mode' = 'earliest-offset',
    'connector.properties.0.key' = 'zookeeper.connect',
    'connector.properties.0.value' = 'slave1:2181',
    'connector.properties.1.key' = 'bootstrap.servers',
    'connector.properties.1.value' = 'slave2:9092',
    'update-mode' = 'append',
    'format.type' = 'json',
    'format.derive-schema' = 'true'
);


CREATE TABLE IPI_REGISTRATION (
  dept_id                      VARCHAR,
  s_brztbh_dm                  VARCHAR,
  health_service_org_id        VARCHAR,
  s_hllx_dm                    VARCHAR
) WITH (
    'connector.type' = 'kafka',
    'connector.version' = 'universal',
    'connector.topic' = 'IPI_REGISTRATION_AfterData',
    'connector.startup-mode' = 'earliest-offset',
    'connector.properties.0.key' = 'zookeeper.connect',
    'connector.properties.0.value' = 'slave1:2181',
    'connector.properties.1.key' = 'bootstrap.servers',
    'connector.properties.1.value' = 'slave2:9092',
    'update-mode' = 'append',
    'format.type' = 'json',
    'format.derive-schema' = 'true'
);


--这个表的INTEGER 和 DATE数据类型
CREATE TABLE OPR_REGISTRATION (
  id                    VARCHAR,
  registration_date     DATE,
  refund                INT,
  s_brlx_dm             VARCHAR,
  registration_type     VARCHAR,
  health_service_org_id VARCHAR
) WITH (
    'connector.type' = 'kafka',
    'connector.version' = 'universal',
    'connector.topic' = 'OPR_REGISTRATION_AfterData',
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
  id                           VARCHAR,
  charge_date                  TIMESTAMP,
  health_service_org_id        VARCHAR
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



CREATE TABLE OPC_DRUG_PRESC_H_CHARGE (
  id                           VARCHAR,
  charge_date                  TIMESTAMP,
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



CREATE TABLE OPC_DIAG_SERVICE_D_CHARGE (
  diag_service_h_charge_id     VARCHAR,
  total_amt                  BIGINT
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
