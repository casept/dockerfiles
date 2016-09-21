RUNDEPS="nzbdrone mediainfo dumb-init"
BUILDDEPS="gnupg"

apt-get update && apt-get install -y --force-yes $BUILDDEPS

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC
echo "deb http://apt.sonarr.tv/ master main" | tee /etc/apt/sources.list.d/sonarr.list
apt-get update && apt-get install -y --force-yes $RUNDEPS


addgroup --system --gid 555 media
adduser --system --uid 575 --ingroup media --home /home/sonarr --shell /bin/false --disabled-password sonarr

#Cleanup
apt-get remove --purge -y --force-yes $BUILDDEPS && apt-get autoremove -y --force-yes && apt-get clean
