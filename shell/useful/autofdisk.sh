#!/bin/bash
#本脚本会自动将vdx整个磁盘分成一个区，并将该分区格式化
#注意：所有数据均将丢失
#n（新建分区），p（新建主分区），1（主分区编号为1）
#回车键，空白行（从磁盘那个位置开始分区，默认从第1个扇区）
#回车键，空白行（分区到哪个扇区结束，回车键代表最后，将整个磁盘分1个区）
#wq（保存退出），mkfs.xfs（格式化命令）
fdisk /dev/vdx << EOF
n
p
1


wq
EOF

mkfs.xfs /deev/vdx1

[ ! -d /data ] && mkdir /data
cat >> /etc/fstab << EOF
/dev/vdx1	/data	xfs	defaults	0	0
EOF
mount -a
