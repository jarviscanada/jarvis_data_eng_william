#!/bin/bash

#check  input if it is valid
if [ $# -ne 5 ];
then
	 echo "illegal number of inputs"
	 exit 1
fi

#assign arguments to varible 
psql_host=$1
psql_port=$2
database=$3
psql_user=$4
psql_password=$5


#creat shortcuts
lscput_out=`lscpu`
memory_info=`cat /proc/meminfo`

#pass user info in to varible 
hostname=$(hostname -f)
cpu_number=$(echo "$lscpu_out"  | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)
cpu_architecture=$(echo "$lscpu_out"  | egrep "^Architecture:" | awk '{print $2}' | xargs)
cpu_model=$(echo "lscpu_out" | egrep "^Model name:") | awk -F ':' '{print $2}' | xargs)
cpu_mhz=$(echo "$lscpu_out"  | egrep "^*MHz:" | awk '{print $3}' | xargs)
l2_cache=$(echo "$lscpu_out"  | egrep "^L2\scache:" | awk '{print $3}' | xargs)
total_mem=$(echo "memory_info" | egrep "^Memtotal:"  |awk '{print $2}' | xargs)
timestamp=$(echo |vmstat -t | awk '{print $18,$19}'| egrep "*-" | xargs)