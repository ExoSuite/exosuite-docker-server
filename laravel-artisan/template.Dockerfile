FROM php:7.3.1-cli-alpine

RUN addgroup -S exosuite && adduser -S exosuite -G exosuite

RUN set -ex \
  && apk --no-cache add \
    postgresql-dev autoconf g++ make

COPY exosuite-users-api /var/www/exosuite-users-api

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

RUN docker-php-ext-install -j$(nproc) pdo_pgsql pcntl posix bcmath opcache

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

WORKDIR /var/www/exosuite-users-api

RUN chown -R exosuite:exosuite /var/www/exosuite-users-api

RUN find  /var/www/exosuite-users-api -type f -exec chmod 644 {} \;
RUN find  /var/www/exosuite-users-api -type d -exec chmod 755 {} \;

USER exosuite

CMD ["sh", "-c", "php artisan :command"]
