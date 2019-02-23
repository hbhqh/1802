#!/bin/bash
for i in /test/*.bak
do
echo `basename $i .bak`
mv $i /test/`basename $i .bak`
done

