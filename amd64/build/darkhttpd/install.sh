#!/bin/sh
#Install rsync
apk add -U darkhttpd

#Add a user that runs the mirror
addgroup -S -g 252 mirror
deluser darkhttpd
adduser -D -S -h /home/mirror -s /bin/ash -u 253 -G mirror darkhttpd 

#Cleanup
rm -rf /var/cache/apk/*
