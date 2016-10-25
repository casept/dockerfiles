FROM casept/alpine-armhf:edge
COPY install.sh /usr/local/bin/
RUN install.sh && rm /usr/local/bin/install.sh
WORKDIR /opt/webui

USER ipfs
ENTRYPOINT ["dumb-init", "npm", "start"]
