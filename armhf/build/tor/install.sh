#!/bin/sh

RUNDEPS="tor dumb-init"
apk update && apk add $RUNDEPS

deluser tor
adduser -h /home/tor -D -S -u 5785 tor

#Create and own a directory that can be mounted into the container to share tor control port auth cookie
mkdir -p /tor && chown tor /tor

#Cleanup
rm -rf /var/cache/apk/*
