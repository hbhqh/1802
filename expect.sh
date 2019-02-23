#!/bin/bash
[ -x */expect ]&&exit 2>/dev/null
if expect 2>/dev/null 
then

echo "命令存在"
else
	echo "没有此命令，正在安装"
	yum install expect -y &>/dev/null
fi
	
