#!/bin/bash
#
#seq命令用于产生从某个数到另外一个数之间的所有整数。
#
for ip in `seq 1 255`
  do
  { 
  ping -c 1 192.168.127.$ip &>/dev/null 
    if [ $? -eq 0 ];then
	mac=$(arping -I ens33 -c1 192.168.127.$ip|awk '/reply/{print $5}'|sed -r 's/(.)(.*)(.)/\2/')
     echo "192.168.127.$ip 存活，MAC地址为 $mac" 
#    else
#     echo 192.168.127.$ip DOWN   ##如果要统计不存活，则把注释拿掉
   fi
}&
done
wait 
