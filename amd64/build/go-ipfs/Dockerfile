FROM casept/alpine-amd64:edge
COPY install.sh /usr/local/bin/
RUN install.sh && rm /usr/local/bin/install.sh

COPY ipfs.sh /usr/local/bin/
USER ipfs
ENTRYPOINT ["dumb-init", "ipfs.sh"]
