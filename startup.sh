#!/bin/bash

if [ $# != 1 ] ; then
    echo "USAGE: $0 <type>"
    echo " e.g.: $0 tracker or storage or client"
    exit 1;
fi 

if [ $1 == "tracker" ]
then
	sudo   fdfs_trackerd   /etc/fdfs/tracker.conf
	echo "tracker started";
elif [ $1 == "storage" ]
then
	sudo fdfs_storaged /etc/fdfs/storage.conf
	echo "storage started";
else
	echo "pls enter a valid param ";
fi
