FROM nginx:alpine

EXPOSE 80
EXPOSE 443

COPY ./website /var/www
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

RUN \
    # Use Mozilla's dhparam file
    curl https://ssl-config.mozilla.org/ffdhe2048.txt > /etc/ssl/dhparam.pem
