#!/usr/bin/env/bash
#################################
# install n(node package install)
#################################


mkdir -p $HOME/git


cd $HOME/git

if [ -d $HOME/git/n ]; then
        echo "n dir has exist"
else
        if ! git clone https://github.com/visionmedia/n.git; then
                echo "download n failure"
        fi
fi

cd n

make install

n stable #默认安装稳定版node

echo `node -v`

echo `npm -v`

npm install -g cnpm -registry=http://registry.npm.taobao.org 

echo `cnpm -v`

