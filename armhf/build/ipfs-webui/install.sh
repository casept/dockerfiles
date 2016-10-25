#!/bin/sh
set -e

RUNDEPS="nodejs dumb-init"
BUILDDEPS="git ca-certificates"

apk update && apk add $RUNDEPS $BUILDDEPS


mkdir -p /opt && cd /opt
git clone https://github.com/ipfs/webui
cd webui && npm install
npm run build

apk del $BUILDDEPS && rm -rf /var/cache/apk/*

adduser -h /home/ipfs -D -S -u 5443 ipfs
