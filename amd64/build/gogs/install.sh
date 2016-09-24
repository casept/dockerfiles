#!/bin/sh
set -e

#declare and install runtime + build dependencies
RUNDEPS="git sqlite dumb-init openssh-client"
BUILDDEPS="unzip ca-certificates openssl gcc musl-dev go"
RUNDIR="/opt/gogs"

apk add -U $RUNDEPS $BUILDDEPS

export GOPATH=/opt/go
echo "Fetching dependencies"
go get -u -tags "sqlite" github.com/gogits/gogs
cd $GOPATH/src/github.com/gogits/gogs

echo "Building gogs"
go build -tags "sqlite"

#Move gogs into permanent location
mkdir -p /opt/gogs && mv * /opt/gogs/

adduser -h /home/gogs -S -D -s /bin/false -u 438 gogs

#Make sure the gogs user has proper permissions to all needed directories
mkdir -p /home/gogs/data
mkdir -p /home/gogs/repositories
mkdir -p /home/gogs/logs
mkdir -p /home/gogs/data/ssh

chown -R gogs /home/gogs/data
chown -R gogs /home/gogs/repositories
chown -R gogs /home/gogs/logs

#perform cleanup
apk del $BUILDDEPS && rm -r /var/cache/apk/*
rm -rf /opt/go
