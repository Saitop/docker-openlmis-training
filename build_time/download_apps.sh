#!/usr/bin/env bash
#use openlmis web app as root war
rm -fr /usr/local/tomcat/webapps/ROOT
wget -O /usr/local/tomcat/webapps/ROOT.war --auth-no-challenge --http-user=user_ansible --no-check-certificate --http-password=b5c5990592a49e0df211b0e704d3bdd0 https://52.69.16.156:8080/view/Open-lmis%20web/job/moz-build/lastSuccessfulBuild/artifact/open-lmis/modules/openlmis-web/build/libs/openlmis-web.war

#put cubes package in /app/cubes
mkdir -p /app/cubes && wget -O /app/cubes/cubes.zip --auth-no-challenge --http-user=user_ansible --no-check-certificate --http-password=b5c5990592a49e0df211b0e704d3bdd0 https://52.69.16.156:8080/job/Lmis-cubes/lastSuccessfulBuild/artifact/cubes.zip
cd /app/cubes && unzip ./cubes.zip && rm cubes.zip
#install cubes app dependencies
pip install -r /app/cubes/bin/requirements.txt
