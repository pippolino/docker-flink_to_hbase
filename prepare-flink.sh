#!/bin/bash

. /build/config-flink.sh

apt-get install $minimal_apt_get_args $FLINK_BUILD_PACKAGES

cd /opt

echo "download flink version $FLINK_VERSION"
curl -SL $FLINK_DIST/flink-$FLINK_VERSION/flink-$FLINK_VERSION-bin-hadoop$HADOOP_VERSION-scala_$SCALA_VERSION.tgz | tar -x -z && mv flink-$FLINK_VERSION flink
