#/bin/bash

ROOTPATH=`pwd`

#libcommon setup
sudo apt-get install -y gcc perl make && \
cd $ROOTPATH/libfastcommon-1.0.7 && \
./make.sh && \
sudo ./make.sh install

sudo ln -s /usr/lib64/libfastcommon.so /usr/local/lib/libfastcommon.so
sudo ln -s /usr/lib64/libfastcommon.so /usr/lib/libfastcommon.so
sudo ln -s /usr/lib64/libfdfsclient.so /usr/local/lib/libfdfsclient.so
sudo ln -s /usr/lib64/libfdfsclient.so /usr/lib/libfdfsclient.so

#fastdfs setup
cd $ROOTPATH/fastdfs-5.05 && \
./make.sh && \
sudo ./make.sh install
