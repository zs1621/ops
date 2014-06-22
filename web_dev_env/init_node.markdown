
> 参考 [CNDOE](http://cnodejs.org/topic/5338c5db7cbade005b023c98)
##安装node 版本管理 nvm


```
git clone https://github.com/creationix/nvm.git ~/git/
```


###配置nvm 环境, 将其加入配置文件, 配置完重启终端

```
echo "
export NVM_NODEJS_ORG_MIRROR=http://dist.u.qiniudn.com
source ~/git/nvm/nvm.sh
" >> .bashrc
exec bash
```

###用nvm安装v0.10.26


```
nvm install v0.10.26 
nvm use $version
node -v 
npm -v
```


###安装`cnpm cli`
 - [cnpm](http://npm.taobao.org/)


```
npm install -g cnpm -registry=http://registry.npm.taobao.org 
cnpm -v
```


