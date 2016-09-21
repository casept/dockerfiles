FROM casept/alpine-amd64:edge 
COPY install.sh /usr/local/bin/
RUN install.sh && rm /usr/local/bin/install.sh
USER couchpotato
ENTRYPOINT ["dumb-init", "/opt/couchpotato/CouchPotato.py", "--console_log", "--data_dir", "/home/couchpotato"]
