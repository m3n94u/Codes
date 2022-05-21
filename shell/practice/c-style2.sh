#!/bin/bash
#Desc: C语言风格的for循环u语法格式示例
#i从1开始，每循环1次对i进行自加1运算，直到i大于5时循环结束

for ((i=1,j=5;i<=5;i++,j--))
do
    echo "$i $j"
done
