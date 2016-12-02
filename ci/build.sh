#!/bin/sh
cd amd64/build
for i in $(ls -1); do
	docker build --rm=false -t $HUB_USER"/"$i:$ARCH $i
done
