#!/bin/sh

BUILDDEPS="git"
#Openssl is needed for zeronet's certificate generation
RUNDEPS="python py-msgpack py-gevent dumb-init openssl ca-certificates"
apk update && apk add $BUILDDEPS $RUNDEPS

mkdir -p /opt/ZeroNet && cd /opt
git clone https://github.com/HelloZeroNet/ZeroNet ZeroNet

adduser -h /home/zeronet -D -S -u 5785 zeronet

#Make sure a directory is writeable by the zeronet user (It's used to read the TOR cookie, needed for authenticating to the TOR control port)
#Feel free to remove this if you do not wish to use tor
mkdir -p /tor && chown zeronet /tor

#Cleanup
apk del $BUILDDEPS && rm -rf /var/cache/apk/*

