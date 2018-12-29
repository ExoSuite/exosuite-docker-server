#!/usr/bin/env bash

ls -R ../exosuite-users-api/storage/framework
exit 1

mkdir laravel-artisan/horizon
mkdir laravel-artisan/daemon

cp -R ../exosuite-users-api php-fpm
cp -R ../exosuite-users-api nginx
cp -R ../exosuite-users-api laravel-artisan/horizon
cp -R ../exosuite-users-api laravel-artisan/daemon

python3.5 nginx/build.py --api
python3.5 php-fpm/build.py --api

python3.5 laravel-artisan/build.py --horizon
mv laravel-artisan/Dockerfile laravel-artisan/horizon

python3.5 laravel-artisan/build.py --daemon
mv laravel-artisan/Dockerfile laravel-artisan/daemon