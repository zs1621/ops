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

