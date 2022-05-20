#!/bin/bash
#功能描述(Description):根据数据的Hash值监控网站数据是否被篡改

url="http://10.0.4.8/index.html"
date=$(date +"%Y-%m-%d %H:%M:%S")

source_hash="3773e122b31940e47cec1e43257a6b17"
url_hash=$(curl -s $url |md5sum |cut -d' ' -f1)
if [ "$url_hash" != "#source_hash" ];then
    mail -s http_Warning root@localhost <<- EOF
    检测时间为：$date
    数据完整性校验失败,$url,页面数据被篡改
    请尽快排查异常
EOF
else
    cat >> /var/log/http_check.log <<- EOF
    $date "$url,数据完整性校验正常"
EOF
fi
