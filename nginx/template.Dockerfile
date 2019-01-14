FROM pagespeed/nginx-pagespeed

COPY :conf /etc/nginx/conf.d/default.conf
COPY pagespeed.conf /etc/nginx
COPY nginx.conf /etc/nginx

COPY cert.pem /etc/nginx/conf.d
COPY key.pem /etc/nginx/conf.d

ADD snippets /etc/nginx/snippets

COPY :dir /var/www/:dir

RUN find  /var/www/:dir -type d -exec chown nginx:nginx {} \;
RUN find  /var/www/:dir -type f -exec chown nginx:nginx {} \;

