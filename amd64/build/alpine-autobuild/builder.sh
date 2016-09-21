#!/bin/sh
set -e

cleanup	()	{
echo "Removing "$ALPINE_VERSION
rm -rf "/builds/"$ALPINE_VERSION
rm -rf "/tmp/"$ALPINE_VERSION
echo "Removed "$ALPINE_VERSION
}


build_rootfs ()	{
	ALPINE_VERSION=$1
	ALPINE_MIRROR=$2

	#Remove old rootfs
	cleanup $ALPINE_VERSION
	echo "Building alpine "$ALPINE_VERSION" rootfs"


	#Download static apk-tools and use it to bootstrap the rest of the rootfs
	#First, we need to obtain the version of the apk-tools-static package
	APKTOOLS_VERSION=$(curl -sSL $MIRROR"/"$ALPINE_VERSION"/main/"$ARCH"/APKINDEX.tar.gz" | tar -Oxz | grep --text '^P:apk-tools-static$' -A1 | tail -n1 | cut -d: -f2)


	#Next, we download and extract the package
	mkdir -p /tmp/$ALPINE_VERSION

	curl -o "/tmp/"$ALPINE_VERSION"/apk-tools-static-"$APKTOOLS_VERSION \
	$MIRROR"/"$ALPINE_VERSION"/main/"$ARCH"/apk-tools-static-"$APKTOOLS_VERSION".apk"

	tar -zxvf "/tmp/"$ALPINE_VERSION"/apk-tools-static-"$APKTOOLS_VERSION -C "/tmp/"$ALPINE_VERSION

	#And add some repositories
	mkdir -p "/builds/"$ALPINE_VERSION"/rootfs/etc/apk"

	echo $MIRROR"/"$ALPINE_VERSION"/main" > "/builds/"$ALPINE_VERSION"/rootfs/etc/apk/repositories"
	echo $MIRROR"/"$ALPINE_VERSION"/community" >> "/builds/"$ALPINE_VERSION"/rootfs/etc/apk/repositories"
	#Add testing repo if we are building edge
	if [ $ALPINE_VERSION = "edge" ]
	then
		echo $MIRROR"/"$ALPINE_VERSION"/testing" >> "/builds/"$ALPINE_VERSION"/rootfs/etc/apk/repositories"
	fi

	#Next, we create rootfs directory and bootstrap the rootfs
	mkdir -p "/builds/"$ALPINE_VERSION

	/tmp/$ALPINE_VERSION/sbin/apk.static --repository $ALPINE_MIRROR"/"$ALPINE_VERSION"/main" --no-cache \
	 --allow-untrusted --root "/builds/"$ALPINE_VERSION"/rootfs" --initdb add alpine-base


	#Then, we tar it up
	cd "/builds/"$ALPINE_VERSION"/rootfs"
	tar -cf - . | xz -9 -c - > ../rootfs.tar.xz

	#And finally, we write a simple Dockerfile
	echo "FROM scratch" > "/builds/"$ALPINE_VERSION/Dockerfile
	echo "ADD rootfs.tar.xz /" >> "/builds/"$ALPINE_VERSION/Dockerfile
	echo 'CMD ["/bin/sh"]' >> "/builds/"$ALPINE_VERSION/Dockerfile

	echo "Built alpine "$ALPINE_VERSION" rootfs successfully"
}


build_image ()	{
#Turn the rootfs file into a docker image
	ALPINE_VERSION=$1
	DOCKER_TAG=$2

	cd "/builds/"$ALPINE_VERSION

	if [ $ARCH = "x86_64" ];
		then
			docker build -t $HUB_USER/alpine-amd64:$DOCKER_TAG .
		else
			docker build -t $HUB_USER/alpine-$ARCH:$DOCKER_TAG .
	fi

	echo "Built alpine "$ALPINE_VERSION" docker image, tagged as "$DOCKER_TAG
}


push_image ()	{
	DOCKER_TAG=$1
	#Push images to docker hub
	#I prefer the name "amd64" to x86_64

	if [ $ARCH = "x86_64" ];
		then
			docker push $HUB_USER/alpine-amd64:$DOCKER_TAG
		else
			docker push $HUB_USER/alpine-$ARCH:$DOCKER_TAG
	fi
}


build_all ()	{
	#Build rootfs
	build_rootfs edge
	build_rootfs latest-stable
	build_rootfs v3.4
	build_rootfs v3.3
	echo "All rootfs built, now building docker images."


	#Turn those rootfs tarballs into docker images
	#Specify which tag to use in the format build_image NAME_OF_ROOTFS DOCKER_TAG
	#Alpine version 3.2 and below requires differrent configuration which I'm too lazy to figure out
	build_image edge          edge
	build_image latest-stable latest
	build_image v3.4          3.4
	build_image v3.3          3.3
	echo "Docker images built successfully."

	#Push images to docker hub
	echo "Pushing to docker hub"
	push_image edge 
	push_image latest
	push_image 3.4
	push_image 3.3
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
