#!/usr/bin/env/bash




###########################
# compile nginx and upload progress module and upload module
# 参考[安装](http://hi.baidu.com/yhfaith/item/0cd0ef818136a6844414cfa1)
##########################

version="1.7.10"
#
## install need 
apt-get install build-essential zlib1g-dev libpcre3-dev libssl-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev unzip
##
##get pwd
filepath=$(cd "$(dirname "$0")"; pwd)
echo $filepath
mkdir tmp
cd tmp
wget http://nginx.org/download/nginx-${version}.tar.gz
#
#
# down load upload module
wget https://codeload.github.com/vkholodkov/nginx-upload-module/zip/2.2 
#
unzip 2.2
## downlaod upload-progress
wget https://github.com/masterzen/nginx-upload-progress-module/archive/master.zip
unzip master.zip
#
tar -zxvf nginx-${version}.tar.gz
#
cd nginx-${version}
#
## 注意最后的 --add-module 路径
./configure --prefix=/usr/local/nginx --sbin-path=/usr/local/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/run/nginx.pid --lock-path=/run/lock/subsys/nginx --user=nginx --group=nginx --with-file-aio --with-ipv6 --with-http_ssl_module --with-http_spdy_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module --with-http_image_filter_module --with-http_geoip_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_stub_status_module --with-http_perl_module --with-mail --with-mail_ssl_module --with-pcre --with-google_perftools_module --with-debug --add-module=${filepath}/tmp/nginx-upload-module-2.2 --add-module=${filepath}/tmp/nginx-upload-progress-module-master


make

make install

nginx -v

nginx -V
#
#add user `nginx`  
adduser --system --no-create-home --disabled-login --disabled-password --group nginx  #add nginx user
#
# auto restart nginx  script
curl -O https://raw.githubusercontent.com/zs1621/ops/master/web_dev_env/nginx
cp nginx /etc/init.d/nginx
chmod +x /etc/init.d/nginx
update-rc.d -f nginx defaults
service nginx start
ps aux  | grep nginx
