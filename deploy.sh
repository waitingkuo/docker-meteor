#!/bin/bash

if [ ${BASH_ARGC} -ne 3 ]; then
  echo [usage] ./deply HOST APP_NAME BUNDLE_FILE
  exit
fi

HOST=${BASH_ARGV[2]}
APP_NAME=${BASH_ARGV[1]}
BUNDLE_FILE=${BASH_ARGV[0]}


DOCKERFILE='''
FROM ubuntu\n
\n
MAINTAINER waitingkuo0527@gmail.com\n
\n
# install node.js\n
RUN apt-get update\n
RUN apt-get install -y python-software-properties python g++ make\n
\n
RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe" >> /etc/apt/sources.list\n
RUN add-apt-repository -y ppa:chris-lea/node.js\n
RUN apt-get update\n
RUN apt-get install -y nodejs\n
\n
ADD bundle.tar.gz bundle.tar.gz\n
\n
RUN tar zxvf bundle.tar.gz\n
RUN cd bundle; rm -r programs/server/node_modules/fibers\n
RUN cd bundle; npm install fibers@1.0.1\n
\n
EXPOSE 80\n
\n
ENTRYPOINT cd bundle; PORT=80 node main.js\n
'''


scp ${BUNDLE_FILE} ${HOST}:~/bundle.tar.gz
echo ${DOCKERFILE} | ssh ${HOST} "cat - > Dockerfile"
ssh ${HOST} sudo docker build -t myapp .
ssh ${HOST} sudo docker run -d -p 80:80 myapp
