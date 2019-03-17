#!/usr/bin/env sh

chown -R exosuite:www-data ${APP_DIR}/storage
chown -R exosuite:www-data ${APP_DIR}/bootstrap/cache
chmod -R 775 ${APP_DIR}/storage
chmod -R 775 ${APP_DIR}/bootstrap/cache

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
