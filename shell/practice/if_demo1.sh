#!/bin/bash
#version:0.3

read -p "请输入用户名:" user
read -s -p "请输入密码:" pass
if [ ! -z "$user" ]; then
    if [ ! -z "$pass" ]; then
        useradd "$user"
        echo "$pass" | passwd --stdin "$user"
    fi
fi

if [[ ! -z "$user" && ! -z "$pass" ]]; then
    useradd "$user"
    echo "$pass" | passwd --stdin "$user"
fi

if [ ! -z "$user" -a ! -z "$pass" ]; then
    useradd "$user"
    echo "$pass" | passwd --stdin "$user"
fi

if [ ! -z "$user" ] && [ ! -z "$pass" ]; then
    useradd "$user"
    echo "$pass" | passwd --stdin "$user"
fi

