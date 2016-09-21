#!/bin/sh

BUILDDEPS="go git gcc musl-dev"
RUNDEPS="ca-certificates dumb-init"

apk add -U $BUILDDEPS $RUNDEPS

mkdir -p ~/src/github.com/syncthing && cd ~/src/github.com/syncthing

git clone https://github.com/syncthing/syncthing

cd syncthing
go run build.go

mv /root/src/github.com/syncthing/syncthing/bin/strelaysrv /usr/local/bin/

#Add relay user
adduser -S -h /home/relay -u 8737 relay


#Cleanup
apk del $BUILDDEPS && rm -rf /var/cache/apk*
rm -rf /root/pkg /root/src
