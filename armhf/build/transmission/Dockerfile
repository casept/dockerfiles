FROM casept/alpine-armhf:edge 
#base image for transmission
#install transmission
RUN apk add -U transmission-daemon dumb-init && rm -rf /var/cache/apk/* && \
deluser transmission && \
addgroup -g 555 -S media && \
adduser -D -S -u 973 -h /home/transmission transmission media
