#!/usr/bin/env python3

import optparse
import os


class OptionParser(optparse.OptionParser):
    def check_required(self, opt):
        option = self.get_option(opt)

        # Assumes the option's 'default' is set to None!
        if getattr(self.values, option.dest) is None:
            self.error("%s option not supplied" % option)


path = os.path.dirname(os.path.realpath(__file__))

parser = OptionParser()
parser.add_option("--staging", action="store_true", dest="staging")
parser.add_option("--production", action='store_true', dest="production")
parser.add_option("--version", action='store', dest="version", default=None)
(opts, args) = parser.parse_args()
parser.check_required("--version")

if opts.staging:
    os.system(
        "sudo docker build --build-arg ENV=staging -t teamexosuite.cloud:5000/exosuite/exosuite-laravel-echo-server:"
        + opts.version + " ."
    )
    os.system("sudo docker login teamexosuite.cloud:5000 -u exosuite-dev -p N8jSfUeH4kPyYSLW")
    os.system("sudo docker push teamexosuite.cloud:5000/exosuite/exosuite-laravel-echo-server:" + opts.version)
    os.system("sudo docker logout teamexosuite.cloud:5000")
elif opts.production:
    os.system(
        "sudo docker build --build-arg ENV=production -t exosuite.fr:5000/exosuite/exosuite-laravel-echo-server:"
        + opts.version + " ."
    )
    os.system("sudo docker login exosuite.fr:5000 -u exosuite -p eG4FE5NbknfT79uR")
    os.system("sudo docker push exosuite.fr:5000/exosuite/exosuite-laravel-echo-server:" + opts.version)
    os.system("sudo docker logout exosuite.fr:5000")
else:
    parser.print_help()
