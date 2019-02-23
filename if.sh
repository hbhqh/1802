#!/bin/bash
# 输入用户名如果用户不存在则，自动创建用户，并退出
echo “请输入用户名自动创建用户！”
if cd /root
then
read -p "请输入用户名: " username
if id $username &>/dev/null
then
	echo "$username 用户已存在"
else
	useradd $username
	echo "用户$username 已创建成功"
fi
else
	echo "不是root"
	exit
fi
