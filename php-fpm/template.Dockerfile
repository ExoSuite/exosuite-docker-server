FROM php:7.3.8-fpm-alpine

ENV APP_DIR /var/www/:dir

RUN addgroup exosuite && adduser exosuite -S -H -G exosuite

RUN set -ex \
  && apk --no-cache add \
    postgresql-dev autoconf g++ make libpng-dev freetype-dev libjpeg-turbo-dev libpng libjpeg-turbo freetype imagemagick-dev

RUN pecl install -o -f redis imagick \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis imagick

RUN docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install -j$(nproc) pdo_pgsql pcntl posix bcmath opcache gd exif

RUN apk add --no-cache --update libmemcached-libs zlib
RUN set -xe && \
    cd /tmp/ && \
    apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS && \
    apk add --no-cache --update --virtual .memcached-deps zlib-dev libmemcached-dev cyrus-sasl-dev && \
# Install igbinary (memcached's deps)
    pecl install igbinary && \
# Install memcached
    ( \
        pecl install --nobuild memcached && \
        cd "$(pecl config-get temp_dir)/memcached" && \
        phpize && \
        ./configure --enable-memcached-igbinary && \
        make -j$(nproc) && \
        make install && \
        cd /tmp/ \
    ) && \
# Enable PHP extensions
    docker-php-ext-enable igbinary memcached && \
    rm -rf /tmp/* && \
    apk del .memcached-deps .phpize-deps

COPY php-fpm-healthcheck /usr/local/bin/php-fpm-healthcheck
COPY ./init.sh /usr/local/bin/init

WORKDIR /var/www/:dir

COPY php.ini "$PHP_INI_DIR/php.ini"

COPY www.conf /usr/local/etc/php-fpm.d

RUN chmod +x /usr/local/bin/init

COPY --chown=exosuite:www-data :dir /var/www/:dir

RUN echo "" > /var/www/:dir/storage/logs/laravel.log


RUN chown -R exosuite:www-data /var/www/:dir/storage && chown -R exosuite:www-data /var/www/:dir/bootstrap/cache

RUN chmod -R 775 /var/www/:dir/storage && chmod -R 775 /var/www/:dir/bootstrap/cache

