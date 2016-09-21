FROM casept/alpine-amd64:edge 
COPY install.sh /usr/local/bin/
RUN install.sh && rm /usr/local/bin/install.sh
USER syncthing
ENTRYPOINT ["dumb-init", "syncthing", "-gui-address", "0.0.0.0:8384", "-no-browser"]
