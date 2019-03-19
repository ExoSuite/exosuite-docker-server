#!/usr/bin/env bash

mkdir -p laravel-artisan/horizon
mkdir -p laravel-artisan/scheduler

cp -R ../exosuite-users-api php-fpm
cp -R ../exosuite-users-api nginx
cp -R ../exosuite-users-api laravel-artisan/horizon
cp -R ../exosuite-users-api laravel-artisan/scheduler

./copy_files_for_artisan.sh

python3 nginx/build.py --api
python3 php-fpm/build.py --api

python3 laravel-artisan/build.py --horizon
mv laravel-artisan/Dockerfile laravel-artisan/horizon

python3 laravel-artisan/build.py --daemon
mv laravel-artisan/Dockerfile laravel-artisan/scheduler