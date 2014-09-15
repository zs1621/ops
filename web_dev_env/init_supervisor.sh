#!/usr/bin/env/bash

##############################
# install supervisor on ubuntu
##############################

set -e

# install supervisor (pip > 1.4, pip --version)
pip install supervisor --pre
# default config file 
echo_supervisord_conf > /etc/supervisord.conf

# download server script  auto init
curl -O https://gist.githubusercontent.com/zs1621/dc053e0de62f669c1899/raw/7c13a3925ed81abbc81b8fa30c98f9c91f26f2c9/supervisord 

cp supervisord /etc/init.d/

chmod +x /etc/init.d/supervisord

# join system server
update-rc.d supervisord defaults

# start
service supervisord start

ps aux | grep supervisor

