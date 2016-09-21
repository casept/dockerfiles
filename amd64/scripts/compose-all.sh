#!/bin/sh
#Script to rebuild and update all docker images and their dependants
ARCH=armhf

DOCKERFILEDIR="../build"
COMPOSEFILEDIR="../compose"

#1st phase - update all base images (images which are not directly used by compose)
#Save the script's directory so the script can return to it later
BASEDIR=$(pwd)

rebuild_base()
{
cd $DOCKERFILEDIR
#TODO: clean this shit up (use an array?)
docker build -t alpine-updated:$ARCH --no-cache alpine-updated/
docker build -t debian-updated:$ARCH --no-cache  debian-updated/
cd $BASEDIR
}


rebuild_compose()
{
#2nd phase - tear down, rebuild and redeploy all images 
cd $COMPOSEFILEDIR
#Loop through all compose files
for dir in $(find . -type d); do
  docker-compose -f $dir/docker-compose.yml build --no-cache && docker-compose -f $dir/docker-compose.yml down && docker-compose -f $dir/docker-compose.yml down && docker-compose -f $dir/docker-compose.yml up -d
done
cd $BASEDIR
}


cleanup()
{
#3rd phase - remove old and untagged images, as well as stopped containers
#TODO: find a less noisy solution for doing this
docker rm $(docker ps -a -q)
docker rmi $(docker images | grep "^<none>" | awk "{print $3}") 
}




rebuild_base
rebuild_compose
cleanup
