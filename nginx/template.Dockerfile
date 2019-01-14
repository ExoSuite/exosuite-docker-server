FROM pagespeed/nginx-pagespeed:stable-alpine3.8-ngx1.15

RUN addgroup -S exosuite && adduser -S exosuite -G exosuite

USER exosuite
WORKDIR /var/www/:dir

RUN usermod -a -G nginx exosuite

COPY :conf /etc/nginx/conf.d/default.conf
COPY pagespeed.conf /etc/nginx
COPY nginx.conf /etc/nginx

COPY cert.pem /etc/nginx/conf.d
COPY key.pem /etc/nginx/conf.d

ADD snippets /etc/nginx/snippets

COPY :dir /var/www/:dir

RUN chown -R exosuite:nginx /var/www/:dir

RUN find  /var/www/:dir -type f -exec chmod 644 {} \;
RUN find  /var/www/:dir -type d -exec chmod 755 {} \;

RUN chgrp -R nginx /var/www/:dir/storage /var/www/:dir/bootstrap/cache
RUN chmod -R ug+rwx /var/www/:dir/storage /var/www/:dir/bootstrap/cache

