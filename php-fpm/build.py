#!/usr/bin/env python3

import optparse
import os
from enum import Enum

path = os.path.dirname(os.path.realpath(__file__))


class Directory(Enum):
    API = 'exosuite-users-api'
    WEBSITE = 'exosuite-website'


class Token(Enum):
    DIR = ':dir'

    @staticmethod
    def api():
        data = dict()
        data[Token.DIR] = Directory.API.value
        return data

    @staticmethod
    def website():
        data = dict()
        data[Token.DIR] = Directory.WEBSITE.value
        return data


def generateDockerfile(datas, isTesting: bool):

    dockerFileContent = open('./template.Dockerfile').read()

    if isTesting:
        dockerFileContent = dockerFileContent \
            .replace("COPY --chown=exosuite:exosuite :dir /var/www/:dir", "") \
            .replace("RUN echo "" > /var/www/:dir/storage/logs/laravel.log", "") \
            .replace("RUN chown -R exosuite:www-data /var/www/:dir/storage && chown -R exosuite:www-data /var/www/:dir/bootstrap/cache", "") \
            .replace("RUN chmod -R 775 /var/www/:dir/storage && chmod -R 775 /var/www/:dir/bootstrap/cache", "") \
            .replace("COPY :dir /var/www/:dir", "") \
            .replace('WORKDIR /var/www/:dir', "")

    dockerFileContent = dockerFileContent.replace(Token.DIR.value, datas[Token.DIR])

    f = open("Dockerfile", "w")
    f.write(dockerFileContent)
    f.close()


parser = optparse.OptionParser()
parser.add_option("--website", action="store_true", dest="website")
parser.add_option("--api", action='store_true', dest="api")
parser.add_option("--testing", action='store_true', dest="testing")
parser.add_option("--clean", action='store_true', dest="clean")
(opts, args) = parser.parse_args()

os.chdir(path)

if opts.api:
    generateDockerfile(Token.api(), opts.testing)
    print("Dockerfile generated for php-fpm API!")
elif opts.website:
    generateDockerfile(Token.website(), opts.testing)
    print("Dockerfile generated for php-fpm WEBSITE!")
elif opts.clean:
    os.system("rm -f Dockerfile")
    print("Directory cleaned!")
else:
    parser.print_help()
