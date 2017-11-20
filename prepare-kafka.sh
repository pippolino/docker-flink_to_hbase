#!/bin/bash

. /build/config-kafka.sh

apt-get install $minimal_apt_get_args $KAFKA_BUILD_PACKAGES

cd /opt

echo "download kafka version $KAFKA_VERSION"
curl -SL $KAFKA_DIST/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz | tar -x -z && mv kafka_$SCALA_VERSION-$KAFKA_VERSION kafka
