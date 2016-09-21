FROM casept/alpine-amd64:edge
RUN apk update && apk add openvpn dumb-init && rm -rf /var/cache/*
ENTRYPOINT ["dumb-init", "openvpn", "/etc/openvpn/server.conf"]
