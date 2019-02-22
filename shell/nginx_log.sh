#!/bin/bash
 #昨天日期 20190221 
day=`date -d "-1 day" +%Y%m%d`
 #nginx pid文件位置
nginx_pid="/usr/local/nginx/logs/nginx.pid"
 #日志的保存位置 
nginx_log="/usr/local/nginx/logs/"
 #将日志重名为昨天的日期 access_20190221.log
mv "$nginx_log"access.log access_"$day".log
# 重载配置，生成新的日志文件
kill -USR1 `cat $nginx_pid`


