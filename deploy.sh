#!/bin/bash

if [ ${BASH_ARGC} -ne 3 ]; then
  echo [usage] ./deply HOST APP_NAME BUNDLE_FILE
  exit
fi

HOST=${BASH_ARGV[2]}
APP_NAME=${BASH_ARGV[1]}
BUNDLE_FILE=${BASH_ARGV[0]}


DOCKERFILE="
FROM ubuntu

MAINTAINER waitingkuo0527@gmail.com

# install node.js
RUN apt-get update
RUN apt-get install -y python-software-properties python g++ make

RUN echo 'deb http://archive.ubuntu.com/ubuntu precise universe' >> /etc/apt/sources.list
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y nodejs

ADD bundle.tar.gz bundle.tar.gz

RUN tar zxvf bundle.tar.gz
RUN cd bundle; rm -r programs/server/node_modules/fibers
RUN cd bundle; npm install fibers@1.0.1

EXPOSE 80

ENTRYPOINT cd bundle; PORT=80 node main.js
"


scp ${BUNDLE_FILE} ${HOST}:~/bundle.tar.gz
echo "${DOCKERFILE}" | ssh ${HOST} "cat - > Dockerfile"
ssh ${HOST} sudo docker build -t ${APP_NAME} .
ssh ${HOST} sudo docker run -d -p 80:80 ${APP_NAME}
