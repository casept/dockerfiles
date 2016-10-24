#!/bin/sh
set -e

RUNDEPS="dumb-init"
BUILDDEPS="go git musl-dev ca-certificates libressl"

apk update && apk add $RUNDEPS $BUILDDEPS

#Set GOPATH
export GOPATH="/opt/go"

#Install dependencies
install_gx()	{
echo "Downloading gx"
go get -u github.com/whyrusleeping/gx
echo "Downloading gx-go"
go get -u github.com/whyrusleeping/gx-go

cd $GOPATH/src/github.com/whyrusleeping/gx
go build && cp gx /usr/local/bin/

cd $GOPATH/src/github.com/whyrusleeping/gx-go
go build && cp gx-go /usr/local/bin/
}


install_ipfs()	{
echo "Downloading go-ipfs"
go get -u github.com/ipfs/go-ipfs

echo "Installing dependencies of go-ipfs"
cd $GOPATH/src/github.com/ipfs/go-ipfs
gx install

echo "Building go-ipfs"
go build ./cmd/ipfs

echo "Installing go-ipfs"
cp ipfs /usr/local/bin/
}

cleanup()	{
echo "Cleaning up"

echo "Removing gx"
rm /usr/local/bin/gx*

echo "Removing packages"
apk del $BUILDDEPS
rm -rf /var/cache/apk/*

echo "Removing source code"
rm -rf $GOPATH
}

install_gx
install_ipfs


adduser -h /home/ipfs -D -S -u 5444 ipfs


cleanup
