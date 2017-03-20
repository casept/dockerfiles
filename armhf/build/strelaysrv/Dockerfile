FROM casept/alpine-armhf:edge

#Syncthing version
ENV ST_VERSION="0.14.24"

COPY install.sh /usr/local/bin/
RUN install.sh && rm /usr/local/bin/install.sh

WORKDIR /home/strelaysrv
ENTRYPOINT ["dumb-init", "strelaysrv", "-keys=/home/strelaysrv/keys/", "listen=22067"]
