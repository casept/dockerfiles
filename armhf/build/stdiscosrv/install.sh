#!/bin/sh
set -e

BUILDDEPS="libressl gnupg git go musl-dev"
RUNDEPS="ca-certificates dumb-init"

apk add -U $BUILDDEPS $RUNDEPS

mkdir -p /gopath/src/github.com/syncthing
cd /gopath/src/github.com/syncthing

#Download
wget "https://github.com/syncthing/syncthing/archive/v"$ST_VERSION".tar.gz"

#Extract tarball and compile
tar -zxvf "v"$ST_VERSION".tar.gz"
mv "syncthing-"$ST_VERSION syncthing
cd syncthing
go run build.go -no-upgrade -version "v"$ST_VERSION
cp bin/stdiscosrv /usr/local/bin/stdiscosrv

#Make sure binary is owned by root
chown root:root /usr/local/bin/stdiscosrv

#Add syncthing user
adduser -S -h /home/stdiscosrv -u 8762 stdiscosrv

#The syncthing user needs proper access to directories that will be volume mounted, otherwise docker makes them owned by root
mkdir -p /home/stdiscosrv
chown -R stdiscosrv /home/stdiscosrv

#Cleanup
apk del $BUILDDEPS && rm -rf /var/cache/apk*
rm -rf /gopath
