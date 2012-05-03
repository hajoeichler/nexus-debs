#!/bin/sh

NEXUS_VERSION=2.0.4

set -e

sed -i -e "s#NEXUS_VERSION=.*#NEXUS_VERSION=\"${NEXUS_VERSION}\"#g" download-nexus.sh
sed -i -e "s#NEXUS_VERSION := .*#NEXUS_VERSION := \"${NEXUS_VERSION}\"#g" nexus/Makefile
sed -i -e "s#nexus .*#nexus (${NEXUS_VERSION}) unstable; urgency=low#g" nexus/debian/changelog
