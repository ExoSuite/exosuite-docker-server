FROM pagespeed/nginx-pagespeed:stable-alpine3.8-ngx1.15

ENV APP_DIR /var/www/:dir

WORKDIR /var/www/:dir

COPY :conf /etc/nginx/conf.d/default.conf
COPY pagespeed.conf /etc/nginx
COPY nginx.conf /etc/nginx

COPY cert.pem /etc/nginx/conf.d
COPY key.pem /etc/nginx/conf.d

ADD snippets /etc/nginx/snippets

COPY :dir /var/www/:dir

RUN chown -R nginx:nginx /var/www/:dir


