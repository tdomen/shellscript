#!/bin/sh

date=`date +%Y%m%d`
sudo dd if=/dev/sda | ssh -p 8081 localhost dd of=/home/tdomen/backup/"$date.img"
