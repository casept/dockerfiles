#!/bin/sh
VERSION="0.14.7"
ARCH="amd64"

BUILDDEPS="openssl gnupg"
RUNDEPS="ca-certificates dumb-init"

apk add -U $BUILDDEPS $RUNDEPS

#TODO: automatically bump versions or use official alpine packages
mkdir -p /tmp/syncthing && cd /tmp/syncthing

#Download
wget "https://github.com/syncthing/syncthing/releases/download/v"$VERSION"/syncthing-linux-"$ARCH"-v"$VERSION".tar.gz"
wget "https://github.com/syncthing/syncthing/releases/download/v"$VERSION"/sha256sum.txt.asc"


#Download key and verify PGP signature
#gpg --keyserver pool.sks-keyservers.net --recv-key D26E6ED000654A3E

#We first have to verify the sha256 checksum file, then use that to estabilish whether the tarball is authentic
#ISGOODSIG=`gpg --verify sha256sum.txt.asc | grep "Good signature from"`



#echo $ISGOODSIG


#if [ "$ISGOODSIG" = 'gpg: Good signature from "Syncthing Release Management <release@syncthing.net>" [unknown]' ] ; then
#	echo "Checksum file signature is valid, proceeding."
#else
#	echo "Invalid signature for checksum file! Either you're under attack or the keyserver is down. Aborting."
#	exit 1
#fi
#
#
#if sha256sum -c sha256sum.txt.asc | grep "OK" = "syncthing-linux-"$ARCH"-v"$VERSION".tar.gz: OK" ; then
#	echo "Hash matches, tarball is authentic."
#else
#	echo "Invalid tarball checksum! Aborting."
#	exit 1
#fi
#
#}

#Extract tarball and move binary
tar -zxvf "syncthing-linux-"$ARCH"-v"$VERSION".tar.gz"
mv syncthing*/syncthing /usr/local/bin/

#Make sure binary is owned by root
chown root:root /usr/local/bin/syncthing

#Add syncthing user
adduser -S -h /home/syncthing -u 8732 syncthing

#The syncthing user needs proper access to directories that will be volume mounted, otherwise docker makes them owned by root
mkdir -p /home/syncthing/.config/syncthing
chown -R syncthing /home/syncthing/.config/syncthing

mkdir -p /home/syncthing/files
chown -R syncthing /home/syncthing/files



#Cleanup
apk del $BUILDDEPS && rm -rf /var/cache/apk*
rm -rf /root/.gnupg
rm -rf /tmp/syncthing/*
