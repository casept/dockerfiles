FROM casept/alpine-amd64:edge 
COPY install.sh /usr/local/bin/
RUN install.sh && rm /usr/local/bin/install.sh
USER tor
ENTRYPOINT ["dumb-init", "tor", "-f", "/etc/tor/torrc"]
