This project helps you to package sonatype nexus as a debian package.

Tested on Ubuntu 11.10 and 12.04 - i386 and amd64

To build the deb:

    ./build.sh

Features:

1. Run as nexus user (and nexus group)
1. Install to `/opt/nexus`
1. Configuration in `/etc/nexus`
1. Working directory in `/var/lib/nexus`
1. Simple script to update version `update-version.sh`

Known issues:

1. We have to disable lintian in order to get nexus packaged, because it violates a bunch of rules.
