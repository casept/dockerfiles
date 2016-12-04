#!/bin/sh
set -e
#Add docker repo
sudo apt update && sudo apt install -y --force-yes apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
#Install docker
sudo apt update && sudo apt install -y --force-yes docker-engine

#Install docker-compose
sudo apt install -y --force-yes python3-pip
sudo pip3 install docker-compose
