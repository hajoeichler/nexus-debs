This project helps you to package sonatype nexus as a debian package.

Tested on Ubuntu 11.10 - i386 and amd64

To build the deb:

    ./download-nexus.sh
    debuild --no-lintian -uc -us -b

Features:

1. Run as nexus user (and nexus group)
1. Install to `/opt/nexus`
1. Configuration in `/etc/nexus`
1. Working directory in `/var/lib/nexus`

Known issues:

1. We have to disable lintian in order to get nexus packaged, because it violates a bunch of rules.
