#!/bin/bash

. /build/config-zookeeper.sh

apt-get install $minimal_apt_get_args $ZK_BUILD_PACKAGES

cd /opt

echo "download zookeeper version $ZOOKEEPER_VERSION"
curl -SL $ZK_DIST/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz | tar -x -z && mv zookeeper-$ZOOKEEPER_VERSION zookeeper
