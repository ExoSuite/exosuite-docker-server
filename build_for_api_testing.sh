#!/usr/bin/env bash

python3.5 php-fpm/build.py --api --testing

python3.5 laravel-artisan/build.py --horizon --testing