#!/bin/sh
set -e
RUNDEPS="dumb-init zlib libressl boost"
BUILDDEPS="cmake make gcc musl-dev g++ zlib-dev libressl-dev boost-dev ca-certificates"

#install dependencies and download source
apk update && apk add $RUNDEPS $BUILDDEPS
mkdir /tmp/build && cd /tmp/build
wget https://github.com/PurpleI2P/i2pd/archive/2.12.0.tar.gz
tar -zxvf $I2PD_VERSION".tar.gz"

#build and install
cd "i2pd-"$I2PD_VERSION"/build" 
cmake -DCMAKE_BUILD_TYPE=Release .
make -j2
make install

#create i2pd user
adduser -S -u 897 -D -s /bin/false -h /home/i2pd i2pd

#perform cleanup
rm -rf /tmp/build
apk del $BUILDDEPS
rm -rf /var/cache/apk/*
