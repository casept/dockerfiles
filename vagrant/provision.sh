#!/bin/sh
set -e
#Add docker repo
sudo apt update && sudo apt install -y --force-yes apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
#Install docker
sudo apt update && sudo apt install -y --force-yes docker-engine

#Change graphdriver to overlayfs2
sudo service docker stop
#Remove the docker directory because it's already polluted by devicemapper
sudo rm -rf /var/lib/docker
#Actually set the graphdriver
sudo sed -i "s#ExecStart=/usr/bin/dockerd -H fd://#ExecStart=/usr/bin/dockerd --storage-driver=overlay2 -H fd://#g" /lib/systemd/system/docker.service
sudo systemctl daemon-reload
sudo service docker start

#Install docker-compose
sudo apt install -y --force-yes python3-pip
sudo pip3 install docker-compose
