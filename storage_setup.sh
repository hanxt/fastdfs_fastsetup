#!/bin/bash

ROOTPATH=`pwd`
DATA_DIR=/home/aixin/data/fastdfs/storage
HTTP_SERVERPORT=8987
TRACKER_SERVER=192.168.1.158

sudo mkdir -p ${DATA_DIR} && \
sudo cp /etc/fdfs/storage.conf.sample /etc/fdfs/storage.conf && \
sudo cp $ROOTPATH/fastdfs-5.05/conf/http.conf /etc/fdfs && \
sudo cp $ROOTPATH/fastdfs-5.05/conf/mime.types /etc/fdfs && \
sudo sed -i "s:base_path=.*:base_path=${DATA_DIR}:g" /etc/fdfs/storage.conf && \
sudo sed -i "s:store_path0=.*:store_path0=${DATA_DIR}:g" /etc/fdfs/storage.conf && \
sudo sed -i "s/tracker_server=.*/tracker_server=${TRACKER_SERVER}:22122/g" /etc/fdfs/storage.conf && \
sudo sed -i "s:http.server_port=.*:http.server_port=${HTTP_SERVERPORT}:g" /etc/fdfs/storage.conf

grep base_path /etc/fdfs/* | grep -v sample;
grep http.server_port /etc/fdfs/* |grep -v sample;
grep store_path0 /etc/fdfs/* | grep -v sample;
grep http.server_port /etc/fdfs/* | grep -v sample;

