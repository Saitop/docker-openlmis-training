#!/usr/bin/env bash

#replace placeholders in properties files and ini file
#using the env vars provided with "docker run"
ruby /run_time/replace_configs.rb

#start cubes
sh /app/cubes/bin/start.sh

#start openlmis server
/run_time/start_openlmis.sh