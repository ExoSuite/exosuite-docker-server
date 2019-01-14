#!/usr/bin/env sh

for command in "$@"
do
    php ${APP_DIR}/artisan ${command}
done

chown -R www-data:www-data ${APP_DIR}

find  ${APP_DIR} -type f -exec chmod 644 {} \;
find  ${APP_DIR} -type d -exec chmod 755 {} \;

rm bootstrap/cache/*.php
php ${APP_DIR}/artisan optimize:clear
php ${APP_DIR}/artisan package:discover
php ${APP_DIR}/artisan config:cache
php ${APP_DIR}/artisan route:cache
php ${APP_DIR}/artisan view:cache

chmod -R ug+rwx ${APP_DIR}/storage ${APP_DIR}/bootstrap/cache