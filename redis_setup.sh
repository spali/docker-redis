#!/bin/bash

# exit on any non-zero status
set -e

# set configuration
sed 's/daemonize yes/daemonize no/' -i /etc/redis/redis.conf
sed 's/bind 127.0.0.1/bind 0.0.0.0/' -i /etc/redis/redis.conf
sed '/^logfile/d' -i /etc/redis/redis.conf

# fix permissions and ownership of /var/lib/redis
chown -R redis:redis /var/lib/redis
chmod 700 /var/lib/redis

