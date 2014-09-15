#!/usr/bin/env/bash


############################
# install nginx on ubuntu
#############################


codename="trusty"

#TODO check ubuntu version get codename
echo "
deb http://nginx.org/packages/ubuntu/ ${codename} nginx
deb-src http://nginx.org/packages/ubuntu/ ${codename} nginx
" >> /etc/apt/source.list

wget http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key
apt-get update
apt-get install nginx
nginx -v
