#! /bin/env/bash

#更新源 163 和 aliyun
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak  
sudo echo "
deb http://mirrors.163.com/ubuntu/ precise main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ precise-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ precise-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ precise-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ precise-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ precise main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ precise-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ precise-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ precise-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ precise-backports main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ trusty main universe restricted multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty main universe restricted multiverse #Added by software-properties
" > /etc/apt/sources.list
sudo apt-get update


#安装必要的编译文件
echo "安装编译环境"
sudo apt-get install -y g++
sudo apt-get install -y gcc
sudo apt-get install -y build-essential

#安装 vim
echo "安装vim"
sudo apt-get install -y vim


#安装 git
echo "安装git"
sudo apt-get install -y git


echo "安装基本软件完毕 :)"
