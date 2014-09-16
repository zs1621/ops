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


###########################
# compile nginx
##########################

version="1.6.1"

# install need 
apt-get install build-essential zlib1g-dev libpcre3-dev libssl-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev


mkdir tmp
cd tmp
wget http://nginx.org/download/nginx-${version}.tar.gz


./configure --prefix=/usr/local/nginx --sbin-path=/usr/local/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/run/nginx.pid --lock-path=/run/lock/subsys/nginx --user=nginx --group=nginx --with-file-aio --with-ipv6 --with-http_ssl_module --with-http_spdy_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module --with-http_image_filter_module --with-http_geoip_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_stub_status_module --with-http_perl_module --with-mail --with-mail_ssl_module --with-pcre --with-google_perftools_module --with-debug --add-module=/root/tmp/nginx/module/nginx-upload-module-2.2 --add-module=/root/tmp/nginx/module/nginx-upload-progress-module-master

make

make install

nginx -v

nginx -V

