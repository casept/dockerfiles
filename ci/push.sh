#!/bin/sh
set -e

push_amd64()  {
cd amd64/build
	for i in $(ls -1); do
		docker push $DOCKER_USER"/"$i:amd64
	done
}

push_amd64

