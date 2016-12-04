#!/bin/sh
set -e

build_amd64_base()  {
cd amd64/build
	cd debian-autobuild
	docker build --rm=false -t $DOCKER_USER"/"debian-autobuild:amd64 .
	docker run -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker:ro -v ~/.docker/:/root/.docker/ --privileged -t $DOCKER_USER"/"debian-autobuild:amd64
	cd ..

	cd alpine-autobuild
	docker build --rm=false -t $DOCKER_USER"/"alpine-autobuild:amd64 .
	docker run -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker:ro -v ~/.docker/:/root/.docker/ -t $DOCKER_USER"/"alpine-autobuild:amd64
	cd ../../..
}

build_amd64_base
