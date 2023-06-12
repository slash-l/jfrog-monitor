#!/bin/bash

echo "Run connect monitor script, you need to input interval and execution times."

read -p "Please input the interval(sec):" INTERVAL_TIME
read -p "Please input the execution times:" EXECUTION_TIMES
echo your input interval time = "$INTERVAL_TIME" seconds and execution times = "$EXECUTION_TIMES"

mkdir -p connectLog
cd connectLog

connectMonitor="connectMonitor-"$(date +%Y%m%d)-$(date +%H%M%S)
echo "artifactory connoct number" > $connectMonitor.csv

echo "Router(8082), Router(8046), DB(PG 5432)"
echo "Router(8082), Router(8046), DB(PG 5432)" >> $connectMonitor.csv

current_times=0
while ((current_times < $EXECUTION_TIMES)) ; do 
	echo "$(netstat -latuen | grep 8082 | wc -l)", "$(netstat -latuen | grep 8046 | wc -l)","$(netstat -latuen | grep 5432  | wc -l)"
	echo "$(netstat -latuen | grep 8082 | wc -l)", "$(netstat -latuen | grep 8046 | wc -l)","$(netstat -latuen | grep 5432  | wc -l)" >> $connectMonitor.csv; 
	sleep $INTERVAL_TIME;
	((current_times++)) 
done


