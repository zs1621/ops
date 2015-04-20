#!/usr/bin/env/bash

###############
# add newrelic to server (ubuntu12.04)
##############

sudo sh -c 'echo deb http://apt.newrelic.com/debian/ newrelic non-free >> /etc/apt/sources.list.d/newrelic.list'
wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -
wget -O- https://download.newrelic.com/548C16BF.gpg | sudo apt-key add -
apt-get update
apt-get install newrelic-sysmond
#warning write your license_key of newrelic
nrsysmond-config --set license_key=yourlicense_key
/etc/init.d/newrelic-sysmond start

