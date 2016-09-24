FROM debian:jessie
MAINTAINER Alex Wilson a.wilson@alumni.warwick.ac.uk

RUN apt-get update && apt-get install -q -y --no-install-recommends wget

RUN mkdir /opt/java
RUN wget --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" -qO- \
  http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jre-8u77-linux-x64.tar.gz \
  | tar zxvf - -C /opt/java --strip 1

RUN mkdir /opt/flume
RUN wget -qO- http://archive.apache.org/dist/flume/1.6.0/apache-flume-1.6.0-bin.tar.gz \
  | tar zxvf - -C /opt/flume --strip 1

ADD start-flume.sh /opt/flume/bin/start-flume
ADD flume.conf /opt/flume/conf/flume.conf

ADD supply_source.log /var/log/supply_source.log
ADD publish-events.sh /opt/flume/bin/publish-events

ENV JAVA_HOME /opt/java
ENV FLUME_AGENT_NAME=suppy_chain
ENV FLUME_CONF_FILE=/opt/flume/conf/flume.conf

ENV PATH /opt/flume/bin:/opt/java/bin:$PATH

CMD [ "start-flume" ]
CMD [ "publish-events" ]
