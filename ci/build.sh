#!/bin/sh
set -e

build_amd64()  {
cd amd64/build
	for i in $(ls -1); do
		docker build --rm=false -t $DOCKER_USER"/"$i:amd64 $i
	done
}

build_amd64
