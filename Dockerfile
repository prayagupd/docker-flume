FROM ubuntu:latest
MAINTAINER Andrew Odewahn "odewahn@oreilly.com"

RUN apt-get update && apt-get install -q -y --no-install-recommends wget
RUN apt-get install -q -y unzip
RUN apt-get install -q -y curl
RUN apt-get install -q -y vim

RUN mkdir /opt/java
RUN wget --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" -qO- \
  http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jre-8u77-linux-x64.tar.gz \
  | tar zxvf - -C /opt/java --strip 1

ENV JAVA_HOME /opt/java
ENV PATH $JAVA_HOME/bin:$PATH

RUN mkdir /opt/flume
RUN wget -qO- http://archive.apache.org/dist/flume/1.6.0/apache-flume-1.6.0-bin.tar.gz \
  | tar zxvf - -C /opt/flume --strip 1

ENV ES_PKG_NAME elasticsearch-1.7.3

RUN wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv $ES_PKG_NAME/lib/*.* /opt/flume/lib/

ADD start-flume.sh /opt/flume/bin/start-flume
ADD flume.conf /opt/flume/conf/flume.conf
ADD flume-ext-deps/*.jar /opt/flume/lib/

ADD supply_source.log /var/log/supply_source.log
ADD publish-events.sh /opt/flume/bin/publish-events

ENV FLUME_CLASSPATH=/opt/elasticsearch/lib/
ENV FLUME_CONF_DIR=/opt/flume/conf/
ENV FLUME_AGENT_NAME=shipping_agent
ENV FLUME_CONF_FILE=/opt/flume/conf/flume.conf

ENV PATH /opt/flume/bin:$PATH

CMD [ "start-flume" ]
#CMD [ "publish-events" ]
