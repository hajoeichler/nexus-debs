#! /usr/bin/make

PROPERTY_FILE := "$(DESTDIR)/opt/nexus/conf/nexus.properties"
ARCH := $(shell dpkg --print-architecture)

ifeq ($(ARCH),i386)
BIT=32
endif
ifeq ($(ARCH),amd64)
BIT=64
endif

compile:
	echo "Nothing to compile here."

install:
	echo "Install to $(DESTDIR)"

	# install
	mkdir -p "$(DESTDIR)/opt/nexus"
	cp -r nexus-2.0.1/* "$(DESTDIR)/opt/nexus"
	# delele files
	rm -rf "$(DESTDIR)/opt/nexus/bin/nexus.bat"
	rm -rf "$(DESTDIR)/opt/nexus/bin/jsw"
	mkdir -p "$(DESTDIR)/opt/nexus/bin/jsw/lib"
	cp -r nexus-2.0.1/bin/jsw/linux-x86-$(BIT) "$(DESTDIR)/opt/nexus/bin/jsw/"
	cp -r nexus-2.0.1/bin/jsw/lib/libwrapper-linux-x86-$(BIT).so "$(DESTDIR)/opt/nexus/bin/jsw/lib/"
	# service script
	mkdir -p "$(DESTDIR)/etc/init.d"
	cp nexus-2.0.1/bin/nexus "$(DESTDIR)/etc/init.d/nexus"
	# log directory
	mkdir -p "$(DESTDIR)/var/log/nexus"
        # patch init script - PID
	sed -i -e 's;#PIDDIR=.*;PIDDIR="/var/run/nexus";g' "$(DESTDIR)/etc/init.d/nexus"
	sed -i -e 's;#RUN_AS_USER=.*;RUN_AS_USER="nexus";g' "$(DESTDIR)/etc/init.d/nexus"
	sed -i -e 's;NEXUS_HOME=.*;NEXUS_HOME="/var/lib/nexus";g' "$(DESTDIR)/etc/init.d/nexus"
	# patch nexus.properties file - directories and port
	sed -i -e 's#application-port=.*#application-port=80#g' $(PROPERTY_FILE)
	sed -i -e 's#nexus-work=.*#nexus-work=/var/lib/nexus#g' $(PROPERTY_FILE)
	sed -i -e 's#nexus-webapp=.*#nexus-webapp=/opt/nexus#g' $(PROPERTY_FILE)
	sed -i -e 's#runtime=.*#runtime=/opt/nexus/WEB-INF#g' $(PROPERTY_FILE)
	# create nexus working directory
	mkdir -p "$(DESTDIR)/var/lib/nexus"
