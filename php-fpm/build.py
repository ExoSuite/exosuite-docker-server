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

    if isTesting:
        dockerFileContent = open('./template.testing.Dockerfile').read()
    else:
        dockerFileContent = open('./template.Dockerfile').read()

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
