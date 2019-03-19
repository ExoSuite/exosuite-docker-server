#!/usr/bin/env python3

import optparse
import os
from enum import Enum

path = os.path.dirname(os.path.realpath(__file__))


class Command(Enum):
    DAEMON = "schedule:daemon"
    HORIZON = "horizon"


class Token(Enum):
    COMMAND = ':command'

    @staticmethod
    def daemon():
        data = dict()
        data[Token.COMMAND] = Command.DAEMON.value
        return data

    @staticmethod
    def horizon():
        data = dict()
        data[Token.COMMAND] = Command.HORIZON.value
        return data


def generateDockerfile(datas, isTesting: bool):
    dockerFileContent = open('./template.Dockerfile').read()

    if isTesting:
        dockerFileContent = dockerFileContent \
            .replace("COPY --chown=exosuite:www-data exosuite-users-api /var/www/exosuite-users-api", "") \
            .replace("WORKDIR /var/www/exosuite-users-api", "") \
            .replace('CMD ["sh", "-c", "php artisan :command"]', "")

    dockerFileContent = dockerFileContent.replace(Token.COMMAND.value, datas[Token.COMMAND])

    f = open("Dockerfile", "w")
    f.write(dockerFileContent)
    f.close()


parser = optparse.OptionParser()
parser.add_option("--daemon", action="store_true", dest="daemon")
parser.add_option("--horizon", action='store_true', dest="horizon")
parser.add_option("--testing", action='store_true', dest="testing")
parser.add_option("--clean", action='store_true', dest="clean")
(opts, args) = parser.parse_args()

os.chdir(path)

if opts.horizon:
    generateDockerfile(Token.horizon(), opts.testing)
    print("Dockerfile generated for", Command.HORIZON.value, "!")

elif opts.daemon:
    generateDockerfile(Token.daemon(), opts.testing)
    print("Dockerfile generated for", Command.DAEMON.value, "!")

elif opts.clean:
    os.system("rm -f *.pem && rm -f Dockerfile")
    print("Directory cleaned!")
else:
    parser.print_help()
