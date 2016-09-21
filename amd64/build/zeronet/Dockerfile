FROM casept/alpine-amd64:edge 
COPY install.sh /usr/local/bin/
RUN install.sh && rm /usr/local/bin/install.sh
USER zeronet
#For some reason ZN does not like being started from outside it's install directory
WORKDIR /opt/ZeroNet
ENTRYPOINT ["dumb-init", "python2", "/opt/ZeroNet/zeronet.py", "--ui_ip", "0.0.0.0", "--data_dir", "/home/zeronet/data", "--log_dir", "/home/zeronet/logs"]

