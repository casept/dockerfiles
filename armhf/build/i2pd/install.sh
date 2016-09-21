#!/bin/sh
RUNDEPS="dumb-init zlib1g openssl libboost-chrono1.61.0 libboost-date-time1.61.0 libboost-filesystem1.61.0 libboost-program-options1.61.0 libboost-system1.61.0 libboost-thread1.61.0"
BUILDDEPS="cmake build-essential git libboost1.61-all-dev libssl-dev"

#install dependencies and download source
apt update && apt install -y --force-yes $RUNDEPS $BUILDDEPS
mkdir /tmp/build && cd /tmp/build
git clone https://github.com/PurpleI2P/i2pd.git

#build and install
cd i2pd/build
cmake -DCMAKE_BUILD_TYPE=Release .
make
make install

#create i2pd user
adduser --system --uid 897 --home /home/i2pd i2pd

#perform cleanup
rm -rf /tmp/build
apt-get remove -y --purge $BUILDDEPS && apt-get autoremove -y --purge
apt-get clean
