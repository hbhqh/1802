#!/bin/bash
if [ ! -e "/root/.admin" ];then
	echo "第一次使用本系统，需要先设置管理员帐号和密码"
	read -p "输入管理员帐号名称：" adminname
	while : ;do
		read -p "请输入管理员密码：" adminpass1
		read -p "请再次输入管理员密码：" adminpass2 
       		if [ $adminpass1 == $adminpass2 ];then
				echo -n  "$adminname:" >>/root/.admin
				echo -n "$adminpass2"|md5sum  >>/root/.admin
				touch /root/users
         		echo -e "\t管理员帐号$adminname 创建成功\n\t你的密码是$adminpass2 请牢记！"
				break
			else
				echo "2次密码输入不一样，请重新输入"
			fi
	done
fi


echo "***********************"
echo "*     2019春运系统    *"
echo "***********************"
echo "*       1  注册       *"
echo "*       2  登陆       *"
echo "*       3  后台       *"
echo "*       4  退出       *"
echo "***********************"
while :;do 
	read -p "请输入系统菜单序号：" num1
	if ! expr $num1 + 1 &> /dev/null;then
        echo "######只能输入数字######"
	elif [ -z $num1 ];then
		echo "不能为空，请重新输入"
		continue
	elif [ $num1 -eq 1 ];then
		while : ;do
			read -n 9 -p "请输入你要注册用户名：" addname
			if ! cat /root/users|cut -d: -f1|grep \^"$addname"\$ &>/dev/null ;then
				while : ;do
					read -n 15 -p "请输入你要设置的密码：" pass1
					read -n 15 -p "请再次输入你的密码：" pass2
					if [ $pass1 == $pass2 ];then
						echo -n  "$addname:" >>/root/users
						echo -n "$pass2"|md5sum  >>/root/users
						echo -e "用户$addname 注册成功\n正在返回系统菜单..."; .  test.sh
						 exit
					else
							echo "2次密码输入不一样，请重新输入"
					fi
				done
			else
				echo “用户已存在，请重新输入..”		
			fi
		done
	elif [ $num1 -eq 2 ];then
		read -p "请输入你的用户名：" name
		read -n 15 -p "请输入你的密码：" pass
		if cat /root/users|cut -d: -f1|grep ^$name\$ &>/dev/null;then
			md5lp=`echo -n $pass |md5sum`
			md5pass=`cat /root/users|grep ^$name|head -1 |cut -d: -f2`
			if [ "$md5lp" == "$md5pass" ] ; then
				echo "登陆成功"
				echo -e "                各位旅客请注意\n        你乘坐的动车1802 次列车即将到站\n 请带好自己的行李物品准备进站乘车...祝你旅途愉快"
				wget http://10.3.144.182/sl-5.02-1.el7.x86_64.rpm &>/dev/uull
				sleep 1 
				rpm -ih sl-5.02-1.el7.x86_64.rpm &>/dev/uull
				sleep 1
				echo -n -e "\t      列车即将进站 3"
				sleep 1
				echo -n " 2"
				sleep 1
				echo " 1 "
				sleep 1
				echo -e  "\t\t   嘟嘟嘟~~~"
				sleep 2
				sl
				a=100
				num=`seq $a`
				for i in $num ; do
					echo  "按 1 再来一次"
					echo  "按 2 退出登陆"
					read -p "请输入：" num1
						case $num1 in
						1)
							sl
						;;
						2)
							echo "已退出登陆"
							break
						;;
						*)
						echo "请输入正确的序号"
						;;
						esac
				done
			else
				echo "#用户或密码不正确，请重新输入"
			fi
		else
			echo "用户或密码不正确，请重新输入"
		fi
	elif [ $num1 -eq 3 ];then
		echo "   @@@@@系统管理@@@@@   "
		while : ;do
			read -p "请输入管理员帐号：" admin
			read -n 15 -p "请输入你的密码：" adminpass
			if cat /root/.admin|cut -d: -f1|grep \^"$admin"\$ &>/dev/null;then
				adminmd5lp=`echo -n $adminpass |md5sum`
				adminmd5pass=`cat /root/.admin|grep "${admin}"|head -1 |cut -d: -f2`
				if [ "$adminmd5lp" == "$adminmd5pass" ] ; then
					echo -e "\t   登陆成功!\n\t欢迎回来管理员"
					echo
					echo "888888888888888888888888888888"
					echo "888888888888888888888888888888"
					echo "888888888  后台系统  888888888"
					echo "888888888888888888888888888888"
					echo "888888888 1.修改密码 888888888"
					echo "888888888 2.修改用户 888888888"
					echo "888888888 3.退出系统 888888888"
					echo "888888888888888888888888888888"
					echo "888888888888888888888888888888"
					while : ;do 
						read -p "请选择后台菜单：" passnum1
						case "$passnum1" in
						1)
							echo "你将修改的是普通用户的密码"
							while : ;do 
								read -p "请输入需要修改密码的用户：" newpassuser
								if cat /root/users|cut -d: -f1|grep \^"$newpassuser"\$ &>/dev/null;then
									read -p "请输入密码：" newpass1
									read -p "请再次输入密码：" newpass2
										newmd51=`echo -n $newpass1 |md5sum`
										newmd52=`echo -n $newpass1 |md5sum`
									if [ "$newmd51" == "$newmd52" ] ; then
										ouserpasswd=`cat /root/users |grep ^$newpassuser |head -1`
										alluser=`cat /root/users|grep -v $ouserpasswd`
										echo "$alluser" > /root/users
										echo "$newpassuser":"$newmd52" >>/root/users
										echo "用户$newpassuser 密码修改为$newpass2"
										break
									else
										echo"你输入2次密码不一样，请重新输入"
									fi
								else
										echo "用户不存在，请重新输入"
           						fi 
							done
						;;	
						2)
							while : ;do 
								read -p "请输入需要修改用户：" newnameuser
								if cat /root/users|cut -d: -f1|grep \^"$newnameuser"\$ &>/dev/null;then
									read -p "请输入新用户名称：" newuser1
									read -p "请再次输入用户名称：" newuser2
										if [ "$newuser1" == "$newuser2" ] ; then
											passmd5=`cat /root/users|grep ^$newnameuser|head -1 |cut -d: -f2`
											newnameuser1=`cat /root/users|grep ^$newnameuser|head -1 `
											allusertab=`cat /root/users |grep -v $newnameuser1`
											echo "$allusertab" > /root/users
											echo "$newuser2":"$passmd5" >>/root/users
											echo "用户ID $newnameuser已修改为$newuser2"
											break
										else
											echo "2次输入不一样，请重新输入"
										fi
								else
									echo "用户不存在"
								fi
							done
						;;
						3)
							echo -e "退出后台系统"; .  test.sh
							exit
						;;
						*) 
							echo "请输入正确的序号"
						;;
						esac
					done
				else
					 echo "密码不正确，请重新输入"
				fi	
			else
				echo "用户或密码不正确，请重新输入"
			fi
		done
	elif [ $num1 -eq 4 ];then
		break
	else
		echo "输入有误"
	fi
done
echo "再见"

