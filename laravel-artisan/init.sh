#!/usr/bin/env sh

rm bootstrap/cache/*.php
php artisan optimize:clear
php artisan package:discover
php artisan config:cache
php artisan route:cache
php artisan view:cache

chown -R exosuite:exosuite ${APP_DIR}

find  ${APP_DIR} -type f -exec chmod 644 {} \;
find  ${APP_DIR} -type d -exec chmod 755 {} \;

chmod -R ug+rwx ${APP_DIR}/storage ${APP_DIR}/bootstrap/cache