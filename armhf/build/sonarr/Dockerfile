#For some reason mediainfo is not avaiable in testing, so we have to use sid
FROM casept/debian-armhf:unstable 
COPY install.sh /usr/local/bin/
RUN install.sh && rm /usr/local/bin/install.sh
USER sonarr
ENTRYPOINT ["dumb-init", "mono-sgen", "/opt/NzbDrone/NzbDrone.exe", "--no-browser", "-data=/home/sonarr"]
