#!/bin/bash
#Desc: 测试某个网段内所有主机的连通性

net="192.168.2"
for i in $(seq 254)
do
    ping -c2 -i0.2 -W1 $net.$i &>/dev/null
    if [ $? -eq 0 ];then
        echo "$net.$i is up."
    else
        echo "$net.$i is down."
    fi
done
