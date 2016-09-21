#!/bin/sh
RUNDEPS="xz-utils tar ca-certificates curl libltdl7 grep"

apt update && apt install -y --force-yes $RUNDEPS

#Create a directory for finished rootfs's
mkdir -p /builds
