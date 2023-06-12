#!/bin/bash

echo "Run monitor script, you need to input interval and execution times."

read -p "Please input the interval(sec):" INTERVAL_TIME
read -p "Please input the execution times:" EXECUTION_TIMES
echo your input interval time = "$INTERVAL_TIME" seconds and execution times = "$EXECUTION_TIMES"

# 创建基础监控（CPU 内存等）日志存放目录
mkdir -p baseMonitorLog
cd baseMonitorLog


# 巡检当天时间作为收集日志文件名
# CPU
cpuMonitorLog="cpuMonitor-"$(date +%Y%m%d)-$(date +%H%M%S)
touch $cpuMonitorLog.log
# 系统运行时长
echo "Collect uptime"
uptime >> $cpuMonitorLog.log
echo -e "\n" >> $cpuMonitorLog.log

echo "Collect cpu monitor data is running ..."
mpstat $INTERVAL_TIME $EXECUTION_TIMES >> $cpuMonitorLog.log 2>&1 & pid1=$!


# 内存
echo "Collect memory monitor data is running ..."
memoryMonitorLog="memoryMonitor-"$(date +%Y%m%d)-$(date +%H%M%S)
touch $memoryMonitorLog.log

free -h >> $memoryMonitorLog.log
echo -e "\n" >> $memoryMonitorLog.log
vmstat $INTERVAL_TIME $EXECUTION_TIMES >> $memoryMonitorLog.log 2>&1 & pid2=$!


# 磁盘
echo "Collect disk monitor data is running ..."
diskMonitorLog="diskMonitor-"$(date +%Y%m%d)-$(date +%H%M%S)
touch $diskMonitorLog.log

df -h >> $diskMonitorLog.log
iostat -N $INTERVAL_TIME $EXECUTION_TIMES >> $diskMonitorLog.log 2>&1 & pid3=$!


wait $pid1
echo "Collect cpu monitor data is done!"
wait $pid2
echo "Collect memory monitor data is done!"
wait $pid3
echo "Collect disk monitor data is done!"

echo “Done”







