#!/bin/bash

# . /build/cleanup.sh
rm -rf /tmp/* /var/tmp/*

apt-get clean

rm -rf /var/lib/apt/lists/*
