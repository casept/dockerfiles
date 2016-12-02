#!/bin/sh
cd amd64/build
for i in $(ls -1); do
	docker build --rm=false -t $DOCKER_USER"/"$i:$ARCH $i
done
