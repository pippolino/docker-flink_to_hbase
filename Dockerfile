# Flink to HBase in Docker
#
# Version 1.2

# http://docs.docker.io/en/latest/use/builder/

FROM ubuntu:xenial
MAINTAINER Federico Soldani <pippo@daemon-ware.com>

COPY ./prepare-system.sh /build/prepare-system.sh

RUN chmod +x /build/prepare-system.sh
RUN /build/prepare-system.sh

COPY *.sh /build/

RUN chmod +x /build/*.sh

# Configure version
ENV FLINK_VERSION=1.3.2 \
    HADOOP_VERSION=27 \
    SCALA_VERSION=2.11 \
    HBASE_VERSION=1.3.1 \
    KAFKA_VERSION=1.0.0 \
    KAFKA_API_VERSION=1.0 \
    JMX_PORT=7203 \
    VIEWER_PATH=/data/viewer/factsViewer.jar

RUN /build/prepare-kafka.sh
RUN /build/prepare-flink.sh
RUN /build/prepare-hbase.sh && cd /opt/hbase && /build/build-hbase.sh

RUN cd / && /build/cleanup.sh
RUN rm -rf /build

VOLUME /data

ADD ./flink-conf.yaml /opt/flink/conf/flink-conf.yaml
ADD ./hbase-site.xml /opt/hbase/conf/hbase-site.xml
ADD ./zoo.cfg /opt/hbase/conf/zoo.cfg
ADD ./replace-hostname /opt/replace-hostname
ADD ./config-kafka /opt/kafka/config

ADD ./print-logo /opt/print-logo
ADD ./hbase-server /opt/hbase-server
ADD ./flink-server /opt/flink-server
ADD ./kafka-server /opt/kafka-server
ADD ./viewer-server /opt/viewer-server

RUN chmod +x /opt/print-logo
RUN chmod +x /opt/hbase-server
RUN chmod +x /opt/flink-server
RUN chmod +x /opt/kafka-server
RUN chmod +x /opt/viewer-server

# REST API
EXPOSE 8080
# REST Web UI at :8085/rest.jsp
EXPOSE 8085
# Thrift API
EXPOSE 9090
# KAFKA
EXPOSE 9092
# Thrift Web UI at :9095/thrift.jsp
EXPOSE 9095
# HBase's Embedded zookeeper cluster
EXPOSE 2181
# HBase Master port
EXPOSE 16000
# HBase Master web UI at :16010/master-status;  ZK at :16010/zk.jsp
EXPOSE 16010
# HBase Region Servers
EXPOSE 16020 16030
# Flink
EXPOSE 6123
# JMX
EXPOSE ${JMX_PORT}
# Flink web UI
EXPOSE 8081
# SpringBoot Viewer web UI
EXPOSE 8090

CMD "/opt/print-logo"; "/opt/flink-server"; "/opt/viewer-server"; "/opt/kafka-server"; "/opt/hbase-server";