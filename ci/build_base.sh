#!/bin/sh
build_amd64_base()  {
cd amd64/compose
	cd debian-autobuild
	docker-compose up --build
	cd ..

	cd alpine-autobuild
	docker-compose up --build
}

build_amd64
