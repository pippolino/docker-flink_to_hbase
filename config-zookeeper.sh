# This file intended to be sourced

# . /build/config.sh

# This is the definitive site and incredibly slow
ZK_DIST="http://archive.apache.org/dist/zookeeper"

# Prevent initramfs updates from trying to run grub and lilo.
export INITRD=no
export DEBIAN_FRONTEND=noninteractive
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

minimal_apt_get_args='-y --no-install-recommends'


## Build time dependencies ##

ZK_BUILD_PACKAGES="curl"
