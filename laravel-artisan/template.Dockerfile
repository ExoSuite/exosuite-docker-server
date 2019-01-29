FROM php:7.3.1-cli-alpine

ENV APP_DIR /var/www/exosuite-users-api

RUN set -ex \
  && apk --no-cache add \
    postgresql-dev autoconf g++ make

COPY exosuite-users-api /var/www/exosuite-users-api
COPY ./init.sh /usr/local/bin/init

RUN chmod +x /usr/local/bin/init

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

RUN docker-php-ext-install -j$(nproc) pdo_pgsql pcntl posix bcmath opcache

COPY php.ini "$PHP_INI_DIR/php.ini"

WORKDIR /var/www/exosuite-users-api

CMD ["sh", "-c", "php artisan :command"]
