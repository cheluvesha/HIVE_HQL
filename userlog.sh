#!/bin/bash 

echo "Script is running"

hive -f /home/cheluvesha/Documents/hive/userlogView.hql  

hive -e "select * from fellowship.userlog_avg_hour;" > userlog.txt

echo "lowest average hours"

sort -n -k2 userlog.txt

echo "highest average hours"

sort -r -k2 userlog.txt
