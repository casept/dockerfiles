FROM casept/alpine-armhf:edge

ENV NZBGET_VERSION=17.1

COPY install.sh /usr/local/bin/

#Copy config and set permissions
COPY nzbget.conf /home/nzbget/nzbget.conf

RUN install.sh && rm /usr/local/bin/install.sh

USER nzbget

ENTRYPOINT ["dumb-init", "nzbget", "-s", "-c", "/home/nzbget/nzbget.conf"]
