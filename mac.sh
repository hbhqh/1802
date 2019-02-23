#!/bin/bash
#随机生成mac或uuid
MAC(){
	echo $RANDOM | md5sum | sed 's/../&:/g' | cut -c1-17
}
UUID(){
 cat /proc/sys/kernel/random/uuid
}
[ "$1" == "mac" ]&& MAC
[ "$1" == "uuid" ]&& UUID
[ "$1" != "mac" -a  "$1" != "uuid"  ] && echo "只能接Mac或uuid"
[ ! -n "$1" ]&& echo "只能接mac或uuid"
