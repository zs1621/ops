#!/bin/sh

#==========一些配置参数================

#创建ftp路径
path="your_ftp_path"
#ftp用户名
ftp_user_name="your_ftp_user_name"
#ftp用户组
ftp="ftp"
#=========================


if [ -d $path ]; then
    :
else
    mkdir -pv $path
fi


#参考[vsftp](http://blog.thefrontiergroup.com.au/2012/10/making-vsftpd-with-chrooted-users-work-again/)
vsftpd_version=`dpkg-query -W -f='${Version}\n' vsftpd`
version_len=`expr match "$vsftpd_version" '[0-9]\.[0-9]\.[0-9]'`
if [ $version_len -lt 3 ]; then
    #卸载vsftpd 但是不移除配置文件 
    sudo apt-get remove vsftpd 
    # 这里的升级不一定是vsftpd
    sudo apt-get update
    sudo apt-get install vsftpd
else
    :
fi

if [ -e '/etc/vsftpd.conf' ]; then
    mv /etc/vsftpd.conf /etc/vsftpd.conf.backup
else
    :
fi

#write config file
echo "
listen=YES
#no anonymous login
anonymous_enable=NO
#allow local login
local_enable=YES
#enable write
write_enable=YES
#
local_umask=022
#local user upload file permission
file_open_mode=0755
#all user cannot switch other directory, only operate in ownself 
chroot_list_enable=NO
chroot_local_user=YES
#welocme words allow
dirmessage_enable=YES
#display directory listings with the time in your local time zone
use_localtime=YES
#make sure port transfert connection
connect_from_port_20=YES
#
idle_session_timeout=600
#
data_connection_timeout=120
#
allow_writeable_chroot=YES
local_root=$path
# This option should be the name of a directory which is empty.  Also, the
# directory should not be writable by the ftp user. This directory is used
# as a secure chroot() jail at times vsftpd does not require filesystem
# access.
secure_chroot_dir=/var/run/vsftpd/empty
#
# This string is the name of the PAM service vsftpd will use.
pam_service_name=vsftpd
#
# This option specifies the location of the RSA certificate to use for SSL
# encrypted connections.
rsa_cert_file=/etc/ssl/private/vsftpd.pem
" >> /etc/vsftpd.conf

/etc/init.d/vsftpd restart

#add ftp user
useradd -d $path -g $ftp $ftp_user_name
chmod 755 -R $path
chown -R $ftp_user_name $path

#check vsftp run success
pid=`pgrep vsftpd`

if [ -z $pid ]; then
    echo -e "\033[1;40;31mvsftpd run fail.\n\033[0m"
else
    echo -e "\033[40;32mvsftpd run success.\n\033[0m"
fi
