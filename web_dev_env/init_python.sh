#!/bin/env/bash

# [参考](http://roundhere.net/journal/virtualenv-ubuntu-12-10/)
# [参考2](http://xiaocong.github.io/blog/2013/06/18/customize-python-dev-environment-on-ubuntu/)
# [参考3](http://brotherb.info/2013/10/30/setup-python-env/)

# 运行须知
# 1 这个脚本一般在首次部署环境时有效
# 2 这个脚本安装了 pip  , 改变了pip的源到豆瓣, 安装了virtualenv, virtualenvwrapper . 运行成功后一般 用 mkvirtualenv 创建隔离的python环境


echo "安装python运行需要的常用软件"
#安装 Python 发布版本，dev包必须安装，很多用pip安装包都需要编译
sudo apt-get install python-dev python2.7-dev python3.2-dev
# 很多pip安装需要libssl 和libevent编译环境
sudo apt-get install build-essential libssl-dev libevent-dev libjpeg-dev libxml2-dev libxslt-dev

echo "安装setup tools"

sudo apt-get install python-setuptools


echo "安装pip"

easy_install pip

echo "change pip source to douban"

if [ -e $HOME/.pip/pip.conf ]; then
    echo  "$HOME/.pip/pip.conf has exist"
else
    echo "
[global] 
index-url=http://pypi.douban.com/simple
    " >> $HOME/.pip/pip.conf
fi


#install virtualenv 
echo "install virtualenv"

sudo pip install virtualenv


if [ -d $HOME/.virtualenvs ]; then
    echo "$HOME/.virtualenvs has exists"
else
    mkdir $HOME/.virtualenvs
fi
#install virualenvwrapper (管理python虛擬環境的工具)

echo "install virtualenvwrapper"

sudo pip install virtualenvwrapper

export WORKON_HOME=~/.virtualenvs

echo ". /usr/local/bin/virtualenvwrapper.sh" >> $HOME/.bashrc

exec bash


echo "process successful"
# mkvirtualenv -p /usr/bin/python2.7 py2env    #创建一个py2env环境
# of course
# you can 创建一个 mkvirtualenv -p /usr/bin/python3.4 py3env 
# 其实一般开发的话这两种环境足以,如果还需要版本管理的话那么 [pyenv](https://github.com/yyuu/pyenv) 是个不错的选择
