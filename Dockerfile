# Flink to HBase in Docker
#
# Version 0.1

# http://docs.docker.io/en/latest/use/builder/

FROM ubuntu:xenial
MAINTAINER Federico Soldani <pippo@daemon-ware.com>

COPY *.sh /build/

RUN chmod +x /build/*.sh

# Configure version
ENV FLINK_VERSION=1.3.2 \
    HADOOP_VERSION=27 \
    SCALA_VERSION=2.11 \
    HBASE_VERSION=1.3.1

RUN /build/prepare-flink.sh
    
RUN /build/prepare-hbase.sh && \
    cd /opt/hbase && /build/build-hbase.sh \
    cd / && /build/cleanup-hbase.sh

RUN rm -rf /build

VOLUME /data

ADD ./flink-conf.yaml /opt/flink/conf/flink-conf.yaml

ADD ./hbase-site.xml /opt/hbase/conf/hbase-site.xml

ADD ./zoo.cfg /opt/hbase/conf/zoo.cfg

ADD ./replace-hostname /opt/replace-hostname

ADD ./hbase-server /opt/hbase-server
ADD ./flink-server /opt/flink-server

# REST API
EXPOSE 8080
# REST Web UI at :8085/rest.jsp
EXPOSE 8085
# Thrift API
EXPOSE 9090
# Thrift Web UI at :9095/thrift.jsp
EXPOSE 9095
# HBase's Embedded zookeeper cluster
EXPOSE 2181
# HBase Master web UI at :16010/master-status;  ZK at :16010/zk.jsp
EXPOSE 16010
# Flink
EXPOSE 6123
# Flink web UI
EXPOSE 8081

CMD "/opt/flink-server"; "/opt/hbase-server"