#!/bin/sh
BUILDDEPS="wget gnupg"
RUNDEPS="emby-server-beta ffmpeg dumb-init"

apt update && apt install -y --force-yes $BUILDDEPS

echo 'deb http://download.opensuse.org/repositories/home:/emby/Debian_8.0/ /' >> /etc/apt/sources.list.d/emby-server.list 
#TODO: download key over HTTPS (or add it manually)
wget http://download.opensuse.org/repositories/home:emby/Debian_8.0/Release.key
apt-key add - < Release.key
rm Release.key
apt update && apt install -y --force-yes $RUNDEPS


addgroup --system --gid 555 media
deluser emby
adduser --system --uid 565 --ingroup media --home /home/emby --shell /bin/false --disabled-password emby

#Cleanup
apt-get remove --purge -y --force-yes $BUILDDEPS && apt-get autoremove -y --force-yes --purge && apt-get clean
