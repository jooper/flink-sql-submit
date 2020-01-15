-- opr_registration
-- Create table
create table OPR_REGISTRATION
(
  id                             VARCHAR2(20) not null,
  person_info_id                 VARCHAR2(20),
  patient_name                   VARCHAR2(30),
  birthday                       DATE,
  s_nldw_dm                      VARCHAR2(3),
  age                            INTEGER,
  s_xb_dm                        VARCHAR2(1) not null,
  s_hyzk_dm                      VARCHAR2(2) not null,
  person_ident_id                VARCHAR2(20),
  patient_type_id                VARCHAR2(20),
  s_czbz_dm                      VARCHAR2(1) default '1',
  registration_date              DATE,
  total_receivable_amt           NUMBER(15,4),
  total_actual_amt               NUMBER(15,4),
  registration_way               VARCHAR2(2),
  refund                         INTEGER default 1 not null,
  health_service_org_id          VARCHAR2(20) default 'RSS20110919001863000' not null,
  department_id                  VARCHAR2(20),
  doctor_id                      VARCHAR2(20),
  clinic_dept_id                 VARCHAR2(20),
  diag_room_id                   VARCHAR2(20),
  registrator                    VARCHAR2(20),
  identity_no                    VARCHAR2(70),
  registration_type              VARCHAR2(20),
  opc_registration_no            VARCHAR2(12),
  is_discount                    CHAR(1),
  s_brlx_dm                      VARCHAR2(2),
  registration_num               INTEGER,
  duty_setting                   VARCHAR2(20),
  other_identity_no              VARCHAR2(30),
  arrangement_id                 VARCHAR2(20),
  regestration_out_type          CHAR(1) default '1',
  is_visit                       CHAR(1) default '2',
  visit_times                    INTEGER,
  is_subsidies                   CHAR(1) default '2',
  patient_caliber                VARCHAR2(20),
  queue_type_id                  VARCHAR2(20),
  dqc_message                    VARCHAR2(200),
  is_received_nonum_visit_regfee CHAR(1),
  is_see_doctor                  CHAR(1) default '1',
  s_jbfl_dm                      VARCHAR2(20),
  fin_cc_scheme_id               VARCHAR2(20),
  s_scqd_dm                      VARCHAR2(20),
  duty_date                      DATE not null,
  s_pkhsx_dm                     VARCHAR2(4),
  opd_sd_reg_id                  VARCHAR2(20),
  is_gcp                         CHAR(1),
  timerange                      VARCHAR2(32),
  back_cause                     VARCHAR2(20),
  is_jcs                         CHAR(1),
  opr_jcs_arr                    VARCHAR2(20),
  clin_area_id                   VARCHAR2(20),
  clindr_office_dept_id          VARCHAR2(20),
  s_ylfkfs_dm                    VARCHAR2(2),
  is_expert                      CHAR(1),
  hosp_ref_pers_id               VARCHAR2(20),
  sign_tm                        DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 8K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table OPR_REGISTRATION
  is '门急诊挂号登记主信息';
-- Add comments to the columns 
comment on column OPR_REGISTRATION.person_info_id
  is '如果是实名制就诊卡或有区域卫生信息平台接口的医院，则个人信息从区域平台取到个人基本信息表中来。
如果是临时卡、或无卡患者，本列内容为空';
comment on column OPR_REGISTRATION.registration_date
  is '记录挂号的时间';
comment on column OPR_REGISTRATION.total_receivable_amt
  is '应等于 挂号登记收费明细的收费标准之和';
comment on column OPR_REGISTRATION.total_actual_amt
  is '应该等于 本次挂号登记上收费明细的优惠后收费标准之和';
comment on column OPR_REGISTRATION.refund
  is '1 已挂号  2 已退号';
comment on column OPR_REGISTRATION.other_identity_no
  is '其他个体标识号-号码';
comment on column OPR_REGISTRATION.is_visit
  is '是否已就诊';
comment on column OPR_REGISTRATION.visit_times
  is '就诊次数';
comment on column OPR_REGISTRATION.is_subsidies
  is '是否补贴(医保)';
comment on column OPR_REGISTRATION.patient_caliber
  is '患者口径';
comment on column OPR_REGISTRATION.queue_type_id
  is '门诊分诊队列类型ID';
comment on column OPR_REGISTRATION.dqc_message
  is '分诊信息';
comment on column OPR_REGISTRATION.is_received_nonum_visit_regfee
  is '是否已收取无号就诊挂号费';
comment on column OPR_REGISTRATION.is_see_doctor
  is '是否就诊号,1/是，2/否';
comment on column OPR_REGISTRATION.s_jbfl_dm
  is '疾病分类代码';
comment on column OPR_REGISTRATION.duty_date
  is '就诊日期';
comment on column OPR_REGISTRATION.s_pkhsx_dm
  is '贫困户属性代码';
comment on column OPR_REGISTRATION.opd_sd_reg_id
  is '门特治疗登记ID';
comment on column OPR_REGISTRATION.is_gcp
  is '是否绿色通道患者';
comment on column OPR_REGISTRATION.timerange
  is '就诊时段';
comment on column OPR_REGISTRATION.back_cause
  is '退号原因';
comment on column OPR_REGISTRATION.is_jcs
  is '是否联合门诊
1  是
2  否';
comment on column OPR_REGISTRATION.opr_jcs_arr
  is '联合门诊排班-门急诊医生挂号排班映射ID';
comment on column OPR_REGISTRATION.clin_area_id
  is '临床院区ID';
comment on column OPR_REGISTRATION.clindr_office_dept_id
  is '临床医生任职科室ID';
comment on column OPR_REGISTRATION.s_ylfkfs_dm
  is '医疗付款方式代码';
comment on column OPR_REGISTRATION.is_expert
  is '是否专家号,1是、2否';
comment on column OPR_REGISTRATION.hosp_ref_pers_id
  is '医院推荐人ID';
comment on column OPR_REGISTRATION.sign_tm
  is '签到时间';










-- opc_drug_presc_h_charge
-- Create table
create table OPC_DRUG_PRESC_H_CHARGE
(
  id                     VARCHAR2(20) not null,
  opc_registration_id    VARCHAR2(20),
  ordered_date           DATE,
  ordered_dept_id        VARCHAR2(20),
  ordered_doctor_id      VARCHAR2(20),
  s_cflb_dm              VARCHAR2(2),
  s_cfsx_dm              VARCHAR2(2),
  s_kdxxly_dm            VARCHAR2(2),
  pharmacy_code          VARCHAR2(20),
  presc_no               VARCHAR2(20),
  input_person_id        VARCHAR2(20),
  input_date             TIMESTAMP(6),
  charge_dept_id         VARCHAR2(20) not null,
  charge_person_id       VARCHAR2(20),
  charge_date            TIMESTAMP(6),
  drug_presc_h_id        VARCHAR2(20),
  is_antibiosis_presc    CHAR(1),
  settlement_times       INTEGER,
  settlement_dept_id     VARCHAR2(20),
  settlement_person_id   VARCHAR2(20),
  settlement_date        DATE,
  ordered_area_id        VARCHAR2(20),
  ordered_office_dept_id VARCHAR2(20),
  patient_type_id        VARCHAR2(20),
  insurance_area_code    VARCHAR2(50),
  insurance_area_name    VARCHAR2(50),
  win_config_infoset     VARCHAR2(200),
  op_dept_id             VARCHAR2(20),
  op_person_id           VARCHAR2(20),
  op_date                DATE,
  arrears_reason         VARCHAR2(200),
  s_jmyy_dm              VARCHAR2(20),
  exam_person_id         VARCHAR2(20),
  health_service_org_id  VARCHAR2(20) default 'RSS20110919001863000',
  ivf_cmrs_id            VARCHAR2(32),
  is_nfd                 CHAR(1),
  is_insin               CHAR(1),
  is_external_fit        CHAR(1),
  is_cnv_presc           CHAR(1),
  ordrset_no             VARCHAR2(20),
  biz_btch_trans_no      VARCHAR2(32)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 8K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table OPC_DRUG_PRESC_H_CHARGE
  is '门急诊药品处方主档（结算）';
-- Add comments to the columns 
comment on column OPC_DRUG_PRESC_H_CHARGE.settlement_times
  is '结算次数';
comment on column OPC_DRUG_PRESC_H_CHARGE.settlement_dept_id
  is '结算科室ID';
comment on column OPC_DRUG_PRESC_H_CHARGE.settlement_person_id
  is '结算人ID';
comment on column OPC_DRUG_PRESC_H_CHARGE.settlement_date
  is '结算时间';
comment on column OPC_DRUG_PRESC_H_CHARGE.ordered_area_id
  is '开单院区ID';
comment on column OPC_DRUG_PRESC_H_CHARGE.ordered_office_dept_id
  is '开单者任职科室ID';
comment on column OPC_DRUG_PRESC_H_CHARGE.patient_type_id
  is '患者类型';
comment on column OPC_DRUG_PRESC_H_CHARGE.insurance_area_code
  is '医保区域代码';
comment on column OPC_DRUG_PRESC_H_CHARGE.insurance_area_name
  is '医保区域';
comment on column OPC_DRUG_PRESC_H_CHARGE.win_config_infoset
  is '发药窗口配置信息集';
comment on column OPC_DRUG_PRESC_H_CHARGE.op_dept_id
  is '操作科室ID';
comment on column OPC_DRUG_PRESC_H_CHARGE.op_person_id
  is '操作人ID';
comment on column OPC_DRUG_PRESC_H_CHARGE.op_date
  is '操作时间';
comment on column OPC_DRUG_PRESC_H_CHARGE.arrears_reason
  is '减免原因';
comment on column OPC_DRUG_PRESC_H_CHARGE.s_jmyy_dm
  is '减免原因代码';
comment on column OPC_DRUG_PRESC_H_CHARGE.exam_person_id
  is '审核人ID';
comment on column OPC_DRUG_PRESC_H_CHARGE.health_service_org_id
  is '医疗服务机构ID';
comment on column OPC_DRUG_PRESC_H_CHARGE.ivf_cmrs_id
  is 'IVF周期病历概要ID';
comment on column OPC_DRUG_PRESC_H_CHARGE.is_nfd
  is '是否护士取药';
comment on column OPC_DRUG_PRESC_H_CHARGE.is_insin
  is '是否医保内
1	是
2	否';
comment on column OPC_DRUG_PRESC_H_CHARGE.is_external_fit
  is '是否外配处方
1	是
2	否';
comment on column OPC_DRUG_PRESC_H_CHARGE.is_cnv_presc
  is '是否便民处方,1.是，2.否';
comment on column OPC_DRUG_PRESC_H_CHARGE.ordrset_no
  is '医嘱套序号';
comment on column OPC_DRUG_PRESC_H_CHARGE.biz_btch_trans_no
  is '业务同批次交易号';









  --opc_drug_presc_d_charge
  -- Create table
create table OPC_DRUG_PRESC_D_CHARGE
(
  id                      VARCHAR2(20) not null,
  drug_presc_h_charge_id  VARCHAR2(20),
  drug_id                 VARCHAR2(20) not null,
  drug_common_name        VARCHAR2(100) not null,
  specification           VARCHAR2(100) not null,
  single_dose_unit        VARCHAR2(4),
  single_dose             NUMBER(15,4),
  total_dose              NUMBER(15,4),
  use_way                 VARCHAR2(4),
  op_min_drug_unit        VARCHAR2(4),
  total_qty               NUMBER(15,4),
  total_amt               NUMBER(15,8),
  out_patient_charge_type VARCHAR2(2),
  invoice_no              VARCHAR2(20),
  checkout_vouchar_no     VARCHAR2(30),
  drug_presc_d_charge_id  VARCHAR2(20),
  copy_number             INTEGER,
  ddd_value               NUMBER(15,4),
  ddd_convert_value       NUMBER(15,4),
  s_yzpl_bm               VARCHAR2(4),
  drug_presc_d_id         VARCHAR2(20),
  discount_amt            NUMBER(15,8),
  his_trans_batch_no      VARCHAR2(100),
  trans_batch_no          VARCHAR2(100),
  s_srfl_dm               VARCHAR2(20),
  ordrset_id              VARCHAR2(20),
  ordrset_name            VARCHAR2(200),
  limit_entity_flag       CHAR(1),
  s_fbdj_dm               VARCHAR2(2),
  use_fee_lvl             VARCHAR2(2),
  price                   NUMBER(15,8),
  total_amt_real          NUMBER(15,8)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 8K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table OPC_DRUG_PRESC_D_CHARGE
  is '门急诊药品处方明细档（结算）';
-- Add comments to the columns 
comment on column OPC_DRUG_PRESC_D_CHARGE.specification
  is '对应药库单位的规格，比如药库单位为盒，则这里是 0.25mg*50，表明一盒50粒，每粒0.25mg';
comment on column OPC_DRUG_PRESC_D_CHARGE.single_dose_unit
  is '指医生开处方的时候用的单位，比如给患者说用药3天，每天吃 3次，每次 吃 1粒，则单次剂量就是一粒，如果是一粒=0.25mg.那么
上面的处方这样写：sig.  1粒 t.i.d 。或英文 sig. 0.25mg t.i.d   x 3 

单位一般是 粒、片、毫升、毫克。医生根据此单位开药';
comment on column OPC_DRUG_PRESC_D_CHARGE.op_min_drug_unit
  is '来自药品字典之门诊病人-最小发药单位';
comment on column OPC_DRUG_PRESC_D_CHARGE.discount_amt
  is '折扣金额';
comment on column OPC_DRUG_PRESC_D_CHARGE.his_trans_batch_no
  is 'HIS交易批次号（支付号）';
comment on column OPC_DRUG_PRESC_D_CHARGE.trans_batch_no
  is '交易批次号（支付号）';
comment on column OPC_DRUG_PRESC_D_CHARGE.s_srfl_dm
  is '收入分类代码';
comment on column OPC_DRUG_PRESC_D_CHARGE.ordrset_id
  is '医嘱套ID';
comment on column OPC_DRUG_PRESC_D_CHARGE.ordrset_name
  is '医嘱套名称';
comment on column OPC_DRUG_PRESC_D_CHARGE.limit_entity_flag
  is '限病种
1  是
2  否';
comment on column OPC_DRUG_PRESC_D_CHARGE.s_fbdj_dm
  is '费别等级代码（来自药品字典费别等级）';
comment on column OPC_DRUG_PRESC_D_CHARGE.use_fee_lvl
  is '使用费别等级（医生使用费别等级）';
comment on column OPC_DRUG_PRESC_D_CHARGE.price
  is '使用单价';
comment on column OPC_DRUG_PRESC_D_CHARGE.total_amt_real
  is '原始总费用';









--opc_diag_service_h_charge
  -- Create table
create table OPC_DIAG_SERVICE_H_CHARGE
(
  id                     VARCHAR2(20) not null,
  opc_registration_id    VARCHAR2(20),
  ordered_date           DATE,
  ordered_dept_id        VARCHAR2(20),
  ordered_doctor_id      VARCHAR2(20),
  s_kdxxly_dm            VARCHAR2(2),
  appliction_no          VARCHAR2(20),
  input_person_id        VARCHAR2(20),
  input_date             TIMESTAMP(6),
  charge_dept_id         VARCHAR2(20) not null,
  charge_person_id       VARCHAR2(20),
  charge_date            TIMESTAMP(6),
  diag_service_h_id      VARCHAR2(20),
  settlement_times       INTEGER,
  settlement_dept_id     VARCHAR2(20),
  settlement_person_id   VARCHAR2(20),
  settlement_date        DATE,
  ordered_area_id        VARCHAR2(20),
  ordered_office_dept_id VARCHAR2(20),
  patient_type_id        VARCHAR2(20),
  insurance_area_code    VARCHAR2(50),
  insurance_area_name    VARCHAR2(50),
  op_dept_id             VARCHAR2(20),
  op_person_id           VARCHAR2(20),
  op_date                DATE,
  arrears_reason         VARCHAR2(200),
  s_jmyy_dm              VARCHAR2(20),
  exam_person_id         VARCHAR2(20),
  is_eapp                CHAR(1),
  eapp_table_code        VARCHAR2(30),
  health_service_org_id  VARCHAR2(20) default 'RSS20110919001863000',
  ivf_cmrs_id            VARCHAR2(32),
  barcode_no             VARCHAR2(20),
  oit_it_exec_id         VARCHAR2(20),
  is_insin               CHAR(1),
  ordrset_no             VARCHAR2(20),
  biz_btch_trans_no      VARCHAR2(32)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 8K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table OPC_DIAG_SERVICE_H_CHARGE
  is '门急诊医疗服务项目主档（结算）';
-- Add comments to the columns 
comment on column OPC_DIAG_SERVICE_H_CHARGE.settlement_times
  is '结算次数';
comment on column OPC_DIAG_SERVICE_H_CHARGE.settlement_dept_id
  is '结算科室ID';
comment on column OPC_DIAG_SERVICE_H_CHARGE.settlement_person_id
  is '结算人ID';
comment on column OPC_DIAG_SERVICE_H_CHARGE.settlement_date
  is '结算时间';
comment on column OPC_DIAG_SERVICE_H_CHARGE.ordered_area_id
  is '开单院区ID';
comment on column OPC_DIAG_SERVICE_H_CHARGE.ordered_office_dept_id
  is '开单者任职科室ID';
comment on column OPC_DIAG_SERVICE_H_CHARGE.patient_type_id
  is '患者类型';
comment on column OPC_DIAG_SERVICE_H_CHARGE.insurance_area_code
  is '医保区域代码';
comment on column OPC_DIAG_SERVICE_H_CHARGE.insurance_area_name
  is '医保区域';
comment on column OPC_DIAG_SERVICE_H_CHARGE.op_dept_id
  is '操作科室ID';
comment on column OPC_DIAG_SERVICE_H_CHARGE.op_person_id
  is '操作人ID';
comment on column OPC_DIAG_SERVICE_H_CHARGE.op_date
  is '操作时间';
comment on column OPC_DIAG_SERVICE_H_CHARGE.arrears_reason
  is '减免原因';
comment on column OPC_DIAG_SERVICE_H_CHARGE.s_jmyy_dm
  is '减免原因代码';
comment on column OPC_DIAG_SERVICE_H_CHARGE.exam_person_id
  is '审核人ID';
comment on column OPC_DIAG_SERVICE_H_CHARGE.is_eapp
  is '是否来自电子申请单';
comment on column OPC_DIAG_SERVICE_H_CHARGE.eapp_table_code
  is '电子申请单主记录表代码';
comment on column OPC_DIAG_SERVICE_H_CHARGE.health_service_org_id
  is '医疗服务机构ID';
comment on column OPC_DIAG_SERVICE_H_CHARGE.ivf_cmrs_id
  is 'IVF周期病历概要ID';
comment on column OPC_DIAG_SERVICE_H_CHARGE.barcode_no
  is '分票条码号';
comment on column OPC_DIAG_SERVICE_H_CHARGE.oit_it_exec_id
  is '门急诊注射输液执行单ID';
comment on column OPC_DIAG_SERVICE_H_CHARGE.is_insin
  is '是否医保内
1	是
2	否';
comment on column OPC_DIAG_SERVICE_H_CHARGE.ordrset_no
  is '医嘱套序号';
comment on column OPC_DIAG_SERVICE_H_CHARGE.biz_btch_trans_no
  is '业务同批次交易号';












--opc_diag_service_d_charge

  -- Create table
create table OPC_DIAG_SERVICE_D_CHARGE
(
  id                       VARCHAR2(20) not null,
  diag_service_h_charge_id VARCHAR2(20),
  diag_item_id             VARCHAR2(20) not null,
  diag_item_cname          VARCHAR2(200),
  spec_name                VARCHAR2(50),
  charge_unit              VARCHAR2(4),
  total_qty                NUMBER(15,4),
  total_amt                NUMBER(15,8),
  package_id               VARCHAR2(20),
  package_cname            VARCHAR2(200),
  exec_dept_id             VARCHAR2(20),
  exec_person_id           VARCHAR2(20),
  out_patient_charge_type  VARCHAR2(2),
  invoice_no               VARCHAR2(20),
  checkout_vouchar_no      VARCHAR2(30),
  diag_service_d_charge_id VARCHAR2(20),
  package_qty              INTEGER,
  opc_diag_service_d_id    VARCHAR2(20),
  primary_barcode          VARCHAR2(100),
  trace_barcode            VARCHAR2(100),
  ext_trans_code           VARCHAR2(30),
  discount_amt             NUMBER(15,8),
  pem_exam_chargeitem_id   VARCHAR2(20),
  is_skin_test_fee         CHAR(1),
  use_mat_code             VARCHAR2(32),
  eapp_d_id                VARCHAR2(32),
  exec_date                DATE,
  his_trans_batch_no       VARCHAR2(100),
  is_post_inhosp           CHAR(1),
  s_srfl_dm                VARCHAR2(20),
  ordrset_id               VARCHAR2(20),
  ordrset_name             VARCHAR2(200),
  op_desc                  VARCHAR2(200),
  op_pers_id               VARCHAR2(20),
  op_asst_i_pers_id        VARCHAR2(20),
  op_asst_ii_pers_id       VARCHAR2(20),
  op_kpi                   NUMBER(15,4),
  op_asst_i_kpi            NUMBER(15,4),
  op_asst_ii_kpi           NUMBER(15,4),
  s_fbdj_dm                VARCHAR2(2),
  use_fee_lvl              VARCHAR2(2),
  op_asst_iii_pers_id      VARCHAR2(20),
  op_asst_iv_pers_id       VARCHAR2(20),
  op_asst_iii_kpi          NUMBER(15,4),
  op_asst_iv_kpi           NUMBER(15,4),
  price                    NUMBER(15,8),
  total_amt_real           NUMBER(15,8),
  data_source              VARCHAR2(100)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 192K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table OPC_DIAG_SERVICE_D_CHARGE
  is '门急诊医疗服务项目明细档（结算）';
-- Add comments to the columns 
comment on column OPC_DIAG_SERVICE_D_CHARGE.diag_item_cname
  is '会计科目代码编码规则 4-2-2-2-2，参考2011最新医院会计制度';
comment on column OPC_DIAG_SERVICE_D_CHARGE.charge_unit
  is '药库药品采购入库时，以计算零售价的单位，如：盒、瓶等';
comment on column OPC_DIAG_SERVICE_D_CHARGE.opc_diag_service_d_id
  is '门急诊医疗服务项目明细档ID';
comment on column OPC_DIAG_SERVICE_D_CHARGE.primary_barcode
  is '主条码';
comment on column OPC_DIAG_SERVICE_D_CHARGE.trace_barcode
  is '追溯码';
comment on column OPC_DIAG_SERVICE_D_CHARGE.ext_trans_code
  is '外部交易码';
comment on column OPC_DIAG_SERVICE_D_CHARGE.discount_amt
  is '折扣金额';
comment on column OPC_DIAG_SERVICE_D_CHARGE.pem_exam_chargeitem_id
  is '体检分检项目ID';
comment on column OPC_DIAG_SERVICE_D_CHARGE.is_skin_test_fee
  is '是否皮试费用
1	是
2	否';
comment on column OPC_DIAG_SERVICE_D_CHARGE.use_mat_code
  is '使用材料编码';
comment on column OPC_DIAG_SERVICE_D_CHARGE.eapp_d_id
  is '电子申请单明细记录ID';
comment on column OPC_DIAG_SERVICE_D_CHARGE.exec_date
  is '执行时间';
comment on column OPC_DIAG_SERVICE_D_CHARGE.his_trans_batch_no
  is 'HIS交易批次号（支付号）';
comment on column OPC_DIAG_SERVICE_D_CHARGE.is_post_inhosp
  is '是否过账到住院
1  是
2  否';
comment on column OPC_DIAG_SERVICE_D_CHARGE.s_srfl_dm
  is '收入分类代码';
comment on column OPC_DIAG_SERVICE_D_CHARGE.ordrset_id
  is '医嘱套ID';
comment on column OPC_DIAG_SERVICE_D_CHARGE.ordrset_name
  is '医嘱套名称';
comment on column OPC_DIAG_SERVICE_D_CHARGE.op_desc
  is '手术及操作描述';
comment on column OPC_DIAG_SERVICE_D_CHARGE.op_pers_id
  is '手术及操作医师-术者';
comment on column OPC_DIAG_SERVICE_D_CHARGE.op_asst_i_pers_id
  is '手术及操作医师-I助';
comment on column OPC_DIAG_SERVICE_D_CHARGE.op_asst_ii_pers_id
  is '手术及操作医师-II助';
comment on column OPC_DIAG_SERVICE_D_CHARGE.op_kpi
  is '手术及操作医师-术者-绩效系数';
comment on column OPC_DIAG_SERVICE_D_CHARGE.op_asst_i_kpi
  is '手术及操作医师-I助-绩效系数';
comment on column OPC_DIAG_SERVICE_D_CHARGE.op_asst_ii_kpi
  is '手术及操作医师-II助-绩效系数';
comment on column OPC_DIAG_SERVICE_D_CHARGE.s_fbdj_dm
  is '费别等级代码（来自诊疗项目字典的费别等级）';
comment on column OPC_DIAG_SERVICE_D_CHARGE.use_fee_lvl
  is '使用费别等级（医生使用费别等级）';
comment on column OPC_DIAG_SERVICE_D_CHARGE.op_asst_iii_pers_id
  is '手术及操作医师-III助';
comment on column OPC_DIAG_SERVICE_D_CHARGE.op_asst_iv_pers_id
  is '手术及操作医师-IV助';
comment on column OPC_DIAG_SERVICE_D_CHARGE.op_asst_iii_kpi
  is '手术及操作医师-III助-绩效系数';
comment on column OPC_DIAG_SERVICE_D_CHARGE.op_asst_iv_kpi
  is '手术及操作医师-IV助-绩效系数';
comment on column OPC_DIAG_SERVICE_D_CHARGE.price
  is '使用单价';
comment on column OPC_DIAG_SERVICE_D_CHARGE.total_amt_real
  is '原始总费用';
comment on column OPC_DIAG_SERVICE_D_CHARGE.data_source
  is '数据来源';













  --ipi_registration
  -- Create table
create table IPI_REGISTRATION
(
  id                      VARCHAR2(20) not null,
  person_info_id          VARCHAR2(20) not null,
  patient_name            VARCHAR2(50),
  birthday                DATE,
  s_nldw_dm               VARCHAR2(3),
  age                     INTEGER,
  s_xb_dm                 VARCHAR2(1) not null,
  s_hyzk_dm               VARCHAR2(2) not null,
  person_ident_id         VARCHAR2(20),
  patient_type_id         VARCHAR2(20) not null,
  s_czbz_dm               VARCHAR2(1) default '1',
  health_service_org_id   VARCHAR2(20) default 'RSS20110919001863000' not null,
  registration_person_id  VARCHAR2(20),
  registration_date       DATE,
  opc_registration_id     VARCHAR2(20),
  opc_dept_id             VARCHAR2(20),
  clinic_dept_id          VARCHAR2(20),
  opc_doctor_id           VARCHAR2(20),
  ipi_dept_id             VARCHAR2(20) not null,
  ipi_doctor_id           VARCHAR2(20) not null,
  dept_id                 VARCHAR2(20),
  dept_director_id        VARCHAR2(20),
  doctor_id               VARCHAR2(20),
  nurse_id                VARCHAR2(20),
  bed_id                  VARCHAR2(20),
  bed_no                  VARCHAR2(10),
  s_hllx_dm               VARCHAR2(1),
  s_hldj_dm               VARCHAR2(1),
  ipi_registration_no     VARCHAR2(11),
  health_insurance_id     VARCHAR2(20),
  pre_service_date        DATE,
  is_newbom_baby          CHAR(1),
  is_baby_detained        CHAR(1),
  baby_link_ipi_no        VARCHAR2(20),
  s_brztbh_dm             VARCHAR2(2),
  d_brztbh_sj             DATE,
  discharge_date          DATE,
  first_insection_date    DATE,
  s_ryqk_dm               VARCHAR2(2),
  s_rytj_dm               VARCHAR2(2),
  total_charge_amt        NUMBER(15,8) not null,
  total_prepay_amt        NUMBER(15,8) not null,
  newbom_baby_aw          NUMBER(10),
  newbom_baby_bw          NUMBER(10),
  settlement_times        INTEGER not null,
  insurance_area_code     VARCHAR2(50),
  insurance_area_name     VARCHAR2(50),
  s_cyqk_dm               VARCHAR2(2),
  identity_no             VARCHAR2(70),
  inpatient_area          VARCHAR2(20),
  leave_dept_date         DATE,
  s_ybzt_dm               VARCHAR2(4),
  birthplace_province     VARCHAR2(30),
  birthplace_city         VARCHAR2(30),
  birthplace_area         VARCHAR2(30),
  nativeplace_province    VARCHAR2(30),
  nativeplace_city        VARCHAR2(30),
  current_province        VARCHAR2(30),
  current_city            VARCHAR2(30),
  current_area            VARCHAR2(30),
  current_address         VARCHAR2(200),
  current_tel             VARCHAR2(50),
  current_post            VARCHAR2(6),
  regplace_province       VARCHAR2(30),
  regplace_city           VARCHAR2(30),
  regplace_area           VARCHAR2(30),
  regplace_address        VARCHAR2(200),
  regplace_post           VARCHAR2(6),
  workunit_address        VARCHAR2(200),
  workunit_tel            VARCHAR2(50),
  workunit_post           VARCHAR2(6),
  linkman_name            VARCHAR2(30),
  linkman_relation        VARCHAR2(30),
  linkman_address         VARCHAR2(200),
  linkman_tel             VARCHAR2(50),
  transfusion_charge_date DATE,
  remark                  VARCHAR2(400),
  s_gjhdq_dm              VARCHAR2(3),
  s_grsf_dm               VARCHAR2(2),
  s_ylfkfs_dm             VARCHAR2(2),
  ipi_reg_certificate_id  VARCHAR2(20),
  ipi_reg_app_id          VARCHAR2(20),
  is_pregnancy            CHAR(1),
  is_gcp                  CHAR(1),
  age_hh                  INTEGER,
  age_ss                  INTEGER,
  is_bed_sharing          CHAR(1),
  is_newbom_baby_mother   CHAR(1),
  is_after_settlement     CHAR(1),
  s_hzqk_dm               VARCHAR2(1),
  version                 INTEGER default 0,
  gab                     NUMBER(3),
  bbl                     NUMBER(5,1),
  midwife_id              VARCHAR2(20),
  clinic_group_id         VARCHAR2(20),
  migrate_sys_id          VARCHAR2(32),
  is_self_settlement      CHAR(1),
  s_pkhsx_dm              VARCHAR2(4),
  s_gllx_dm               VARCHAR2(2),
  head_nurse_id           VARCHAR2(20),
  is_gc                   CHAR(1),
  is_psycho               CHAR(1),
  this_year_times         INTEGER,
  is_opsa_into            CHAR(1),
  is_isa                  CHAR(1),
  is_daytime              CHAR(1),
  s_jbfl_dm               VARCHAR2(20),
  cur_mrb                 VARCHAR2(20),
  s_scqd_dm               VARCHAR2(20),
  workunit_province       VARCHAR2(20),
  workunit_city           VARCHAR2(20),
  workunit_area           VARCHAR2(20),
  workunit                VARCHAR2(140),
  nativeplace_area        VARCHAR2(20),
  inhospital_times        INTEGER,
  case_serialnumber       VARCHAR2(32),
  inhosp_way_othr         VARCHAR2(100),
  othr_hso_xfer           VARCHAR2(100),
  insection_dept_id       VARCHAR2(20),
  insection_user_id       VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table IPI_REGISTRATION
  is '住院病人临床服务登记';
-- Add comments to the columns 
comment on column IPI_REGISTRATION.person_info_id
  is '如果是实名制就诊卡或有区域卫生信息平台接口的医院，则个人信息从区域平台取到个人基本信息表中来。
如果是临时卡、或无卡患者，本列内容为空';
comment on column IPI_REGISTRATION.registration_date
  is '记录挂号的时间';
comment on column IPI_REGISTRATION.is_newbom_baby
  is '患者是否为婴儿';
comment on column IPI_REGISTRATION.is_baby_detained
  is '说明婴儿在母亲离院后是否被留下';
comment on column IPI_REGISTRATION.s_brztbh_dm
  is '病人状态变化代码';
comment on column IPI_REGISTRATION.discharge_date
  is '出院或离开时间';
comment on column IPI_REGISTRATION.first_insection_date
  is '首次入科时间';
comment on column IPI_REGISTRATION.s_ryqk_dm
  is '入院情况代码';
comment on column IPI_REGISTRATION.s_rytj_dm
  is '入院途径代码';
comment on column IPI_REGISTRATION.transfusion_charge_date
  is '输液计费时间';
comment on column IPI_REGISTRATION.age_hh
  is '年龄时间（HH），小时';
comment on column IPI_REGISTRATION.age_ss
  is '年龄时间（SS），分钟';
comment on column IPI_REGISTRATION.is_bed_sharing
  is '是否母婴同床';
comment on column IPI_REGISTRATION.is_newbom_baby_mother
  is '是否新生儿母亲';
comment on column IPI_REGISTRATION.is_after_settlement
  is '是否后结算,若不参与控制欠费';
comment on column IPI_REGISTRATION.s_hzqk_dm
  is '患者情况代码';
comment on column IPI_REGISTRATION.gab
  is '出生孕周（d）';
comment on column IPI_REGISTRATION.bbl
  is '出生身长（cm）';
comment on column IPI_REGISTRATION.midwife_id
  is '接生人员ID';
comment on column IPI_REGISTRATION.clinic_group_id
  is '临床组ID';
comment on column IPI_REGISTRATION.migrate_sys_id
  is '迁移系统ID，原系统住院登记业务ID';
comment on column IPI_REGISTRATION.is_self_settlement
  is '是否允许自助结算';
comment on column IPI_REGISTRATION.s_pkhsx_dm
  is '贫困户属性代码';
comment on column IPI_REGISTRATION.s_gllx_dm
  is '隔离类型代码';
comment on column IPI_REGISTRATION.head_nurse_id
  is '护士长ID';
comment on column IPI_REGISTRATION.is_gc
  is '是否绿色通道
1  是
2  否';
comment on column IPI_REGISTRATION.is_psycho
  is '是否精神病患者
1  是
2  否';
comment on column IPI_REGISTRATION.this_year_times
  is '本年度住院次数';
comment on column IPI_REGISTRATION.is_opsa_into
  is '是否有门诊结清费用转入
1  是
2  否';
comment on column IPI_REGISTRATION.is_isa
  is '是否一体化结算
1  是
2  否';
comment on column IPI_REGISTRATION.is_daytime
  is '是否日间手术
1	是
2	否';
comment on column IPI_REGISTRATION.s_jbfl_dm
  is '疾病分类代码';
comment on column IPI_REGISTRATION.cur_mrb
  is '当前多重耐药菌';
comment on column IPI_REGISTRATION.s_scqd_dm
  is '市场渠道代码';
comment on column IPI_REGISTRATION.workunit_province
  is '工作单位地址-省（自治区、直辖市）';
comment on column IPI_REGISTRATION.workunit_city
  is '工作单位地址-市（地区）';
comment on column IPI_REGISTRATION.workunit_area
  is '工作单位地址-县（区）';
comment on column IPI_REGISTRATION.workunit
  is '工作单位';
comment on column IPI_REGISTRATION.nativeplace_area
  is '籍贯地-县（区）';
comment on column IPI_REGISTRATION.inhospital_times
  is '住院次数';
comment on column IPI_REGISTRATION.case_serialnumber
  is '病案号';
comment on column IPI_REGISTRATION.inhosp_way_othr
  is '入院途径-其他描述';
comment on column IPI_REGISTRATION.othr_hso_xfer
  is '其他医疗机构转入';
comment on column IPI_REGISTRATION.insection_dept_id
  is '首次入科科室ID';
comment on column IPI_REGISTRATION.insection_user_id
  is '首次入科人ID';










  --hra00_department
-- Create table
create table HRA00_DEPARTMENT
(
  id                      VARCHAR2(20) not null,
  parent_id               VARCHAR2(20) not null,
  department_code         VARCHAR2(10),
  health_servie_org       VARCHAR2(20),
  department_chinese_name VARCHAR2(50),
  department_english_name VARCHAR2(100),
  department_abbreviation VARCHAR2(30),
  input_code              VARCHAR2(20),
  department_type         VARCHAR2(3),
  nationality_area        VARCHAR2(3),
  legal_reprentative      VARCHAR2(30),
  administrative_area     VARCHAR2(20),
  s_xzqh_dm               VARCHAR2(6),
  department_rank         VARCHAR2(3),
  department_nature       VARCHAR2(3),
  sort_order              NUMBER(8),
  remark                  VARCHAR2(200),
  child_count             INTEGER,
  full_path               VARCHAR2(400 CHAR),
  hospital_area           VARCHAR2(20),
  department_nature_name  VARCHAR2(50),
  hospital_area_name      VARCHAR2(50),
  op_income_dept_id       VARCHAR2(20),
  ip_income_dept_id       VARCHAR2(20),
  opr_add_expense         NUMBER(15,4),
  s_brlx_dm               VARCHAR2(2),
  is_kdks_psyp            CHAR(1) default '2' not null,
  clinic_dept_id          VARCHAR2(20),
  hqms_code               VARCHAR2(20),
  is_emergency_open       CHAR(1) default '2' not null,
  s_yyjb_dm               VARCHAR2(2),
  is_vaild                CHAR(1) default '1',
  is_accompany            CHAR(1) default '2',
  reg_date                DATE,
  expiry_date             DATE,
  create_person_id        VARCHAR2(20),
  create_date             DATE,
  gc_lii                  VARCHAR2(12),
  gc_lat                  VARCHAR2(12),
  s_jbfl_dm               VARCHAR2(20),
  is_oper_dept            CHAR(1) default '2',
  regnum_rule             VARCHAR2(2000),
  clin_type               VARCHAR2(4),
  mnd_code                VARCHAR2(32),
  seedr_note              VARCHAR2(800),
  is_open_smwh            CHAR(1) default '2',
  def_smwh                VARCHAR2(20),
  is_bed_ecg              CHAR(1),
  is_consult              CHAR(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table HRA00_DEPARTMENT
  is '单位内建机构（科室）';
-- Add comments to the columns 
comment on column HRA00_DEPARTMENT.s_xzqh_dm
  is '行政区划代码（县级及以上）';
comment on column HRA00_DEPARTMENT.hospital_area
  is '数据来源V_HOSPITAL_AREA';
comment on column HRA00_DEPARTMENT.is_kdks_psyp
  is '发药是否按开单科室配送药品';
comment on column HRA00_DEPARTMENT.is_accompany
  is '是否陪检';
comment on column HRA00_DEPARTMENT.reg_date
  is '注册日期';
comment on column HRA00_DEPARTMENT.expiry_date
  is '截止日期';
comment on column HRA00_DEPARTMENT.create_person_id
  is '创建人';
comment on column HRA00_DEPARTMENT.create_date
  is '创建日期';
comment on column HRA00_DEPARTMENT.gc_lii
  is '地理坐标-经度';
comment on column HRA00_DEPARTMENT.gc_lat
  is '地理坐标-纬度';
comment on column HRA00_DEPARTMENT.s_jbfl_dm
  is '疾病分类代码';
comment on column HRA00_DEPARTMENT.is_oper_dept
  is '是否手术科室
1  是
2  否';
comment on column HRA00_DEPARTMENT.regnum_rule
  is '挂号约束规则，Groovy写约束规则的算法代码';
comment on column HRA00_DEPARTMENT.clin_type
  is '临床类别

1.1  中医
1.2  民族医
2  中西医
3  西医';
comment on column HRA00_DEPARTMENT.mnd_code
  is '监测网络科室编码';
comment on column HRA00_DEPARTMENT.seedr_note
  is '就医注意事项';
comment on column HRA00_DEPARTMENT.is_open_smwh
  is '是否开通二级物资库房

1  是
2  否';
comment on column HRA00_DEPARTMENT.def_smwh
  is '默认二级物资库房';
comment on column HRA00_DEPARTMENT.is_bed_ecg
  is '是否开通床旁心电图

1  是
2  否';
comment on column HRA00_DEPARTMENT.is_consult
  is '是否开放会诊,1.是/2.否';











--pub_hllx
-- Create table
create table PUB_HLLX
(
  s_hllx_dm  VARCHAR2(1) not null,
  s_hllx_cmc VARCHAR2(50),
  s_hllx_ebm VARCHAR2(100),
  s_pyjm     VARCHAR2(20),
  s_bz       VARCHAR2(200)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table PUB_HLLX
  is '护理类型代码';
-- Add comments to the columns 
comment on column PUB_HLLX.s_hllx_dm
  is '护理类型代码';
comment on column PUB_HLLX.s_hllx_cmc
  is '护理类型中文名称';
comment on column PUB_HLLX.s_hllx_ebm
  is '护理类型英文名称';
comment on column PUB_HLLX.s_pyjm
  is '拼音简码';
comment on column PUB_HLLX.s_bz
  is '备注';





-- Create table
create table IPI_REGISTRATION
(
  id                      VARCHAR2(20) not null,
  person_info_id          VARCHAR2(20),
  patient_name            VARCHAR2(30),
  birthday                DATE,
  s_nldw_dm               VARCHAR2(3),
  age                     INTEGER,
  s_xb_dm                 VARCHAR2(1) not null,
  s_hyzk_dm               VARCHAR2(2) not null,
  person_ident_id         VARCHAR2(20),
  patient_type_id         VARCHAR2(20) not null,
  s_czbz_dm               VARCHAR2(1) default '1',
  health_service_org_id   VARCHAR2(20) not null,
  registration_person_id  VARCHAR2(20),
  registration_date       DATE,
  opc_registration_id     VARCHAR2(20),
  opc_dept_id             VARCHAR2(20),
  clinic_dept_id          VARCHAR2(20),
  opc_doctor_id           VARCHAR2(20),
  ipi_dept_id             VARCHAR2(20),
  ipi_doctor_id           VARCHAR2(20),
  dept_id                 VARCHAR2(20),
  dept_director_id        VARCHAR2(20),
  doctor_id               VARCHAR2(20),
  nurse_id                VARCHAR2(20),
  bed_id                  VARCHAR2(20),
  bed_no                  VARCHAR2(10),
  s_hllx_dm               VARCHAR2(1),
  s_hldj_dm               VARCHAR2(1),
  ipi_registration_no     VARCHAR2(11) not null,
  health_insurance_id     VARCHAR2(20),
  pre_service_date        DATE,
  is_newbom_baby          CHAR(1),
  is_baby_detained        CHAR(1),
  baby_link_ipi_no        VARCHAR2(20),
  s_brztbh_dm             VARCHAR2(2),
  d_brztbh_sj             DATE,
  discharge_date          DATE,
  first_insection_date    DATE,
  s_ryqk_dm               VARCHAR2(2),
  s_rytj_dm               VARCHAR2(2),
  total_charge_amt        NUMBER(15,8) not null,
  total_prepay_amt        NUMBER(15,8),
  newbom_baby_aw          NUMBER(10),
  newbom_baby_bw          NUMBER(10),
  settlement_times        INTEGER not null,
  insurance_area_code     VARCHAR2(50),
  insurance_area_name     VARCHAR2(50),
  s_cyqk_dm               VARCHAR2(2),
  identity_no             VARCHAR2(30),
  inpatient_area          VARCHAR2(20),
  leave_dept_date         DATE,
  s_ybzt_dm               VARCHAR2(4),
  birthplace_province     VARCHAR2(30),
  birthplace_city         VARCHAR2(30),
  birthplace_area         VARCHAR2(30),
  nativeplace_province    VARCHAR2(30),
  nativeplace_city        VARCHAR2(30),
  current_province        VARCHAR2(30),
  current_city            VARCHAR2(30),
  current_area            VARCHAR2(30),
  current_address         VARCHAR2(200),
  current_tel             VARCHAR2(50),
  current_post            VARCHAR2(6),
  regplace_province       VARCHAR2(30),
  regplace_city           VARCHAR2(30),
  regplace_area           VARCHAR2(30),
  regplace_address        VARCHAR2(200),
  regplace_post           VARCHAR2(6),
  workunit_address        VARCHAR2(200),
  workunit_tel            VARCHAR2(50),
  workunit_post           VARCHAR2(6),
  linkman_name            VARCHAR2(30),
  linkman_relation        VARCHAR2(30),
  linkman_address         VARCHAR2(200),
  linkman_tel             VARCHAR2(50),
  transfusion_charge_date DATE,
  remark                  VARCHAR2(400),
  s_gjhdq_dm              VARCHAR2(3),
  s_grsf_dm               VARCHAR2(2),
  s_ylfkfs_dm             VARCHAR2(2),
  ipi_reg_certificate_id  VARCHAR2(20),
  ipi_reg_app_id          VARCHAR2(20),
  is_pregnancy            CHAR(1),
  is_gcp                  CHAR(1),
  age_hh                  INTEGER,
  age_ss                  INTEGER,
  is_newbom_baby_mother   CHAR(1),
  is_after_settlement     CHAR(1),
  is_bed_sharing          CHAR(1),
  s_hzqk_dm               VARCHAR2(1),
  version                 INTEGER,
  gab                     NUMBER(3),
  bbl                     NUMBER(5,1),
  midwife_id              VARCHAR2(20),
  migrate_sys_id          VARCHAR2(32),
  clinic_group_id         VARCHAR2(20),
  is_self_settlement      CHAR(1),
  s_gllx_dm               VARCHAR2(1),
  s_pkhsx_dm              VARCHAR2(4),
  head_nurse_id           VARCHAR2(20),
  is_gc                   CHAR(1),
  is_opsa_into            CHAR(1),
  is_isa                  CHAR(1),
  is_psycho               CHAR(1),
  this_year_times         INTEGER,
  is_daytime              CHAR(1),
  s_scqd_dm               VARCHAR2(20),
  cur_mrb                 VARCHAR2(200),
  workunit_province       VARCHAR2(20),
  workunit_city           VARCHAR2(20),
  workunit_area           VARCHAR2(20),
  workunit                VARCHAR2(140),
  nativeplace_area        VARCHAR2(20),
  inhosp_way_othr         VARCHAR2(100),
  othr_hso_xfer           VARCHAR2(100),
  insection_dept_id       VARCHAR2(20),
  insection_user_id       VARCHAR2(20),
  inhospital_times        INTEGER,
  case_serialnumber       VARCHAR2(32),
  linkman_idtype          VARCHAR2(2),
  linkman_idcard          VARCHAR2(30)
)
tablespace WENJ
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table
comment on table IPI_REGISTRATION
  is '住院病人临床服务登记';
-- Add comments to the columns
comment on column IPI_REGISTRATION.person_info_id
  is '如果是实名制就诊卡或有区域卫生信息平台接口的医院，则个人信息从区域平台取到个人基本信息表中来。
如果是临时卡、或无卡患者，本列内容为空';
comment on column IPI_REGISTRATION.registration_date
  is '记录挂号的时间';
comment on column IPI_REGISTRATION.is_newbom_baby
  is '患者是否为婴儿';
comment on column IPI_REGISTRATION.is_baby_detained
  is '说明婴儿在母亲离院后是否被留下';
comment on column IPI_REGISTRATION.s_brztbh_dm
  is '病人状态变化代码';
comment on column IPI_REGISTRATION.discharge_date
  is '出院或离开时间';
comment on column IPI_REGISTRATION.first_insection_date
  is '首次入科时间';
comment on column IPI_REGISTRATION.s_ryqk_dm
  is '入院情况代码';
comment on column IPI_REGISTRATION.s_rytj_dm
  is '入院途径代码';
comment on column IPI_REGISTRATION.transfusion_charge_date
  is '输液计费时间';
comment on column IPI_REGISTRATION.age_hh
  is '年龄时间（HH），小时';
comment on column IPI_REGISTRATION.age_ss
  is '年龄时间（SS），分钟';
comment on column IPI_REGISTRATION.is_newbom_baby_mother
  is '是否新生儿母亲';
comment on column IPI_REGISTRATION.is_after_settlement
  is '是否后结算,若不参与控制欠费';
comment on column IPI_REGISTRATION.is_bed_sharing
  is '是否母婴同床';
comment on column IPI_REGISTRATION.s_hzqk_dm
  is '患者情况代码';
comment on column IPI_REGISTRATION.gab
  is '出生孕周（d）';
comment on column IPI_REGISTRATION.bbl
  is '出生身长（cm）';
comment on column IPI_REGISTRATION.midwife_id
  is '接生人员ID';
comment on column IPI_REGISTRATION.migrate_sys_id
  is '迁移系统ID，原系统住院登记业务ID';
comment on column IPI_REGISTRATION.clinic_group_id
  is '临床组ID';
comment on column IPI_REGISTRATION.is_self_settlement
  is '是否允许自助结算';
comment on column IPI_REGISTRATION.s_gllx_dm
  is '隔离类型代码';
comment on column IPI_REGISTRATION.s_pkhsx_dm
  is '贫困户属性代码';
comment on column IPI_REGISTRATION.head_nurse_id
  is '护士长ID';
comment on column IPI_REGISTRATION.is_gc
  is '是否绿色通道
1  是
2  否';
comment on column IPI_REGISTRATION.is_opsa_into
  is '是否有门诊结清费用转入
1  是
2  否';
comment on column IPI_REGISTRATION.is_isa
  is '是否一体化结算
1  是
2  否';
comment on column IPI_REGISTRATION.is_psycho
  is '是否精神病患者
1  是
2  否';
comment on column IPI_REGISTRATION.this_year_times
  is '本年度住院次数';
comment on column IPI_REGISTRATION.is_daytime
  is '是否日间手术
1	是
2	否';
comment on column IPI_REGISTRATION.s_scqd_dm
  is '市场渠道代码';
comment on column IPI_REGISTRATION.cur_mrb
  is '当前多重耐药菌';
comment on column IPI_REGISTRATION.workunit_province
  is '工作单位地址-省（自治区、直辖市）';
comment on column IPI_REGISTRATION.workunit_city
  is '工作单位地址-市（地区）';
comment on column IPI_REGISTRATION.workunit_area
  is '工作单位地址-县（区）';
comment on column IPI_REGISTRATION.workunit
  is '工作单位';
comment on column IPI_REGISTRATION.nativeplace_area
  is '籍贯地-县（区）';
comment on column IPI_REGISTRATION.inhosp_way_othr
  is '入院途径-其他描述';
comment on column IPI_REGISTRATION.othr_hso_xfer
  is '其他医疗机构转入';
comment on column IPI_REGISTRATION.insection_dept_id
  is '首次入科科室ID';
comment on column IPI_REGISTRATION.insection_user_id
  is '首次入科人ID';
comment on column IPI_REGISTRATION.inhospital_times
  is '住院次数';
comment on column IPI_REGISTRATION.case_serialnumber
  is '病案号';
comment on column IPI_REGISTRATION.linkman_idtype
  is '联系人身份证件类别';
comment on column IPI_REGISTRATION.linkman_idcard
  is '联系人身份证件号码';
-- Create/Recreate indexes
