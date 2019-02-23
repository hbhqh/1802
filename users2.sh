#!/bin/bash
#用户登录系统，未完善
B(){
break
}
echo "
******************
*  1	注册  	 *
*  2	登录 	 *
*  3	退出	 *
******************"
while : ;do
	read -p "请选择你的操作:" i
case $i in
1|注册)
	while : ;do
		read -p "请输入用户名：" user1
		user2=`cat /root/users|cut -d: -f1|grep \^$user1\$` 
		if [ $user1 = $user2 ] &>/dev/null
		then 
			echo "用户 ${user1} 已存在，请重新输入！"&&continue
		else
			while : ;do
			read -s -p "请输入密码: " pass1
			echo
			read -s -p "请再次输入密码: " pass2
			echo
			if [ "$pass1" = "$pass2" ];then
				pass_md5=$(echo -n $pass2|md5sum)
				echo  "${user1}:${pass_md5}"|cut -d" " -f1 >> /root/users
				echo "恭喜,用户 ${user1} 注册成功" &&B
			else
				echo "两次密码输入不一致，请重新输入！"
			fi
			done
		fi
		B
	done
;;
2|登录)
	while : ;do
		read -p "请输入用户名：" user1
				read -p "请输入密码：" pass
		user2=`cat /root/users|cut -d: -f1|grep \^$user1\$`
		if [ $user1 = $user2 ] &>/dev/null
		then
				pass1=`echo -n $pass|md5sum|cut -d" " -f1`
				pass2=`cat /root/users|grep \^${user1}:|cut -d: -f2|tr -d " "`
				if [  $pass1 = $pass2 ];then
					echo "$user1,欢迎回来！"
					echo "输入 1 为修改用户名："
					echo " 输入 2 为修改密码："
					echo “3为开始游戏”
					echo "4退出"
					while : ;do
					read -p "请选择你的操作：" m
					case $m in
					1)
						while : ;do
						user2=`cat /root/users|cut -d: -f1|grep \^$newuser\$`
						read -p "请输入你的新用户名" newuser
						if [ "$newuser" = "$user2" ];then
							echo "用户名已存在！请重新输入！"&&B
						else
							sed -i "s/\<$user1\>/$newuser/g" /root/users

							echo "用户名修改成功！请使用$newuser 登录"&&B
						fi
						done
					;;
					2)
						while :;do
						read -p "请输入原密码：" oldd
						read -p "请输入新密码：" news
						new=`echo -n ${news}|md5sum|cut -d" " -f1`
						old=`grep "^${user1}:" /root/users|cut -d ":" -f2`
						if [ "$oldd" == "$pass"  ];then
							sed -i "s/^${user1}:.*/${user1}:$new/g" /root/users &&break
						else
							echo "输入的密码不正确!"
						fi
						done
					;;
					3)
						rpm -q sl
						[ $? -ne 0 ]&& yum install sl -y
						echo "请准备，火车马上来啦!"
						sleep 1
						echo 3..
						sleep 1
						echo 2..
						sleep
						echo 1..
						sl
						
					;;
					4)
					exit
					esac
					B
					done
				else
					echo "用户或密码输入错误!"
				fi
		else
			echo "用户或密码输入错误！"
		fi
	done
;;
3|退出)
	exit
	;;
*)
	echo "输入错误，只能选1或2!"
esac
done
