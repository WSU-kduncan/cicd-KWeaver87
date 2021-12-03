FROM nginx:alpine

EXPOSE 80
EXPOSE 443

COPY ./website /var/www
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

ENV LE_WORKING_DIR=/opt/acme.sh

VOLUME /etc/nginx/ssl

RUN \
    apk update && \
    apk add openssl socat && \
    \
    # Save pre-existing dhparam file
    curl https://ssl-config.mozilla.org/ffdhe2048.txt > /etc/ssl/dhparam.pem && \
    \
    # Install acme.sh, create soft link present in PATH, and enable auto-upgrade
    curl -sSL https://get.acme.sh | sh && \
    ln -s /opt/acme.sh/acme.sh /usr/bin/acme.sh && \
    /opt/acme.sh/acme.sh --upgrade --auto-upgrade
