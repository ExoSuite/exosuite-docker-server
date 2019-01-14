FROM php:7.3.1-fpm-alpine

ENV APP_DIR /var/www/:dir

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
COPY ./init.sh /usr/local/bin/init

WORKDIR /var/www/:dir

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

COPY www.conf /usr/local/etc/php-fpm.d

RUN apk --no-cache add shadow

RUN usermod -a -G www-data exosuite

USER exosuite

RUN chmod +x /usr/local/bin/init