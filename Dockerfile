FROM tomcat:7.0.72-jre7
MAINTAINER CPF

ADD build_time /build_time
ADD run_time /run_time
RUN chmod -R +x /build_time
RUN chmod -R +x /run_time
#setenv.sh will be ran when tomcat starts, it'll make sure tomcat picks up the properties
RUN mv /run_time/setenv.sh /usr/local/tomcat/bin/setenv.sh

RUN /build_time/install_packages.sh
RUN /build_time/download_apps.sh

CMD ["/run_time/start.sh"]
