FROM casept/alpine-armhf:edge
COPY install.sh /usr/local/bin/
RUN install.sh && rm /usr/local/bin/install.sh
USER gogs
ENV USER="gogs"
ENTRYPOINT ["dumb-init", "/opt/gogs/gogs", "web"]
