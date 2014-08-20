#!/usr/bin/env/bash


set -e

redisVersion="2.8.13"


##############################
#a prepare for install redis 
##############################

apt-get install build-essential


apt-get install tcl8.5



#################################
# install redis
##################################

mkdir -p $HOME/tmp

cd $HOME/tmp

wget http://download.redis.io/releases/redis-$redisVersion.tar.gz

tar xzf redis-$redisVersion.tar.gz 

cd redis-$redisVersion


make

make test

make install

cd utils

# fix _${REDIS_PORT} to redis
sed -i 's/_\${REDIS_PORT}//g' install_server.sh
sed -i 's/_\$REDIS_PORT//g' install_server.sh

# vm.overcommit
echo "vm.overcommit_memory" >> /etc/sysctl.conf
sysctl vm.overcommit_memory=1

sh install_server.sh

service redis start
service redis stop

sudo update-rc.d redis defaults
