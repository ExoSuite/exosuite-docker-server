#!/usr/bin/env sh

chown -R nginx:nginx ${APP_DIR}

chmod -R ug+rwx ${APP_DIR}/storage ${APP_DIR}/bootstrap/cache
