#!/bin/sh

usage() {
  echo "$(basename $0) VERSION: Updates the version in all files."
}

update_version() {
  sed -i -e "s#NEXUS_VERSION=.*#NEXUS_VERSION=\"${NEXUS_VERSION}\"#g" build.sh
  sed -i -e "s#NEXUS_VERSION := .*#NEXUS_VERSION := \"${NEXUS_VERSION}\"#g" nexus/Makefile
  sed -i -e "s#nexus .*#nexus (${NEXUS_VERSION}) unstable; urgency=low#g" nexus/debian/changelog
}

set -e

if [ -z $1 ]; then
  usage
  exit 1;
fi


readonly NEXUS_VERSION=$1
update_version
