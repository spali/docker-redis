#!/bin/bash

exec sudo -u redis -H /usr/bin/redis-server /etc/redis/redis.conf
