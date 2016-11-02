FROM tomcat:7.0.72-jre7
MAINTAINER CPF

RUN ["rm", "-fr", "/usr/local/tomcat/webapps/ROOT"]
RUN wget -O /usr/local/tomcat/webapps/openlmis-web.war --auth-no-challenge --http-user=user_ansible --no-check-certificate --http-password=b5c5990592a49e0df211b0e704d3bdd0 https://52.69.16.156:8080/view/Open-lmis%20web/job/moz-build/lastSuccessfulBuild/artifact/open-lmis/modules/openlmis-web/build/libs/openlmis-web.war

export CLASSPATH=$CLASSPATH:/usr/local/tomcat/webapps/openlmis-web/properties

CMD ["catalina.sh", "run"]
