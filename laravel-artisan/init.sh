#!/usr/bin/env sh

rm bootstrap/cache/*.php
php ${WORKDIR}/artisan optimize:clear
php ${WORKDIR}/artisan package:discover
php ${WORKDIR}/artisan config:cache
php ${WORKDIR}/artisan route:cache
php ${WORKDIR}/artisan view:cache

chmod -R ug+rwx ${WORKDIR}/storage ${WORKDIR}/bootstrap/cache