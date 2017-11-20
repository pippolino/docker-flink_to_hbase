#!/bin/bash

. /build/config-hbase.sh

apt-get install $minimal_apt_get_args $HBASE_BUILD_PACKAGES

cd /opt

curl -SL $HBASE_DIST/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz | tar -x -z && mv hbase-${HBASE_VERSION} hbase

apt-get remove --purge -y $HBASE_BUILD_PACKAGES $HBASE_AUTO_ADDED_PACKAGES

# Install the run-time dependencies
apt-get install $minimal_apt_get_args $HBASE_RUN_PACKAGES