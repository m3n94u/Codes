#!/bin/bash
#Desc: compare character by case

read -p "请输入一个a~c之间的字母:" key
case $key in
a)
    echo "I am a.";;&
#使用;;&会继续对后面的模式进行匹配
#所以屏幕会继续显示后面的I am aa.
b)
    echo "I am b.";;
a)
#使用;&会执行后一个模式匹配中的命令
#所以屏幕会继续显示I am c.
    echo "I am aa.";&
c)
    echo "I am c.";;
a)
    echo "I am aaa.";;
*)
    echo "Out of range";;
esac
