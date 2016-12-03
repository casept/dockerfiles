#!/bin/sh
build_amd64_base()  {
cd amd64/compose
	cd debian-autobuild
	docker-compose build && docker-compose up 
	cd ..

	cd alpine-autobuild
	docker-compose build && docker-compose up
	cd ../../..
}

build_amd64_base

