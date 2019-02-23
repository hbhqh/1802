#!/bin/bash
#ssh传公钥脚本
##############################################
#批量传公钥时要先把ip 和对应的密码放到一个文件中
#	ip=$(awk '{printf "%s\n",$1}' /root/scripts/host)
#	pass=($(awk '{printf "%s\n",$2}' /root/scripts/host))
#for i in $ip
#do
#	echo "$i","$pass"

read -p "请输入要传公钥的IP :" IP
read -p "IP的密码 :" PASS
id_rsa=/root/.ssh/id_rsa
id_rsa.pub=/root/.ssh/id_rsa.pub &>/dev/null
[ -f "$id_rsa.pub" ] && [ -f "$id_rsa" ] || /usr/bin/expect <<EOF
set timeout 300
spawn ssh-keygen
expect "Enter file in which to save the key (/root/.ssh/id_rsa):"
send "\n"
expect "Enter passphrase (empty for no passphrase):"
send "\n"
expect "Enter same passphrase again:"
send "\n"

spawn  ssh-copy-id  $IP
expect {
    "yes/no" { send "yes\n"; exp_continue }
    "root@$IP's password:" { send "$PASS\n"}
}

expect eof
EOF
/usr/bin/expect <<EOF
spawn  ssh-copy-id  $IP
expect {
	"yes/no" { send "yes\n"; exp_continue }
	"root@$IP's password:" { send "$PASS\n"}
}
expect "root@$IP's password:"
send "$PASS\n"
expect eof
EOF

#done
