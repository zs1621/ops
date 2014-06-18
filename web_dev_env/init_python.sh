#!/bin/env/bash

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


