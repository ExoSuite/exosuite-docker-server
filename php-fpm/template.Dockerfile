FROM php:7.3.1-fpm-alpine

RUN addgroup -S exosuite && adduser -S exosuite -G exosuite

WORKDIR /var/www/:dir

RUN set -ex \
  && apk --no-cache add \
    postgresql-dev autoconf g++ make fcgi

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

RUN docker-php-ext-install -j$(nproc) pdo_pgsql pcntl posix bcmath opcache

COPY :dir /var/www/:dir
COPY php-fpm-healthcheck /usr/local/bin/php-fpm-healthcheck

WORKDIR /var/www/:dir

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

COPY www.conf /usr/local/etc/php-fpm.d

RUN apk --no-cache add shadow

RUN usermod -a -G www-data exosuite

RUN chown -R exosuite:www-data /var/www/:dir

RUN find  /var/www/:dir -type f -exec chmod 644 {} \;
RUN find  /var/www/:dir -type d -exec chmod 755 {} \;

RUN chgrp -R www-data /var/www/:dir/storage /var/www/:dir/bootstrap/cache
RUN chmod -R ug+rwx /var/www/:dir/storage /var/www/:dir/bootstrap/cache

USER exosuite