FROM casept/alpine-amd64:edge 

#Syncthing version
ENV ST_VERSION="0.14.15"

COPY install.sh /usr/local/bin/
RUN install.sh && rm /usr/local/bin/install.sh
USER stdiscosrv
#TODO: setup HTTPS
ENTRYPOINT ["dumb-init", "stdiscosrv", "-http", "", "-no-browser"]
