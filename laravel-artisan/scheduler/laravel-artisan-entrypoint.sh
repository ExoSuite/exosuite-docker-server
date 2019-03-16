#!/usr/bin/env sh

while true; do
    $(which php) ${WORKDIR}/artisan schedule:run --verbose --no-interaction
    sleep 60
done