#!/bin/sh

set -e

host="$1"


if [ ! "$host" ]; then
    echo "需要主机名, 如 10.10.10.10"
    exit 1
fi


ip=$(echo "$host" | sed "s/:.*//")
port=$(echo "$host" | sed "s/.*://")

echo "ip: $ip"
echo "port: $port"
