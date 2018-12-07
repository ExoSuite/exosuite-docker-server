FROM nginx:stable-alpine

COPY api.exosuite.conf /etc/nginx/conf.d/default.conf

COPY cert.pem /etc/nginx/conf.d
COPY key.pem /etc/nginx/conf.d

ADD snippets /etc/nginx/snippets

COPY exosuite-users-api /var/www/exosuite-users-api

RUN find  /var/www/exosuite-users-api -type d -exec chown nginx:nginx {} \;
RUN find  /var/www/exosuite-users-api -type f -exec chown nginx:nginx {} \;