FROM pagespeed/nginx-pagespeed:stable-alpine3.8-ngx1.15

ENV APP_DIR /var/www/:dir

RUN addgroup -S exosuite && adduser -S exosuite -G exosuite

WORKDIR /var/www/:dir

RUN apk --no-cache add shadow

RUN usermod -a -G nginx exosuite

COPY :conf /etc/nginx/conf.d/default.conf
COPY pagespeed.conf /etc/nginx
COPY nginx.conf /etc/nginx

COPY cert.pem /etc/nginx/conf.d
COPY key.pem /etc/nginx/conf.d

ADD snippets /etc/nginx/snippets

COPY :dir /var/www/:dir

COPY ./init.sh /usr/local/bin/init

USER exosuite

