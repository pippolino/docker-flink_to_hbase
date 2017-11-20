#!/bin/bash

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

here=$(pwd)

# delete files that are not needed to run hbase
rm -rf docs *.txt LEGAL
rm -f */*.cmd

# Set Java home for hbase servers
sed -i "s,^. export JAVA_HOME.*,export JAVA_HOME=$JAVA_HOME," conf/hbase-env.sh

# Set interactive shell defaults
cat > /etc/profile.d/defaults.sh <<EOF
JAVA_HOME=$JAVA_HOME
export JAVA_HOME
EOF

cd /usr/bin
ln -sf $here/bin/* .
