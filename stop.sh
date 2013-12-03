#!/bin/bash

if [ ${BASH_ARGC} -ne 2 ]; then
  echo [usage] ./stop HOST APP_NAME
  exit
fi

HOST=${BASH_ARGV[1]}
APP_NAME=${BASH_ARGV[0]}

ssh ${HOST} sudo docker kill `sudo docker ps | grep myapp | awk '{print $1}'`

