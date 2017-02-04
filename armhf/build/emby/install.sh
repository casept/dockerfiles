#!/bin/sh
set -e
BUILDDEPS="wget gnupg"
RUNDEPS="emby-server-beta ffmpeg dumb-init"

apt update && apt install -y --force-yes $BUILDDEPS

echo 'deb http://download.opensuse.org/repositories/home:/emby/Debian_Next/ /' >> /etc/apt/sources.list.d/emby-server.list 
#TODO: download key over HTTPS (or add it manually)
wget http://download.opensuse.org/repositories/home:emby/Debian_8.0/Release.key
apt-key add - < Release.key
rm Release.key
apt update && apt install -y --force-yes $RUNDEPS


addgroup --system --gid 555 media
deluser emby
adduser --system --uid 565 --ingroup media --home /home/emby --shell /bin/false --disabled-password emby

#For some reason Emby looks for libembysqlite3.so.0 instead of the regular sqlite library.
#This hackaround works for now.
ln -s /usr/lib/x86_64-linux-gnu/libsqlite3.so.0 /usr/lib/x86_64-linux-gnu/libembysqlite3.so.0

#Cleanup
apt-get remove --purge -y --force-yes $BUILDDEPS && apt-get autoremove -y --force-yes --purge && apt-get clean
