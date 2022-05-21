#!/bin/bash
#Desc: 使用循环语句计算猴子吃香蕉的问题
#初始化香蕉数量为1，也就是第九天的香蕉数量为1
#每循环一次计算前一天的香蕉数量，循环8次得到第一天的香蕉数量

banana=1
for i in {1..8}
do
    banana=$[(banana+1)*2]
done
    echo $banana
