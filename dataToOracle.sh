#!/bin/bash
# 传入参数1.数据表名，2.逗号分隔数据文件
#use case : sh dataToOracle.sh test_ogg ./src/main/resources/oracle_mock_data.log

conn=test_ogg/test_ogg@10.158.5.84:1521/oracle
# 连接中要替换成你自己的Oracle用户名和密码，默认实例名为orcl如果你更改了也需要替换
export NLS_LANG="SIMPLIFIED CHINESE_CHINA.AL32UTF8"
table_name="$1"
data_file="$2"

function exec_sql() {

	local sql=${1}
	local result=''

	if [ ! -z "${sql}" ]; then
		result=$(
			sqlplus -s /nolog <<EOF
			set echo off feedback off heading off underline off;
			conn $conn;
			${sql}
			commit;
			exit;
EOF
		)
	fi
	echo ${result}
}

function main() {
	local check_table_sql="select table_name from user_tables where table_name = '${table_name}';"
	echo "sql excute :$check_table_sql"
	local res=$(exec_sql ${check_table_sql})
	if [ -z "${res}" ]; then
		echo "该表不存在！"
	else
		if [ ! -f "${data_file}" ]; then
			echo "数据文件不存在！"
			return
		fi




		for line in $(cat ${data_file}); do
			sleep 3
            echo $line > ./lineData.log
			echo $line
			local sql="$( cat ./lineData.log | sed -e '/^$/d' | sed -e "s/,/','/g" | sed -e "s/^/insert into ${table_name} values('/g" -e "s/$/'\);/g")"
		
			res=$(exec_sql "${sql}")
			if [ -z "${res}" ]; then
				echo "数据插入成功！"
			else
				echo "${res}"
				echo "数据插入失败！"
			fi
		done

		# local sql="$(cat ${data_file} | sed -e '/^$/d' | sed -e "s/,/','/g" | sed -e "s/^/insert into ${table_name} values('/g" -e "s/$/'\);/g")"
		# res=$(exec_sql "${sql}")
		# if [ -z "${res}" ]; then
		# 	echo "数据插入成功！"
		# else
		# 	echo "${res}"
		# 	echo "数据插入失败！"
		# fi
	fi
}

main
