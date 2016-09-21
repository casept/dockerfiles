FROM casept/debian-armhf:stretch
COPY install.sh /usr/local/bin/
RUN install.sh && rm /usr/local/bin/install.sh

USER emby
ENTRYPOINT ["dumb-init", "mono-sgen", "--optimize=all", "/usr/lib/emby-server/bin/MediaBrowser.Server.Mono.exe", "-ffmpeg", "/usr/bin/ffmpeg", "-ffprobe", "/usr/bin/ffprobe", "-programdata", "/home/emby"]
