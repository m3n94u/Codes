#!/bin/bash
#Desc: 错误的演示案例

for i in {1..2}
do
    for i in {1..2}
    do
        echo "${i}${i}"
    done
done
