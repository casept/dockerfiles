FROM casept/debian-amd64:sid
RUN apt update && apt install -y --force-yes wget chromium pulseaudio chromium-l10n fonts-liberation fonts-roboto hicolor-icon-theme libcanberra-gtk-module libexif-dev libgl1-mesa-dri libgl1-mesa-glx libpango1.0-0 libv4l-0 sudo dumb-init && apt-get clean && \

#Add some extensions
mkdir -p /opt/chrome-extensions && cd /opt/chrome-extensions

#Google are assfeeders when it comes to letting you download the .crx files of extensions in the chrome web store, so we have to use a 3rd party service

#First, ublock origin
#wget http://clients2.google.com/service/update2/crx?response=redirect&x=id%3D%3Ccjpalhdlnbpafiamejdnhcphjbkeiagm%3E%26uc%26lang%3Den-US&prod=chrome 



#Add chromium user
#TODO: make this work when host UID != 1000
RUN adduser --system --uid 1000 --home /home/chromium --shell /bin/false --disabled-password --ingroup audio chromium


ENV PULSE_SERVER /run/pulse/native

USER chromium
ENTRYPOINT ["chromium", "--no-sandbox"]
