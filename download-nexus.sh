#!/bin/sh

NEXUS_VERSION="2.0.4"

set -e

wget http://www.sonatype.org/downloads/nexus-${NEXUS_VERSION}-bundle.tar.gz
tar xvfz nexus-${NEXUS_VERSION}-bundle.tar.gz

mv nexus-${NEXUS_VERSION} nexus/
