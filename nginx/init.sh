#!/usr/bin/env sh

chown -R exosuite:nginx ${APP_DIR}

find  ${APP_DIR} -type f -exec chmod 644 {} \;
find  ${APP_DIR} -type d -exec chmod 755 {} \;

chgrp -R nginx ${APP_DIR}/storage ${APP_DIR}/bootstrap/cache
chmod -R ug+rwx ${APP_DIR}/storage ${APP_DIR}/bootstrap/cache
