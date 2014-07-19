#! /bin/env/bash

#aliyun mirrors
echo -e "\033[40;32mBackup the original configuration file,new name and path is /etc/apt/sources.list.bak.\n\033[40;37m"

sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak  
sudo echo "
deb http://mirrors.aliyun.com/ubuntu/ trusty main universe restricted multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty main universe restricted multiverse #Added by software-properties
" > /etc/apt/sources.list
sudo apt-get update


#安装必要的编译文件
echo -e "\033[40;32m安装编译环境\n\033[40;37m"
sudo apt-get install -y g++
sudo apt-get install -y gcc
sudo apt-get install -y build-essential
sudo apt-get install -y curl

#安装 vim
echo -e "\033[40;32m安装vim\n\033[40;37m"
sudo apt-get install -y vim


#安装 git
echo -e "\033[40;32m安装git\n\033[40;37m"
sudo apt-get install -y git

echo -e "\033[40;32m安装基本软件完毕 :)\n\033[40;37m"
