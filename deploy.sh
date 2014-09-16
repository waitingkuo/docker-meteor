#!/bin/bash

if [ ${BASH_ARGC} -ne 3 ]; then
  echo [usage] ./deploy HOST APP_NAME BUNDLE_FILE
  exit
fi

HOST=${BASH_ARGV[2]}
APP_NAME=${BASH_ARGV[1]}
BUNDLE_FILE=${BASH_ARGV[0]}


DOCKERFILE="

FROM node
MAINTAINER waitingkuo0527@gmail.com

RUN curl https://install.meteor.com | /bin/sh

ADD . ./meteorsrc
WORKDIR /meteorsrc
RUN meteor build --directory /var/www/app

WORKDIR /var/www/app
RUN cd bundle/programs/server && npm install

CMD node ./main.js
"


scp ${BUNDLE_FILE} ${HOST}:~/bundle.tar.gz
echo "${DOCKERFILE}" | ssh ${HOST} "cat - > Dockerfile"
ssh ${HOST} sudo docker build -t ${APP_NAME} .
ssh ${HOST} sudo docker run -d -p 80:80 ${APP_NAME}
