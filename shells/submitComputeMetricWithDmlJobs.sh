#!/usr/bin/env bash
# 运行resource下的sql中的脚本，进行消费kafka中进行了ETL后的数据到mysql，在通过mysql的canal实时同步到kafka中，供ui的socketio访问

##今日门诊药品费
#./run.sh "METRIC_OPC_TODAY_DRUG_YPF_FEE" "Metric_Compute_Today_Drug_YP_FEE"
#
##今日门诊诊疗费
#./run.sh "METRIC_OPC_TODAY_DIAG_ZLF_FEE" "Metric_Compute_Today_Diag_ZL_FEE"



#今日门诊诊疗费、今日门诊药品费
./run.sh "METRIC_TODAY_ZLF_AND_YPF_FEE.sql" "Metric_Compute_TODAY_ZLF_AND_YPF_FEE"