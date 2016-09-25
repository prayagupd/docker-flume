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

RUN mkdir /opt/elasticsearch
RUN wget --no-check-certificate -qO- \ 
  https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.0.0.tar.gz \
  | tar zxvf - -C /opt/elasticsearch --strip 1
ADD elasticsearch.yml /opt/elasticsearch/conf/elasticsearch.yml

RUN wget --no-check-certificate -qO- https://dl.dropboxusercontent.com/s/h491nkeajc67pk7/lucene%204.8.zip
RUN unzip lucene\ 4.8.zip
RUN mv lucene\ 4.8/* /opt/flume/lib

EXPOSE 9200
EXPOSE 9300

RUN mkdir /opt/flume
RUN wget -qO- http://archive.apache.org/dist/flume/1.6.0/apache-flume-1.6.0-bin.tar.gz \
  | tar zxvf - -C /opt/flume --strip 1

ADD start-flume.sh /opt/flume/bin/start-flume
ADD flume.conf /opt/flume/conf/flume.conf

ADD supply_source.log /var/log/supply_source.log
ADD publish-events.sh /opt/flume/bin/publish-events

ENV JAVA_HOME /opt/java
ENV FLUME_CONF_DIR=/opt/flume/conf/
ENV FLUME_AGENT_NAME=suppy_chain
ENV FLUME_CONF_FILE=/opt/flume/conf/flume.conf

ENV ELASTICSEARCH_HOME /opt/elasticsearch

ENV PATH /opt/flume/bin:/opt/elasticsearch/bin:/opt/java/bin:$PATH

CMD [ "start-flume" ]
#CMD [ elasticsearch -Des.insecure.allow.root=true -d]
#CMD [ "publish-events" ]
