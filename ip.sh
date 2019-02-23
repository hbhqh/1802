#!/bin/bash
read -p "ip " str
[ -z $str ]&&exit
if ping -c2 $str &>/dev/null
then 
	echo "alive"
else
	echo "not alive"
fi
