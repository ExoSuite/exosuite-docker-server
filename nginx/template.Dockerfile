FROM crunchgeek/nginx-pagespeed:1.17.3

ENV NGINX_PAGESPEED=on
ENV NGINX_PAGESPEED_IMG=off
ENV NGINX_PAGESPEED_JS=on
ENV NGINX_FASTCGI_GEOIP=on
ENV NGINX_PAGESPEED_CSS=off
ENV NGINX_DEFAULT_SERVER=off
ENV APP_DIR /var/www/:dir

WORKDIR /var/www/:dir

COPY :conf /etc/nginx/conf.d/exosuite-service.conf
COPY nginx.conf /etc/nginx

COPY cert.pem /etc/nginx/conf.d
COPY key.pem /etc/nginx/conf.d

ADD snippets /etc/nginx/snippets

COPY :dir /var/www/:dir

RUN mkdir /etc/nginx/.pagespeed_auth

COPY .htpasswd /etc/nginx/.pagespeed_auth
COPY pagespeed_admin.conf /etc/nginx
COPY pagespeed.conf /etc/nginx/conf.d

RUN echo "pagespeed GoogleFontCssInlineMaxBytes 10240;" >> /etc/nginx/conf.d/pagespeed-css.conf
