##怎么去部署Node程序(to be continued)
 - 参考[部署](https://github.com/nko2/website/blob/master/designs/blog/14-deploying-to-linode.md)
 - 处理Server的用户名，服务器文件目录
 - 建立本机， 服务器 和 git存放位置的ssh 关系
 - 用deploy去部署程序

##如果没有部署用户请先创建部署用户
 -  [创建部署用户](https://github.com/zs1621/ops/blob/master/add_dev_user.sh)
 -  [将本地公钥加到远程部署用户的authorized_key](https://github.com/zs1621/ops/blob/master/keygen.sh)


##[server]安装node,cnpm  [install_node.sh](https://github.com/zs1621/ops/tree/master/deploytoserver/install_node.sh)

```
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

```

##准备部署程序
 - [server]进入部署帐号
 - [server] `echo 'export NODE_ENV="production"' >> ~/.profile`
 - [server] `cat $HOME/.ssh/id_rsa.pub`
 - [server] `ssh-keygen -t rsa`
 - [server] 将其加入你托管代码的服务器(github, gitoschina....)
 - [server] `ssh -T git@github.com` 检测是否已经加入github
 - [server] `chown -R devi:devi $HOME/devi`  root权限执行


##[server]将upstart  服务器程序自启动 需要root权限  见[init_node.sh](https://github.com/zs1621/ops/tree/master/deploytoserver/init_node.sh), *注意下面的/home/devi要改为你的部署用户目录*

```
cat <<'EOF' > /etc/init/node.conf 
description "node server"

start on filesystem or runlevel [2345]
stop on runlevel [!2345]

respawn
respawn limit 10 5
umask 022

script
  HOME=/home/devi
  . $HOME/.profile
  exec /usr/local/bin/node $HOME/app/current/app.js >> $HOME/app/shared/logs/node.log 2>&1
end script

post-start script
  HOME=/home/devi
  PID=`status node | awk '/post-start/ { print $4 }'`
  echo $PID > $HOME/app/shared/pids/node.pid
end script

post-stop script
  HOME=/home/devi
  rm -f $HOME/app/shared/pids/node.pid
end script
EOF
cat <<EOF > /etc/sudoers.d/node
deploy     ALL=NOPASSWD: /sbin/restart node
deploy     ALL=NOPASSWD: /sbin/stop node
deploy     ALL=NOPASSWD: /sbin/start node
EOF
chmod 0440 /etc/sudoers.d/node
```


##在本地部署
 - [local] `git clone git@github.com:zs1621/nodefortest.git `

 - [local] `git clone https://github.com/visionmedia/deploy` and `make install`
 - [local] 创建deploy.conf文件 

```
[test]
user devi
host *.*.*.*
repo git@github.com:zs1621/nodefortest.git
ref origin/master
path /home/devi/app
post-deploy cnpm install && [ -e ../shared/pids/node.pid ] && sudo restart node || sudo start node
test sleep 1
```

 - [local] `deploy -c deploy.conf test setup`

