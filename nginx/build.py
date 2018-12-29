#!/usr/bin/env python3

import optparse
import os
from enum import Enum

path = os.path.dirname(os.path.realpath(__file__))


class Directory(Enum):
    API = 'exosuite-users-api'
    WEBSITE = 'exosuite-website'


class Token(Enum):
    CONF = ':conf'
    DIR = ':dir'

    @staticmethod
    def api():
        data = dict()
        data[Token.DIR] = Directory.API
        data[Token.CONF] = Domain.API.value.replace('local', 'conf')
        return data

    @staticmethod
    def website():
        data = dict()
        data[Token.DIR] = Directory.WEBSITE
        data[Token.CONF] = Domain.WEBSITE.value.replace('local', 'conf')
        return data


class Domain(Enum):
    API = 'api.exosuite.local'
    WEBSITE = 'exosuite.local'


def generateCertificates(domain: Domain):
    os.system("openssl req -subj '/CN="
              + domain.value + "' -x509 -newkey rsa:4096 -nodes -keyout key.pem -out cert.pem -days 365")


def generateDockerfile(datas):
    dockerFileContent = open('./template.Dockerfile').read()

    dockerFileContent = dockerFileContent.replace(Token.CONF.value, datas[Token.CONF]) \
        .replace(Token.DIR.value, datas[Token.DIR].value)

    f = open("Dockerfile", "w")
    f.write(dockerFileContent)
    f.close()


parser = optparse.OptionParser()
parser.add_option("--api", action="store_true", dest="api")
parser.add_option("--website", action='store_true', dest="website")
parser.add_option("--clean", action='store_true', dest="clean")
(opts, args) = parser.parse_args()

os.chdir(path)

if opts.api:
    generateCertificates(Domain.API)
    generateDockerfile(Token.api())
    print("Dockerfile generated for nginx API!")

elif opts.website:
    generateCertificates(Domain.WEBSITE)
    generateDockerfile(Token.website())
    print("Dockerfile generated for nginx Website!")

elif opts.clean:
    os.system("rm -f *.pem && rm -f Dockerfile")
    print("Directory cleaned!")
else:
    parser.print_help()
