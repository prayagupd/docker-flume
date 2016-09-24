## docker-flume

  Docker image containing [Apache Flume](https://flume.apache.org/)

## Build Instructions

    docker build -t flume .

## Available environment variables

 * `FLUME_AGENT_NAME` - name of flume agent to run. **Required**
 * `FLUME_CONF_FILE` - location of flume configuration file. **Required**
 * `FLUME_CONF_DIR` - directory for flume environment/configuration files. Defaults to `/opt/flume/conf`

And to run

```
docker run flume

Starting flume agent : suppy_chain
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


