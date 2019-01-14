#!/usr/bin/env sh

for command in "$@"
do
    php ${APP_DIR}/artisan ${command}
done

rm bootstrap/cache/*.php
php ${APP_DIR}/artisan optimize:clear
php ${APP_DIR}/artisan package:discover
php ${APP_DIR}/artisan config:cache
php ${APP_DIR}/artisan route:cache
php ${APP_DIR}/artisan view:cache

chown -R www-data:www-data ${APP_DIR}

chmod -R ug+rwx ${APP_DIR}/storage ${APP_DIR}/bootstrap/cache