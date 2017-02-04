#!/bin/sh
set -e
RUNDEPS="dumb-init zlib libressl boost"
BUILDDEPS="cmake make gcc musl-dev g++ git zlib-dev libressl-dev boost-dev"

#install dependencies and download source
apk update && apk add $RUNDEPS $BUILDDEPS
mkdir /tmp/build && cd /tmp/build
git clone https://github.com/PurpleI2P/i2pd.git

#build and install
cd i2pd/build
cmake -DCMAKE_BUILD_TYPE=Release .
make -j2
make install

#create i2pd user
adduser -S -u 897 -D -s /bin/false -h /home/i2pd i2pd

#perform cleanup
rm -rf /tmp/build
apk del $BUILDDEPS
rm -rf /var/cache/apk/*
