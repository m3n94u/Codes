#!/bin/bash
#功能描述（Description）：使用cURL访问具体的HTTP页面，检测HTTP状态码

#cURL选项说明
#-m设置超时时间；-s设置静默连接
#-o下载数据另存为；-w返回附加信息，HTTP状态码

url=http://10.0.4.8/index.html
date=$(date +"%Y-%m-%d %H:%M:%S")
status_code=$(curl -m 3 -s -o /dev/null -w %{http_code} $url)
mail_to="root@localhost"
mail_subject="http_warning"

#使用<<-重定向可以忽略Tab键缩进的内容，代码的可读性更好
if [ $status_code -ne 200 ];then
    mail -s $mail_subject $mail_to <<- EOF
    检测时间为:$date
    $url 页面异常，服务器返回状态码:${statuss_code}
    请尽快排查异常
EOF
else
    cat >> /var/log/http_check.log <<- EOF
    $date "$url 页面访问正常"
EOF
fi
