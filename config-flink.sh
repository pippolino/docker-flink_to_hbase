# This file intended to be sourced

# . /build/config.sh

# This is the definitive site and incredibly slow
FLINK_DIST="http://archive.apache.org/dist/flink"

# Prevent initramfs updates from trying to run grub and lilo.
export INITRD=no
export DEBIAN_FRONTEND=noninteractive
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

minimal_apt_get_args='-y --no-install-recommends'


## Build time dependencies ##

FLINK_BUILD_PACKAGES="curl"

# Core list from docs
#FLINK_BUILD_PACKAGES="$HBASE_BUILD_PACKAGES "

# Optional:
#FLINK_BUILD_PACKAGES="$HBASE_BUILD_PACKAGES "

## Run time dependencies ##
FLINK_RUN_PACKAGES="openjdk-8-jre-headless"
