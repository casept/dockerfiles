FROM casept/alpine-armhf:edge
COPY install.sh /usr/local/bin/
RUN install.sh && rm /usr/local/bin/install.sh
USER i2pd
ENTRYPOINT ["dumb-init", "i2pd"]
