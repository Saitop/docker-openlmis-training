#!/usr/bin/env bash

#complete properties files and ini file with run time input env vars
# replace_configs.sh

#start tomcat
catalina.sh run

#start cubes
sh /app/cubes/bin/start.sh
