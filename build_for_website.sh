#!/usr/bin/env bash

cp -R ../exosuite-website php-fpm
cp -R ../exosuite-website nginx

python3 nginx/build.py --website
python3 php-fpm/build.py --website