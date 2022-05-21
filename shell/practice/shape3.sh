#!/bin/bash
#Desc: 打印各种色块形状
#练习循环嵌套

for ((i=1;i<=5;i++)) 
do
    for ((j=1;j<=i;j++))
    do
        echo -ne "\033[46m \033[0m"
    done
    echo
done

for ((i=1;i<=4;i++)) 
do
    for ((j=4;j>=i;j--))
    do
        echo -ne "\033[46m \033[0m"
    done
    echo
done
