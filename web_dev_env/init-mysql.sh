#!/usr/bin/env/bash

#此脚本不做生产环境用，只供参考
###################################
##  install version mysql-5.6.20 ##
## 参考 [安装](https://rtcamp.com/tutorials/mysql/mysql-5-6-ubuntu-12-04/)
###################################
cd $HOME/tmp

wget -O mysql-5.6.deb http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.20-debian6.0-x86_64.deb # 下载

dpkg -i mysql-5.6.deb # 安装到 /opt

apt-get install libaio1 # 安装需要libaio1

cp /opt/mysql/server-5.6/support-files/mysql.server /etc/init.d/mysql.server # 启动

update-rc.d -f mysql remove #把老版本的自启动去掉

update-rc.d mysql.server defaults # 加入自启动

mysql_upgrade -u root -p # 升级数据库结构
