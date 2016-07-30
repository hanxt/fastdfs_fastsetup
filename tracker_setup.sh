#!/bin/bash

ROOTPATH=`pwd`
DATA_DIR=/home/aixin/data/fastdfs/tracker
HTTP_SERVERPORT=8987
CLIENT_DATA_DIR=/home/aixin/data/fastdfs/client
TRACKER_SERVER=192.168.1.158

# tracker setup
sudo mkdir -p ${DATA_DIR} && \
sudo cp /etc/fdfs/tracker.conf.sample /etc/fdfs/tracker.conf && \
sudo cp $ROOTPATH/fastdfs-5.05/conf/http.conf /etc/fdfs && \
sudo cp $ROOTPATH/fastdfs-5.05/conf/mime.types /etc/fdfs && \
sudo sed -i "s:base_path=.*:base_path=${DATA_DIR}:g" /etc/fdfs/tracker.conf && \
sudo sed -i "s:http.server_port=.*:http.server_port=${HTTP_SERVERPORT}:g" /etc/fdfs/tracker.conf


# clent setup
sudo mkdir -p ${CLIENT_DATA_DIR} && \
sudo cp /etc/fdfs/client.conf.sample  /etc/fdfs/client.conf && \
sudo sed -i "s:base_path=.*:base_path=${CLIENT_DATA_DIR}:g" /etc/fdfs/client.conf && \
sudo sed -i "s/tracker_server=.*/tracker_server=${TRACKER_SERVER}:22122/g" /etc/fdfs/client.conf

grep base_path /etc/fdfs/* | grep -v sample;
grep http.server_port /etc/fdfs/* |grep -v sample;
grep tracker_server /etc/fdfs/* |grep -v sample;

