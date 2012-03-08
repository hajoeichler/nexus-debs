#!/bin/sh

set -e

wget http://www.sonatype.org/downloads/nexus-2.0.1-bundle.tar.gz
tar xvfz nexus-2.0.1-bundle.tar.gz

mv nexus-2.0.1 nexus/
