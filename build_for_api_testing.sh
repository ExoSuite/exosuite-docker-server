#!/usr/bin/env sh

python3 php-fpm/build.py --api --testing

python3 laravel-artisan/build.py --horizon --testing
