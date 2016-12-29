FROM casept/alpine-armhf:edge 

#Syncthing version
ENV ST_VERSION="0.14.17"

COPY install.sh /usr/local/bin/
RUN install.sh && rm /usr/local/bin/install.sh
USER stdiscosrv
#TODO: setup HTTPS
ENTRYPOINT ["dumb-init", "stdiscosrv", "-http", "", "-no-browser"]
