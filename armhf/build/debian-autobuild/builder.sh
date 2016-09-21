#!/bin/sh
cd /opt/docker/contrib/

cleanup	()	{
cd /builds
echo "Removing "$DEBIAN_VERSION
rm -rf $DEBIAN_VERSION
echo "Removed "$DEBIAN_VERSION
}


build_rootfs ()	{
	DEBIAN_VERSION=$1
	DEBIAN_MIRROR=$2

	cleanup $DEBIAN_VERSION
	echo "Building debian "$DEBIAN_VERSION" rootfs"
	/opt/docker/contrib/mkimage.sh -d "/builds/"$DEBIAN_VERSION debootstrap --variant=minbase --components=main $DEBIAN_VERSION $MIRROR
	echo "Built debian "$DEBIAN_VERSION" rootfs successfully"
}


build_image ()	{
#Turn the rootfs file into a docker image
	DEBIAN_VERSION=$1
	DOCKER_TAG=$2

	cd "/builds/"$DEBIAN_VERSION
	docker build -t $HUB_USER/"debian-"$ARCH":"$DOCKER_TAG .

	echo "Built debian "$DEBIAN_VERSION" docker image, tagged as "$DOCKER_TAG
}

push_image ()	{
DOCKER_TAG=$1
#Push images to docker hub
docker push $HUB_USER/debian-$ARCH:$DOCKER_TAG
}

build_all ()	{
	#Build rootfs using debootstrap
	build_rootfs jessie
	build_rootfs stretch
	build_rootfs wheezy
        build_rootfs sid
	echo "All rootfs built, now building docker images."
	

	#Turn those rootfs tarballs into docker images
	#Specify which tag to use in the format build_image NAME_OF_ROOTFS DOCKER_TAG
	build_image jessie jessie
	build_image jessie latest 
	build_image jessie stable
	build_image jessie 8

	build_image wheezy oldstable
	build_image wheezy wheezy
	build_image wheezy 7

	build_image stretch stretch
	build_image stretch testing
	build_image stretch 9

	build_image sid sid	
	build_image sid unstable
	echo "Docker images built successfully."

	#Push images to docker hub
	echo "Pushing to docker hub"
	push_image jessie
	push_image latest 
	push_image stable
	push_image 8

	push_image oldstable
	push_image wheezy
	push_image 7

	push_image stretch
	push_image testing
	push_image 9

	push_image sid
	push_image unstable
	echo "All images pushed successfully."
}


#Main
#Build all on script start
build_all

#Rebuild every 24h
while :
	do
		sleep 24h
		build_all
	done
