#!/usr/bin/env bash

#run migration before start tomcat
/run_time/migration.sh

#setenv.sh will make sure tomcat pickup the extra properties files
cp /run_time/setenv.sh /usr/local/tomcat/bin/setenv.sh

#start tomcat
catalina.sh run
