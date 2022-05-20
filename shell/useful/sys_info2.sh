#!/bin/bash
#本脚本获取系统各项性能参数，并根据预设阈值决定是否给管理员发送邮件报警

#变量定义列表如下
# time:时间，loalip:eth0网卡IP，free_mem:剩余内存大小，free_disk:剩余磁盘大小
# cpu_load:15min平均负载，login_user:登录系统的用户，procs:当前进程数量
local_time=$(date +"%Y%m%d %H:%M:%S")
local_ip=$(ifconfig eth0 | grep netmask | tr -s " " | cut -d" " -f3)
free_mem=$(cat /proc/meminfo | grep Avai | tr -s " " | cut -d" " -f2)
free_disk=$(df | grep "/$" | tr -s " " | cut -d" " -f4)
cpu_load=$(cat /proc/loadavg | cut -d" " -f3)
login_user=$(who | wc -l)
procs=$(ps aux | wc -l)

#vmstat命令可以查看系统中CPU的中断数，上下文切换数量
#CPU处于I/O等待的时间，用户态及系统态消耗CPU的统计数据
#vmstat命令输出的前2行信息是头部信息，第3行信息为开机到当前的平均数据
#第4行开始的数据是每秒钟的实时数据，tail -n +4 表示删掉前3行从第4行信息开始显示
#irq：中断，cs：上下文切换，usertime：用户态
#CPU，system：系统态CPU，iowait：等待I/O时间
irq=$(vmstat 1 2 | tail -n +4 | tr -s ' ' | cut -d' ' -f12)
cs=$(vmstat 1 2 | tail -n +4 | tr -s ' ' | cut -d' ' -f13)
usertime=$(vmstat 1 2 | tail -n +4 | tr -s ' ' | cut -d' ' -f14)
systime=$(vmstat 1 2 | tail -n +4 | tr -s ' ' | cut -d' ' -f15)
iowait=$(vmstat 1 2 | tail -n +4 | tr -s ' ' | cut -d' ' -f17)

#下面很多命令，因为内容比较长，无法在一行显示，所以使用了\强制换行
#使用强制换行符后，允许将一个命令在多行中输入

#当剩余内存不足1GB时发送邮件给root进行报警
[ $free_mem -lt 1048576 ] && \
echo "$local_time Free memory not enough.
Free_mem:$free_mem on $local_ip" | \
mail -s Warning root@localhost
#当剩余磁盘不足10GB时发送邮件给root进行报警
[ $free_disk -lt 10485760 ] && \
echo "$local_time Free disk not enough.
root_free_disk:$free_disk on $local_ip" | \
mail -s Warning root@localhost
#当CPU的15min平均负载超过4时发送邮件给root进行报警
result=$(echo "$cpu_load > 4" | bc)
[ $result -eq 1 ] && \
echo "$local_time CPU load to high
CPU 15 averageload:$cpu_load on $local_ip" | \
mail -s Warning root@localhost
#当系统实时在线人数超过3人时发送邮件给root报警
[ $login_user -gt 3 ] && \
echo "$local_time Too many user.
$login_user users login to $local_ip" | \
mail -s Warning root@localhost
#当实时进程数量大于500时发送邮件给root报警
[ $procs -gt 500 ] && \
echo "$local_time Too man procs.
$procs proc are running on $local_ip" | \
mail -s Warning root@localhost
#当实时CPU中断数量大于5000时发送邮件给root报警
[ $irq -gt 5000 ] && \
echo "$local_time Too man interupts.
There are $irq interupts on $local_ip" | \
mail -s Warning root@localhost
#当实时CPU上下文切换数量大于5000时发送邮件给root报警
[ $cs -gt 5000 ] && \
echo "$local_time Too man Content Switches.
$cs of context switches per second on $local_ip" | \
mail -s Warning root@localhost
#当用户态进程占用CPU超70%时发送邮件给root报警
[ $usertime -gt 70 ] && \
echo "$local_time CPU load to high.
Time spend running non-kernel code:$usertime on $local_ip" | \
mail -s Warning root@localhost
#当内核态进程占用CPU超70%时发送邮件给root报警
[ $systime -gt 70 ] && \
echo "$local_time CPU load to high.
Time spend running non-kernel code:$systime on $local_ip" | \
mail -s Warning root@localhost
#当CPU消耗大量时间等待磁盘I/O时发送邮件给root报警
[ $iowait -gt 40 ] && \
echo "$local_time Disk to slow.
CPU spend too many time wait disk I/O:$iowait on $local_ip" | \
mail -s Warning root@localhost
