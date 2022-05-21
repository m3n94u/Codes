#!/bin/bash
#Desc: 通过读取用户名列表文件批量创建系统用户

for i in `cat user.txt`
do
    if id $i &>/dev/null ;then
        echo "$i,该账户已存在!"
    else
        useradd $i
        echo "123456" | passwd --stdin $i
    fi
done
