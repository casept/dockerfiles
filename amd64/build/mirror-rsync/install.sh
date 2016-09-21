#!/bin/sh
apk add -U rsync dumb-init && rm -rf /var/cache/apk/*
adduser -S -u 252 -h /home/mirror mirror
