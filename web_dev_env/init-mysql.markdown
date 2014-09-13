# Mysql5.6+ 安装
 - 环境: ubuntu12.04 ubuntu14.04

# 当你安装了mysql 5.6以下版本
 - 参考 [升级](https://rtcamp.com/tutorials/mysql/mysql-5-6-ubuntu-12-04/)
 - 如果你要下载5.6.20 那就可以在链接是这个`http://dev.mysql.com/downloads/mysql/` 选择 debian -> 32-bit/64-bit
  - 32bit: `http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.20-debian6.0-i686.deb`
  - 64bit: `http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.20-debian6.0-x86_64.deb`

# 安装过程遇到的坑

 - swap不够, 导致如下错误
   - 当然不是这种错误都是需要增加swap，我出现这种问题是因为我的服务器内存只有512M, 启动时内存不够就需要swap. `free -m`可以查看你的内存和swap情况，如果需要添加 那么请戳[添加swap](https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-14-04) *我使用的是the faster way*

```
InnoDB: Initializing buffer pool, size = 128.0M
InnoDB: mmap(137363456 bytes) failed; errno 12
```
 
 - 在上面的教程最后， 你是升级mysql, 需要 `mysql_update -uroot -p`, 不然会出现[升级出错](http://www.live-in.org/archives/2019.html)


# 如果系统没有msql5.6以下的版本

 - 


