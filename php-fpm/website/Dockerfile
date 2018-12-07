FROM php:7.2-fpm

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y libpq-dev curl zip unzip git \
    && docker-php-ext-install -j$(nproc) pdo_pgsql pcntl posix bcmath opcache

COPY exosuite-website /var/www/exosuite-website

RUN find  /var/www/exosuite-website -type d -exec chown www-data:www-data {} \;
RUN find  /var/www/exosuite-website -type f -exec chown www-data:www-data {} \;

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"