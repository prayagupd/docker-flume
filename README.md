## docker-flume

  Docker image containing [Apache Flume](https://flume.apache.org/)

## Build Instructions

    //run elasticsearch first

    git clone https://github.com/prayagupd/docker-elasticsearch/tree/elasticsearch-with-java
    docker build -t elasticsearch .
    docker run -it/(or -d) --net=host elasticsearch

    docker build -t flume .

## Available environment variables

 * `FLUME_AGENT_NAME` - name of flume agent to run. **Required**
 * `FLUME_CONF_FILE` - location of flume configuration file. **Required**
 * `FLUME_CONF_DIR` - directory for flume environment/configuration files. Defaults to `/opt/flume/conf`

And to run

```
docker run -it --net=host flume

Starting flume agent : supply_chain
Info: Including Hive libraries found via () for Hive access
+ exec /opt/java/bin/java -Xmx20m -Dflume.root.logger=INFO,console -cp '/opt/flume/conf:/opt/flume/lib/*:/lib/*' -Djava.library.path= org.apache.flume.node.Application -f /opt/flume/conf/flume.conf -n suppy_chain
2016-09-24 18:54:31,900 (lifecycleSupervisor-1-0) [INFO - org.apache.flume.node.PollingPropertiesFileConfigurationProvider.start(PollingPropertiesFileConfigurationProvider.java:61)] Configuration provider starting
2016-09-24 18:54:31,924 (conf-file-poller-0) [INFO - org.apache.flume.node.PollingPropertiesFileConfigurationProvider$FileWatcherRunnable.run(PollingPropertiesFileConfigurationProvider.java:133)] Reloading configuration file:/opt/flume/conf/flume.conf
2016-09-24 18:54:32,014 (conf-file-poller-0) [INFO - org.apache.flume.conf.FlumeConfiguration$AgentConfiguration.addProperty(FlumeConfiguration.java:1017)] Processing:log-sink1
2016-09-24 18:54:32,033 (conf-file-poller-0) [INFO - org.apache.flume.conf.FlumeConfiguration$AgentConfiguration.addProperty(FlumeConfiguration.java:931)] Added sinks: log-sink1 Agent: supply_agent
2016-09-24 18:54:32,039 (conf-file-poller-0) [INFO - org.apache.flume.conf.FlumeConfiguration$AgentConfiguration.addProperty(FlumeConfiguration.java:1017)] Processing:log-sink1
2016-09-24 18:54:32,149 (conf-file-poller-0) [INFO - org.apache.flume.conf.FlumeConfiguration.validateConfiguration(FlumeConfiguration.java:141)] Post-validation flume configuration contains configuration for agents: [supply_agent]
2016-09-24 18:54:32,150 (conf-file-poller-0) [WARN - org.apache.flume.node.AbstractConfigurationProvider.getConfiguration(AbstractConfigurationProvider.java:133)] No configuration found for this host:suppy_chain
2016-09-24 18:54:32,230 (conf-file-poller-0) [INFO - org.apache.flume.node.Application.startAllComponents(Application.java:138)] Starting new configuration:{ sourceRunners:{} sinkRunners:{} channels:{} }

```

```
docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
de79b66449d7        flume               "start-flume"       7 minutes ago       Up 7 minutes                            ecstatic_torvalds

docker exec -it de79b66449d7 bash
root@de79b66449d7:/# ps aux | grep flume
root         1  0.0  0.0  20052  2900 ?        Ss   18:54   0:00 /bin/bash /opt/flume/bin/start-flume
root         5  0.4  0.5 1925700 49036 ?       Sl   18:54   0:03 /opt/java/bin/java -Xmx20m -Dflume.root.logger=INFO,console -cp /opt/flume/conf:/opt/flume/lib/*:/lib/* -Djava.library.path= org.apache.flume.node.Application -f /opt/flume/conf/flume.conf -n suppy_chain
root        40  0.0  0.0  11128   984 ?        S+   19:06   0:00 grep flume

```

:)
----

Also check the elasticsearch clusters

```
curl 'localhost:9200/_cat/indices?v'
health status index                   pri rep docs.count docs.deleted store.size pri.store.size 
yellow open   applications-2016-09-29   5   1          2            0      5.8kb          5.8kb 


$ curl -XGET localhost:9200/applications-2016-09-29/_search?pretty=true
{
  "took" : 31,
  "timed_out" : false,
  "_shards" : {
    "total" : 5,
    "successful" : 5,
    "failed" : 0
  },
  "hits" : {
    "total" : 2,
    "max_score" : 1.0,
    "hits" : [ {
      "_index" : "applications-2016-09-29",
      "_type" : "SupplyChain",
      "_id" : "AVdzRFEdnGiTbH1yJdWo",
      "_score" : 1.0,
      "_source":{"body":"org.elasticsearch.common.xcontent.XContentBuilder@6497ccdb"}
    }, {
      "_index" : "applications-2016-09-29",
      "_type" : "SupplyChain",
      "_id" : "AVdzRFEcnGiTbH1yJdWn",
      "_score" : 1.0,
      "_source":{"body":"org.elasticsearch.common.xcontent.XContentBuilder@420b3b14"}
    } ]
  }
}

```


ISSUE
----------

docker mode is not finding the fking log4j file so, I'm running manually in two different ssh sessions once I run the container.
Like http://prayagupd-dreamspace.blogspot.com/2016/09/flume-source-and-sink-example.html

