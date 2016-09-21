#!/bin/sh
#dependencies needed at runtime
RUNDEPS="dumb-init python py-lxml py-openssl py-cryptography py-enum34 py-cffi ca-certificates unrar"
#dependencies needed for building the image
BUILDDEPS="wget"
#temporary directory used for downloading and extracting
BUILDDIR="/tmp/couchpotato"
#directory couchpotato is executed from
RUNDIR="/opt/couchpotato"

apk add -U $RUNDEPS $BUILDDEPS
#download and extract couchpotato
mkdir $BUILDDIR && cd $BUILDDIR
wget https://github.com/CouchPotato/CouchPotatoServer/archive/master.tar.gz
tar -zxvf master.tar.gz
#copy all files into permanent location
cd CouchPotatoServer-master
mkdir /opt && mkdir $RUNDIR && cp -r * $RUNDIR


#add couchpotato user
addgroup -g 555 media
adduser -D -h /home/couchpotato -u 585 -S -s /bin/false -G media couchpotato

#perform cleanup
apk del $BUILDDEPS && rm -rf /var/cache/apk/*
rm -rf $BUILDDIR

