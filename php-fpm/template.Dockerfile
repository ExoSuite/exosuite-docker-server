FROM php:7.3.1-fpm-alpine

ENV APP_DIR /var/www/:dir

WORKDIR /var/www/:dir

RUN set -ex \
  && apk --no-cache add \
    postgresql-dev autoconf g++ make fcgi libpng-dev freetype-dev libjpeg-turbo-dev libpng libjpeg-turbo freetype

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

RUN docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install -j$(nproc) pdo_pgsql pcntl posix bcmath opcache gd exif

COPY :dir /var/www/:dir
COPY php-fpm-healthcheck /usr/local/bin/php-fpm-healthcheck
COPY ./init.sh /usr/local/bin/init

RUN chmod +x /usr/local/bin/init

WORKDIR /var/www/:dir

COPY php.ini "$PHP_INI_DIR/php.ini"

COPY www.conf /usr/local/etc/php-fpm.d

RUN chown -R www-data:www-data /var/www/:dir