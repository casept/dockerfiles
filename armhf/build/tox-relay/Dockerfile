FROM casept/alpine-armhf:edge 
COPY install.sh /usr/local/bin/
#copy config file that does not yet contain any bootstrap nodes
COPY unfinished_config.conf /unfinished_config.conf 
RUN install.sh && rm /usr/local/bin/install.sh

USER tox
ENTRYPOINT ["dumb-init", "tox-bootstrapd", "--foreground", "--config=/etc/tox-bootstrapd.conf", "--log-backend=stdout"]
