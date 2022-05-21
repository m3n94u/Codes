#!/bin/bash
#Desc: 演示扩展通配符的作用

shopt -s extglob
read -p "请输入任意字符: " key
case $key in
+([Yy]))
    echo "输入了至少一个[Yy]";;
?([Nn])o)
    echo "输入的是[Nn]o或仅为o";;
t*(o))
    echo "输入的是t或to或too...";;
@([0-9]))
    echo "输入的是单个数字";;
!([[:punct:]]))
    echo "输入的不是标点符号";;
*)
    echo "输入的是其他符号";;
esac
