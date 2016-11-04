#!/usr/bin/env bash

#complete properties files and ini file with run time input env vars
ruby replace_configs.rb

#setenv.sh will make sure tomcat pickup the extra properties files
mv /run_time/setenv.sh /usr/local/tomcat/bin/setenv.sh
#start tomcat
catalina.sh run

#start cubes
sh /app/cubes/bin/start.sh
