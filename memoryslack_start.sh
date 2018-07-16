#!/bin/bash

source /home/user/Documents/projects/memoryslack/config

while true;
do

free -m |grep Mem: > /home/user/Documents/projects/memoryslack/free.txt
awk '{print $7}' /home/user/Documents/projects/memoryslack/free.txt > /home/user/Documents/projects/memoryslack/free1.txt
x=$(cat /home/user/Documents/projects/memoryslack/free1.txt)

echo " $x : $limit : $webhook "
usage=$[100-$[ $[$x *100]/ 7869 ]]
echo usage=$usage %
echo '{"text":"Attention there is a memory spike to a percentage of '$usage'% !"}' > /home/user/Documents/projects/memoryslack/message.txt
if [ $x -lt $limit ]
then
    echo "memory spike "
    curl -X POST -H 'Content-type: application/json' -d @/home/user/Documents/projects/memoryslack/message.txt $webhook
fi
sleep 10
done
