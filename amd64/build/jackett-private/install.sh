#!/bin/sh
RUNDEPS="mono-runtime-sgen libmono*-cil libcurl4-openssl-dev curl openssl ca-certificates dumb-init"
BUILDDEPS="wget xz-utils nuget git mono-complete"
apt-get update && apt-get install -y --force-yes $BUILDDEPS $RUNDEPS


cd /opt
#There are no ARM binaries, therefore we have to build from source
git clone https://github.com/Jackett/Jackett jackett

cd jackett

cd src

#Install missing nuget packages
cd Jackett
nuget restore -PackagesDirectory ../packages
cd ..

cd Jackett.Console
nuget restore -PackagesDirectory ../packages
cd ..

cd Jackett.Service
nuget restore -PackagesDirectory ../packages
cd ..

cd Jackett.Test
nuget restore -PackagesDirectory ../packages
cd ..

cd Jackett.Tray
nuget restore -PackagesDirectory ../packages
cd ..

cd Jackett.Updater
nuget restore -PackagesDirectory ../packages
cd ..

#Build
xbuild Jackett.sln /t:Clean 
xbuild Jackett.sln /t:Build /p:Configuration=Release /verbosity:minimal

#Add jackett user
adduser --system --home /home/jackett --uid 5810 --shell /bin/false --disabled-password jackett

#Set permissions
chmod -R 755 /opt/jackett

#For some reason jakett needs write access to the Content directory
chmod -R 777 /opt/jackett/src/Jackett.Console/bin/Release/Content

#Cleanup
apt-get remove -y --force-yes --purge $BUILDDEPS && apt-get autoremove -y --force-yes --purge && apt-get clean
