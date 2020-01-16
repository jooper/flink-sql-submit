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



CREATE TABLE OPC_DIAG_SERVICE_H_CHARGE (
  id                     VARCHAR,
  opc_registration_id    VARCHAR,
  ordered_date           DATE,
  ordered_dept_id        VARCHAR,
  ordered_doctor_id      VARCHAR,
  s_kdxxly_dm            VARCHAR,
  appliction_no          VARCHAR,
  input_person_id        VARCHAR,
  input_date             TIMESTAMP,
  charge_dept_id         VARCHAR,
  charge_person_id       VARCHAR,
  charge_date            TIMESTAMP,
  diag_service_h_id      VARCHAR,
  settlement_times       INT,
  settlement_dept_id     VARCHAR,
  settlement_person_id   VARCHAR,
  settlement_date        DATE,
  ordered_area_id        VARCHAR,
  ordered_office_dept_id VARCHAR,
  patient_type_id        VARCHAR,
  insurance_area_code    VARCHAR,
  insurance_area_name    VARCHAR,
  op_dept_id             VARCHAR,
  op_person_id           VARCHAR,
  op_date                DATE,
  arrears_reason         VARCHAR,
  s_jmyy_dm              VARCHAR,
  exam_person_id         VARCHAR,
  is_eapp                VARCHAR,
  eapp_table_code        VARCHAR,
  health_service_org_id  VARCHAR,
  ivf_cmrs_id            VARCHAR,
  barcode_no             VARCHAR,
  oit_it_exec_id         VARCHAR,
  is_insin               VARCHAR,
  ordrset_no             VARCHAR,
  biz_btch_trans_no      VARCHAR
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


CREATE TABLE OPC_DIAG_SERVICE_H_CHARGE (
  id                           VARCHAR,
  charge_date                  DATE,
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



CREATE TABLE fee (
    account VARCHAR
) WITH (
    'connector.type' = 'jdbc',
    'connector.url' = 'jdbc:mysql://master:3306/flink-test',
    'connector.table' = 'fee',
    'connector.username' = 'hive',
    'connector.password' = '123456',
    'connector.write.flush.max-rows' = '1'
);



INSERT INTO fee
select d.total_amt zlf
from OPC_DIAG_SERVICE_H_CHARGE h
     inner join OPC_DIAG_SERVICE_D_CHARGE d on d.diag_service_h_charge_id=h.id
