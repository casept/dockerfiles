FROM casept/debian-amd64:jessie

COPY install.sh /usr/local/bin/
RUN install.sh && rm /usr/local/bin/install.sh

COPY builder.sh /usr/local/bin/

#You can set the architecture used for naming the final image here
#The images will be named using the format debian-$ARCH:$VERSION
ENV ARCH=amd64
#This enviromental variable controls which debian mirror URL is used
#This mirror is used both during the build phase and in the final image
ENV MIRROR=http://debian.koyanet.lv/debian

ENTRYPOINT ["builder.sh"]
