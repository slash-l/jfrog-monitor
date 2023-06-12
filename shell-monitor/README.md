## analyseLog.sh
分析 artifactory request log 日志

汇聚的日志文件和分析结果存放在目录 artiLog

## baseMonitor.sh
收集一段时间的操作系统数据进行监控：CPU 内存 磁盘，确保可以运行以下命令：
- uptime
- mpstat
- free
- vmstat
- iostat

参数说明：第一个参数是收集间隔时长（秒），第二个参数是执行收集的次数。

汇聚的日志文件和分析结果存放在目录 baseMonitorLog

## connectMonitor.sh
收集一段时间的连接数进行监控：tomcat 数据库

汇聚的日志文件和分析结果存放在目录 connectLog

