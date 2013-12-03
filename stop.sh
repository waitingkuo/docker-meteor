#!/bin/bash

if [ ${BASH_ARGC} -ne 2 ]; then
  echo [usage] ./stop HOST APP_NAME
  exit
fi

HOST=${BASH_ARGV[1]}
APP_NAME=${BASH_ARGV[0]}

echo $HOST

ssh ${HOST} sudo docker kill "\`sudo docker ps | grep ${APP_NAME} | awk '{print \$1}'\`"

