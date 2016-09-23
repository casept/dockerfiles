#!/bin/sh
set -e

BUILDDEPS="g++ make automake openssl-dev libxml2-dev git"
RUNDEPS="ca-certificates openssl libxml2 libstdc++ dumb-init"

apk update && apk add $BUILDDEPS $RUNDEPS

#Download and compile
mkdir -p /tmp && cd /tmp
wget https://github.com/nzbget/nzbget/releases/download/v$NZBGET_VERSION/nzbget-"$NZBGET_VERSION"-src.tar.gz
tar -zxvf nzbget-"$NZBGET_VERSION"-src.tar.gz

cd nzbget-$NZBGET_VERSION

./configure --disable-curses
make -j2
make install-strip

#Add nzbget user
addgroup -g 555 media
adduser -D -h /home/nzbget -u 515 -S -s /bin/false -G media nzbget

#Create and set permissions
mkdir /home/nzbget/downloads && chown -R nzbget:media /home/nzbget/downloads
mkdir /home/nzbget/misc && chown -R nzbget:media /home/nzbget/misc

#Make sure user can write nzbget config file
chown nzbget:media /home/nzbget/nzbget.conf

#Cleanup
apk del $BUILDDEPS
rm -rf /var/cache/apk/*
rm -rf /tmp/*
