#!/bin/sh

set -e


dir=$HOME/.ssh

#查看是否存在 $HOME/.ssh
if [ -e $dir ]; then
    echo "exists"
fi
    mkdir -p $dir

pass1=""
pass2=""
email="zs1213yh@gmail.com"
USER="root"
HOST=$1


ensure_pasphrase () {
    if [ -z $pass1 ]; then
        pass1=$(tr -d '\n' < .passphrase) #从.passphrase 文件读出字符并把换行符去掉
    else
        echo -n "Passphrase for new keys:"

        stty -echo
        read pass1
        stty echo
        echo ""
        if [ "$pass1" != "" ]; then
            echo -n "Passphrase (again): "
            stty -echo
            read pass2
            stty echo
            echo ""
            if [ "$pass1" != "$pass2" ];then
                echo "Error: passphrases 不匹配"
                exit 1
            fi
        fi
        echo "$pass1" > .passphrase
    fi
}

#arrayA=($(find $HOME/.ssh/ -name *.pub | awk '{print $1}'))

userkey="$HOME/.ssh/id_rsa"

if [ -e $userkey ] && [ -e $userkey.pub ]; then
    until [ "$reply" = "y" ] || [ "$reply" = "n"]; do
        echo -n "Use existing key '$userkey' ?(y/n) "
        read reply
    done
    if [ "$reply" = "y" ]; then
        :
    else
        ssh-keygen -q -C "$email" -f $HOME/.ssh/id_rsa -P "$pass1"
    fi
fi

# tbc 
ssh $USER@$HOST "cat >> ~/.ssh/authorized_keys" < $HOME/.ssh/id_rsa.pub
