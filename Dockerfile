FROM tomcat:7.0.72-jre7
MAINTAINER CPF

RUN ["rm", "-fr", "/usr/local/tomcat/webapps/ROOT"]
RUN wget -O /usr/local/tomcat/webapps/ROOT.war --auth-no-challenge --http-user=user_ansible --no-check-certificate --http-password=b5c5990592a49e0df211b0e704d3bdd0 https://52.69.16.156:8080/view/Open-lmis%20web/job/moz-build/lastSuccessfulBuild/artifact/open-lmis/modules/openlmis-web/build/libs/openlmis-web.war

RUN apt-get update
RUN apt-get -y install python-pip \
    python-virtualenv \
    python-dev \
    libpq-dev \
    postgresql-client

RUN apt-get install build-essential chrpath libssl-dev libxft-dev -y \
    && apt-get install libfreetype6 libfreetype6-dev -y \
    && apt-get install libfontconfig1 libfontconfig1-dev -y

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

ADD setenv.sh /usr/local/tomcat/bin

VOLUME ["/usr/local/tomcat/webapps/extra/properties"]

CMD ["catalina.sh", "run"]
