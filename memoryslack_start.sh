#!/bin/bash

source /home/user/Documents/projects/memoryslack/config

y=$( free -m |grep Mem: | awk '{print $2}')

x=$( free -m |grep Mem: | awk '{print $7}')


echo " $x : $limit : $y :$webhook   "
usage=$[100-$[ $[$x *100]/ $y ]]
echo usage=$usage %
echo '{"text":"Attention there is a memory spike to a percentage of '$usage'% !"}' > /home/user/Documents/projects/memoryslack/message.txt


if [ $x -lt $limit ]
then
    echo "memory spike "
    curl -X POST -H 'Content-type: application/json' -d @/home/user/Documents/projects/memoryslack/message.txt $webhook
fi

