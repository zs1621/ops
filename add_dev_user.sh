#!/bin/sh

#########################################
# this shell do 2 things
# 1. add a dev user for deploy and login
# 2. generate rsapub for dev-user
#########################################

set -e

DEVUSER="devi"

###################
# create dev user
###################


groupadd -r -f "$DEVUSER"

if [ ! $(grep '^$DEVUSER:' /etc/passwd) ]; then
    if ! useradd -r -s /bin/bash -d /home/$DEVUSER -g $DEVUSER $DEVUSER; then
       echo "command fail";
    fi
fi


if [ ! -d /home/$DEVUSER/.ssh ]; then
    mkdir -p /home/$DEVUSER/.ssh
    chown $DEVUSER:$DEVUSER /home/$DEVUSER/.ssh
    chmod 700 /home/$DEVUSER/.ssh
fi

passwd -l $DEVUSER


##################################
# add .ssh/authorized_keys for root
###################################

mkdir -p $HOME/.ssh
touch $HOME/.ssh/authorized_keys

############################
# ssh-keygen for github
###########################

su $DEVUSER
#ssh-keygen -t rsa -C "zs1213yh@gmail.com"  TODO：shell auto 

