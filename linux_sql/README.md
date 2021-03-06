## Introduction
The Cluster Monitor Agent is an internal tool that collects the hardware information of each server and monitoros resource usage such as CPU and RAM in real time. The data will be stored in a RDBMS database on a desinated server.  The report generated by using these date will be a great tools for future recourse planning.

## Architecture and Design
1. Cluster Monitor Agent Diagram:
![image](/linux_sql/assets/sizedDiagram2.png)

2. Tables:

There are two tables: Host_info and Host_info are created under `host_agent` database
  - `host_info` contains information about server hardware specifations, such as CPU, Cache and total memory.
  - `host_usage` contains information about he usage of resources by the server, such as memory usage, CPU usage, this infomation is collected every minute. 

3. Scripts:

There are tree scripts : Psql_docker.sh, host_info.sh, host_usage.sh
  - `Psql_docker.sh` starts/stops the Docker Psql Container.
  - `host_info.sh` collect hardware specifation data and store in host_info table using sql query.
  - `host_usage.sh` collect usage information by the server then store into host_usage table using sql query.

## Usage

1. `Psql_docker.sh`  :init database and tables. Use parameter "start", password is optional, password will not update if database/volume was previously created. To stop the database container use parameter stop

`./psql_docker.sh start|stop [password] (to start or stop container) 
then run psql -h localhost -U postgres -W -f sql/ddl.sql (to create ddl/database)`

2. `host_info.sh` store information about the hardware specifiction to the table, require details of connection as argument (host, port, database name, user and password).

 `./host_info.sh localhost 5432 host_agent postgres password`
 
3. `host_usage.sh`store information about the rescource usage by the server to the table, require details of connection as argument (host, port, database name, user and password).

`./host_usage.sh localhost 5432 host_agent postgres password`

4. crontab setup: this allow required script( `host_usage.sh`) to run every minute

```
crontab -e
* * * * * bash [PATH to your file]/linux_sql/scripts/host_usage.sh localhost 5432 host_agent postgres password > /tmp/host_usage.log
```

## Possible improvements

1. record the process list if current usage is too high
2. Sql Query using Windows function instead of GROUP by to improve the performance
3. add a script to remove outdated data from table to prevent database getting to big with unnecessary data


