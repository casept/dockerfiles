#!/bin/sh
#This script is currently WIP and has to be run in the $ARCH/scripts directory.
set -e

ARCH=amd64
HUB_USERNAME=casept

#Rebuild the base images
#cd ../compose/alpine-autobuild
#docker-compose build --force && docker-compose up
#cd ../compose/debian-autobuild
#docker-compose build --force && docker-compose up

#Now rebuild all other images
cd ../build

for dir in $(ls -1)
	do
	cd "$dir"
	docker build --no-cache -t $HUB_USERNAME"/"$dir":"$ARCH .
        docker push $HUB_USERNAME"/"$dir":"$ARCH
	cd -
done

