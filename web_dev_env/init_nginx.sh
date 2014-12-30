#!/usr/bin/env/bash


## 注意这个脚本只是参考不做生产环境用
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


###########################
# compile nginx
# 参考[安装](http://hi.baidu.com/yhfaith/item/0cd0ef818136a6844414cfa1)
##########################

version="1.6.1"

# install need 
apt-get install build-essential zlib1g-dev libpcre3-dev libssl-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev


mkdir tmp
cd tmp
wget http://nginx.org/download/nginx-${version}.tar.gz


tar -zxvf nginx-${version}.tar.gz

cd nginx-${version}

./configure --prefix=/usr/local/nginx --sbin-path=/usr/local/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/run/nginx.pid --lock-path=/run/lock/subsys/nginx --user=nginx --group=nginx --with-file-aio --with-ipv6 --with-http_ssl_module --with-http_spdy_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module --with-http_image_filter_module --with-http_geoip_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_stub_status_module --with-http_perl_module --with-mail --with-mail_ssl_module --with-pcre --with-google_perftools_module --with-debug


make

make install

nginx -v

nginx -V


adduser --system --no-create-home --disabled-login --disabled-password --group nginx  #add nginx user

# auto restart nginx  script
curl -O https://raw.githubusercontent.com/zs1621/ops/master/web_dev_env/nginx
cp nginx /etc/init.d/nginx
chmod +x /etc/init.d/nginx
update-rc.d -f nginx defaults
service nginx start
ps aux  | grep nginx

