FROM nginx:stable-alpine

COPY exosuite.conf /etc/nginx/conf.d/default.conf

COPY cert.pem /etc/nginx/conf.d
COPY key.pem /etc/nginx/conf.d

ADD snippets /etc/nginx/snippets

COPY exosuite-website /var/www/exosuite-website

RUN find  /var/www/exosuite-website -type d -exec chown nginx:nginx {} \;
RUN find  /var/www/exosuite-website -type f -exec chown nginx:nginx {} \;