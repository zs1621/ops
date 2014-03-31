#!/bin/sh

set -e


dir=$HOME/.ssh

pass1=""
pass2=""
email="" #your email optional
USER="root" # remote host user, defaut root
HOST=$1
Remote_host_name="" # ssh Remote_host_name 
Local_ssh_config="$HOME/.ssh/config" #local ssh config path


if [ -e "$Local_ssh_config" ]; then
    :
else
    touch $Local_ssh_config
fi
    
echo "
Host $Remote_host_name
    HostName $HOST
    Port 22
    User $USER
" >> $Local_ssh_config


if [ -z $HOST ]; then
    echo "
        useage: sh keygen.sh yourhostname(10.10.10.10)
    "
    exit 1
fi


#查看是否存在 $HOME/.ssh
if [ -e $dir ]; then
    echo "exists"
fi
    mkdir -p $dir



#密码生成
ensure_passphrase () {
    if [ -z $pass1 ]; then
        if [ -e ".passphrase" ]; then
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
    fi
}

ensure_passphrase


userkey="$HOME/.ssh/id_rsa"

if [ -e $userkey ] && [ -e $userkey.pub ]; then
    echo -n "Use existing key '$userkey' ?(y/n) "
    read reply
    if [ "$reply" = "y" ]; then
        :
    elif [ "$reply" = "n" ]; then
        #back up origin .ssh to sshbackup
        if [ -d "$HOME/sshbackup" ]; then
            :
        else
            mkdir $HOME/sshbackup
        cp -R $HOME/.ssh/ $HOME/sshbackup
        ssh-keygen -q -C "$email" -f $HOME/.ssh/id_rsa -P "$pass1"
        fi
    else
        echo "Please input y or n"
    fi
else
    if [ -d "$HOME/sshbackup" ]; then
            :
        else
            mkdir $HOME/sshbackup
        cp -R $HOME/.ssh/ $HOME/sshbackup
        ssh-keygen -q -C "$email" -f $HOME/.ssh/id_rsa -P "$pass1"
    fi
fi

#


# tbc 
ssh $USER@$HOST "cat >> ~/.ssh/authorized_keys" < $HOME/.ssh/id_rsa.pub #把本地生成的公钥添加入远程服务器的authorized_keys
