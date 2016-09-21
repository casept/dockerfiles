FROM casept/alpine-armhf:edge 
COPY install.sh /usr/local/bin/
RUN install.sh && rm /usr/local/bin/install.sh
COPY mirror /usr/local/bin/
