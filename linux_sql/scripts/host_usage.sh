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

#create shortcut varible for repeated use value
vm=`vmstat --unit M`
disku=`df -BM`
#pass user info in to varible 
hostname=$(hostname -f)
memory_free=$(echo "$vm" | tail -1 | awk '{print $4}' | xargs )
cpu_idel=$(echo "$vm" | tail -1 | awk '{print $15}' | xargs )
cpu_kernel=$(echo "$vm" | tail -1 | awk '{print $14}' | xargs )
disk_io=$(echo "$vm" | tail -1 | awk '{print $10}' | xargs )
disk_available=$(echo "$disku" | head -2 | tail -1 | awk '{print $4}' | grep -o -E '[0-9]+' | xargs)
timestamp=$(echo |vmstat -t | awk '{print $18,$19}'| egrep "*-" | xargs)

#export  password
export PGPASSWORD=$psql_password

#insert statment
sqlstatement="INSERT INTO host_usage ("timestamp", host_id, memory_free, cpu_idel, cpu_kernel, disk_io, disk_available) VALUES ('${timestamp}', (select id from host_info where hostname='$hostname'), ${memory_free}, ${cpu_idel}, ${cpu_kernel}, ${disk_io}, ${disk_available})";

psql -h $psql_host -p $psql_port -U $psql_user -d $database -c "$sqlstatement"

exit 0
