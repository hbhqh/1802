#!/bin/bash
for i in {1..1000}
do
	echo "$RANDOM $i"
done|sort -n|cut -d" " -f2|xargs
