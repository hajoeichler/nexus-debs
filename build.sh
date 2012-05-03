#!/bin/sh

download() {
  wget http://www.sonatype.org/downloads/nexus-${NEXUS_VERSION}-bundle.tar.gz
}

unpack_and_move() {
  tar xvfz nexus-${NEXUS_VERSION}-bundle.tar.gz
  mv nexus-${NEXUS_VERSION} nexus/
}

create_deb() {
  cd nexus
  debuild --no-lintian -uc -us -b
}

set -e

if [ "$1" != "-b" ]; then
  echo "Read the source Luke..."
  exit 1
fi

readonly NEXUS_VERSION="2.0.4-1"

download
unpack_and_move
create_deb
