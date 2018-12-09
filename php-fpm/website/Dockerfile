FROM php:7.3-fpm-alpine

RUN set -ex \
  && apk --no-cache add \
    postgresql-dev autoconf g++ make


RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

RUN docker-php-ext-install -j$(nproc) pdo_pgsql pcntl posix bcmath opcache

COPY exosuite-website /var/www/exosuite-website

RUN find  /var/www/exosuite-website -type d -exec chown www-data:www-data {} \;
RUN find  /var/www/exosuite-website -type f -exec chown www-data:www-data {} \;

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"