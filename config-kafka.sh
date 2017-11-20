# This file intended to be sourced

# . /build/config.sh

# This is the definitive site and incredibly slow
KAFKA_DIST="http://archive.apache.org/dist/kafka"
# This is a mirror site and faster but every new release breaks all
# existing links.
# HBASE_DIST="https://www-eu.apache.org/dist/kafka"

# Prevent initramfs updates from trying to run grub and lilo.
export INITRD=no
export DEBIAN_FRONTEND=noninteractive
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

minimal_apt_get_args='-y --no-install-recommends'

## Build time dependencies ##

KAFKA_BUILD_PACKAGES="curl"

# Core list from docs
#FLINK_BUILD_PACKAGES="$HBASE_BUILD_PACKAGES "

# Optional:
#FLINK_BUILD_PACKAGES="$HBASE_BUILD_PACKAGES "

## Run time dependencies ##
KAFKA_RUN_PACKAGES="openjdk-8-jre-headless"