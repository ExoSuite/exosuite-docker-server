#!/usr/bin/env bash

mkdir laravel-artisan/horizon
mkdir laravel-artisan/daemon

cp laravel-artisan/init.sh laravel-artisan/horizon
cp laravel-artisan/init.sh laravel-artisan/daemon

python3.5 php-fpm/build.py --api --testing

python3.5 laravel-artisan/build.py --horizon --testing
mv laravel-artisan/Dockerfile laravel-artisan/horizon

python3.5 laravel-artisan/build.py --daemon --testing
mv laravel-artisan/Dockerfile laravel-artisan/daemon