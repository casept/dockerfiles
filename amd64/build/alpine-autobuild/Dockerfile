FROM casept/debian-amd64:jessie

COPY install.sh /usr/local/bin/
RUN install.sh && rm /usr/local/bin/install.sh

COPY builder.sh /usr/local/bin/

#You can set the architecture used for naming the final image here
#The images will be named using the format $HUB_USER/alpine-$ARCH:$VERSION
ENV ARCH=x86_64

ENV MIRROR=http://dl-cdn.alpinelinux.org/alpine/

ENTRYPOINT ["builder.sh"]
