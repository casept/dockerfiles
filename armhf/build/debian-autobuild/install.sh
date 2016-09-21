#!/bin/sh
RUNDEPS="debootstrap git libltdl7 xz-utils tar libapparmor1 iptables libdevmapper1.02.1 ca-certificates"
BUILDDEPS="wget apt-transport-https"
ARM_HYPRIOT_VERSION=

apt update && apt install -y $RUNDEPS $BUILDDEPS

#The docker repo contains scripts that build a debian rootfs using debootstrap
git clone --depth 1 --branch master --single-branch https://github.com/docker/docker.git /opt/docker

#Create a directory for finished rootfs's

