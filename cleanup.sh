#!/bin/bash

# . /build/cleanup.sh

apt-get autoremove
apt-get clean

rm -rf /tmp/* /var/tmp/*

rm -rf /var/lib/apt/lists/*
