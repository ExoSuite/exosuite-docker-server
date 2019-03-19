#!/usr/bin/env bash

python3 php-fpm/build.py --api --testing

python3 laravel-artisan/build.py --horizon --testing
cp laravel-artisan/horizon/laravel-artisan-entrypoint.sh laravel-artisan/laravel-artisan-entrypoint.sh