#!/usr/bin/env bash

#replace placeholders in properties files and ini file with run time input env vars
ruby /run_time/replace_configs.rb

#start cubes
sh /app/cubes/bin/start.sh

#setenv.sh will make sure tomcat pickup the extra properties files
mv /run_time/setenv.sh /usr/local/tomcat/bin/setenv.sh
#start tomcat
catalina.sh run
