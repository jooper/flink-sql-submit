#!/usr/bin/env bash

#生成表结构定义文件  废弃

ogg_home=/opt/ogg

echo "defsfile /opt/ogg/dirdef/test_ogg.test_ogg" >>${ogg_home}/dirprm/test_ogg.prm

echo "userid ogg,password ogg" >>${ogg_home}/dirprm/test_ogg.prm

echo "table test_ogg.test_ogg;" >>${ogg_home}/dirprm/test_ogg.prm

echo "table test_ogg.OPR_REGISTRATION;" >>${ogg_home}/dirprm/test_ogg.prm

echo "table test_ogg.OPC_DIAG_SERVICE_D_CHARGE;" >>${ogg_home}/dirprm/test_ogg.prm

echo "table test_ogg.OPC_DIAG_SERVICE_D_CHARGE;" >>${ogg_home}/dirprm/test_ogg.prm

echo "table test_ogg.opc_drug_presc_d_charge;" >>${ogg_home}/dirprm/test_ogg.prm

echo "table test_ogg.OPC_DRUG_PRESC_H_CHARGE;" >>${ogg_home}/dirprm/test_ogg.prm

echo "table test_ogg.OPC_DIAG_SERVICE_H_CHARGE;" >>${ogg_home}/dirprm/test_ogg.prm

echo "table test_ogg.IPI_REGISTRATION;" >>${ogg_home}/dirprm/test_ogg.prm

echo "table test_ogg.HRA00_DEPARTMENT;" >>${ogg_home}/dirprm/test_ogg.prm

echo "table test_ogg.PUB_HLLX;" >>${ogg_home}/dirprm/test_ogg.prm

echo "table test_ogg.OPR_REGISTRATION;" >>${ogg_home}/dirprm/test_ogg.prm

