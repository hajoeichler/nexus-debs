#!/bin/sh

download() {
  wget http://www.sonatype.org/downloads/nexus-${NEXUS_VERSION}-bundle.tar.gz
}

unpack_and_move() {
  tar xvfz nexus-${NEXUS_VERSION}-bundle.tar.gz
  mv nexus-${NEXUS_VERSION} nexus/
}

apply_patch() {
  patch nexus/nexus-${NEXUS_VERSION}/bin/nexus init-script-patch
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

readonly NEXUS_VERSION="2.0.6"

download
unpack_and_move
apply_patch
create_deb
