#!/bin/bash

#set varible for future use
command=$1
password=$2
echo "$command"

#if more then two argument is given. exit with warning message
if (("$#" > "2"))
then
echo "illegal number of arguements. \(no more than two\)"
#exit with failure
exit 1
fi
#if the first argument isnt start or stop that means illgeal arguments
if [ "$command" != "start" ] && [ "$command" != "stop" ];
then
echo "illegal arguments. scripts runs in format : psql_docker.sh start|stop [password]"
exit 1
fi

#handle start comment
if [ "$command" = "start" ];
then
systemctl status docker || systemctl start docker
#check if cotainer is already running  
if [ "$(docker ps -f name=$container_name |wc -l)" = "2" ];
then
#container already running exit
echo "container is already runing, check docker ps"
exit 0
fi

docker volume inspect pgdata
if [ $? -eq 0 ];
then
pgdatac=T
fi
docker volume create pgdata

if [ $# -ne 2 ];
then
echo password is set to default password
export PGPASSWORD=password
else
echo password is set to given password
export PGPASSWORD="$2"
echo $PGPASSWORD
fi
if [ "$(docker container ls -a -f name=$container_name |wc -l)" = "2" ];
then
#already exist just start the container
echo "container is already created ,Starting"
docker container start jrvs-psql
else
docker run --name jrvs-psql -e POSTGRES_PASSWORD=$PGPASSWORD -d -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgres
fi
exit 0
fi

if [ "$command" = "stop" ];
then
echo "i am here"
docker container stop jrvs-psql
exit 0
fi