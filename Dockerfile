FROM tomcat:7.0.72-jre7
MAINTAINER CPF

#use openlmis web app as root war
RUN ["rm", "-fr", "/usr/local/tomcat/webapps/ROOT"]
RUN wget -O /usr/local/tomcat/webapps/ROOT.war --auth-no-challenge --http-user=user_ansible --no-check-certificate --http-password=b5c5990592a49e0df211b0e704d3bdd0 https://52.69.16.156:8080/view/Open-lmis%20web/job/moz-build/lastSuccessfulBuild/artifact/open-lmis/modules/openlmis-web/build/libs/openlmis-web.war

#put cubes package in /app/cubes
RUN mkdir /app && wget -O /app/cubes.zip --auth-no-challenge --http-user=user_ansible --no-check-certificate --http-password=b5c5990592a49e0df211b0e704d3bdd0 https://52.69.16.156:8080/job/Lmis-cubes/lastSuccessfulBuild/artifact/cubes.zip
RUN unzip /app/cubes.zip

#install prerequisite for cubes
RUN apt-get update
RUN apt-get -y install python-pip \
    python-virtualenv \
    python-dev \
    libpq-dev \
    postgresql-client

#install prerequisite for phantomjs
RUN apt-get install build-essential chrpath libssl-dev libxft-dev -y \
    && apt-get install libfreetype6 libfreetype6-dev -y \
    && apt-get install libfontconfig1 libfontconfig1-dev -y

#install phantomjs
RUN set -xeu \
    \
    && PHANTOM_VERSION="phantomjs-2.1.1" \
    && ARCH=$(uname -m) \
    && PHANTOM_JS="$PHANTOM_VERSION-linux-$ARCH" \
    && wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 \
    && tar xvjf $PHANTOM_JS.tar.bz2 \
    && mv $PHANTOM_JS /usr/local/share \
    && ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin \
    && rm -f $PHANTOM_JS.tar.bz2

#the following script will be ran when tomcat starts, it'll make sure tomcat picks up the properties
ADD setenv.sh /usr/local/tomcat/bin

VOLUME ["/usr/local/tomcat/webapps/extra/properties"]

CMD ["catalina.sh", "run"]
