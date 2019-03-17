FROM crunchgeek/nginx-pagespeed

ENV NGINX_PAGESPEED=on
ENV NGINX_PAGESPEED_IMG=on
ENV NGINX_PAGESPEED_JS=on
ENV NGINX_PAGESPEED_CSS=on
ENV NGINX_DEFAULT_SERVER=off
ENV APP_DIR /var/www/:dir

WORKDIR /var/www/:dir

COPY :conf /etc/nginx/conf.d/exosuite-service.conf
COPY nginx.conf /etc/nginx

COPY cert.pem /etc/nginx/conf.d
COPY key.pem /etc/nginx/conf.d

ADD snippets /etc/nginx/snippets

COPY :dir /var/www/:dir



