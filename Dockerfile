FROM nginx:alpine

EXPOSE 80

COPY ./website /usr/share/nginx/html