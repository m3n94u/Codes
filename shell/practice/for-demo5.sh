#!/bin/bash
#Desc: 显示数字1和2的所有排列组合

for i in {1..2}
do
    for j in {1..2}
    do
        echo "${i}${j}"
    done
done
