#!/usr/bin/env bash

cp -R ../exosuite-website php-fpm
cp -R ../exosuite-website nginx
cp -R ../exosuite-website laravel-artisan

python3.5 nginx/build.py --api
python3.5 php-fpm/build.py --api