#!/bin/bash
#功能描述（Description）：使用Nmap的端口扫描功能监控HTTP端口
ip=10.0.4.8
mail_to=root@localhost

nmap -n -sS -p80 $ip | grep -q "^80/tcp open"
if [ $? -eq 0 ];then
    echo "http service is running on $ip" | mail -s http_status_OK $mail_to
else
    echo "http service is stoped on $ip" | mail -s http_status_error $mail_to
fi
