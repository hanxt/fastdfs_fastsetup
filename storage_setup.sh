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


#nginx need
sudo apt-get  install -y build-essential libtool libpcre3 libpcre3-dev libpcrecpp0 libssl-dev zlib1g-dev;

#nginx and fastdfs module setup
cd $ROOTPATH/nginx-1.10.1
./configure \
  --prefix=/usr \
  --sbin-path=/usr/sbin/nginx \
  --conf-path=/etc/nginx/nginx.conf \
  --error-log-path=/var/log/nginx/error.log \
  --http-log-path=/var/log/nginx/access.log \
  --pid-path=/var/run/nginx/nginx.pid  \
  --lock-path=/var/lock/nginx.lock \
  --user=root \
  --group=root \
  --with-http_ssl_module \
  --with-http_flv_module \
  --with-http_stub_status_module \
  --with-http_gzip_static_module \
  --with-pcre \
  --add-module=${ROOTPATH}/fastdfs-nginx-module-master/src && make  && sudo make install


sudo cp $ROOTPATH/fastdfs-nginx-module-master/src/mod_fastdfs.conf /etc/fdfs/ && \
sudo sed -i "s:base_path=.*:base_path=${DATA_DIR}:g" /etc/fdfs/mod_fastdfs.conf && \
sudo sed -i "s:store_path0=.*:store_path0=${DATA_DIR}:g" /etc/fdfs/mod_fastdfs.conf && \
sudo sed -i "s/tracker_server=.*/tracker_server=${TRACKER_SERVER}:22122/g" /etc/fdfs/mod_fastdfs.conf && \
sudo sed -i "s:log_filename=.*:log_filename=${DATA_DIR}/logs/mod_fastdfs.log:g" /etc/fdfs/mod_fastdfs.conf && \
sudo sed -i "s:url_have_group_name.*:url_have_group_name=true:g" /etc/fdfs/mod_fastdfs.conf 
