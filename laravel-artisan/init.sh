#!/usr/bin/env sh

rm bootstrap/cache/*.php
php ${APP_DIR}/artisan optimize:clear
php ${APP_DIR}/artisan package:discover
php ${APP_DIR}/artisan config:cache
php ${APP_DIR}/artisan route:cache
php ${APP_DIR}/artisan view:cache

chown -R exosuite:exosuite ${APP_DIR}

find  ${APP_DIR} -type f -exec chmod 644 {} \;
find  ${APP_DIR} -type d -exec chmod 755 {} \;

chmod -R ug+rwx ${APP_DIR}/storage ${APP_DIR}/bootstrap/cache