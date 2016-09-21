FROM casept/debian-amd64:stretch
COPY install.sh /usr/local/bin
RUN install.sh && rm /usr/local/bin/install.sh

USER jackett
ENTRYPOINT ["dumb-init", "mono-sgen", "--optimize=all", "/opt/jackett/src/Jackett.Console/bin/Release/JackettConsole.exe", "--ListenPublic"]
