FROM casept/alpine-armhf:edge

ENV NZBGET_VERSION=17.1

COPY install.sh /usr/local/bin/
RUN install.sh && rm /usr/local/bin/install.sh

USER nzbget
