#! /usr/bin/make

PROPERTY_FILE := "$(DESTDIR)/opt/nexus/conf/nexus.properties"
INITD_FILE := "$(DESTDIR)/etc/init.d/nexus"
ARCH := $(shell dpkg --print-architecture)
NEXUS_VERSION := "2.0.6"

ifeq ($(ARCH),i386)
BIT=32
endif
ifeq ($(ARCH),amd64)
BIT=64
endif

clean:
	rm -rf ../nexus_*_amd64.build
	rm -rf ../nexus_*_amd64.changes
	rm -rf ../nexus_*_amd64.deb

compile:
	echo "Nothing to compile here."

install:
	echo "Install to $(DESTDIR)"

	# install
	mkdir -p "$(DESTDIR)/opt/nexus"
	cp -r nexus-$(NEXUS_VERSION)/* "$(DESTDIR)/opt/nexus"
	# delele bin files and copy only the linux architecture ones
	rm -rf "$(DESTDIR)/opt/nexus/bin"
	mkdir -p "$(DESTDIR)/opt/nexus/bin/jsw/conf"
	cp nexus-$(NEXUS_VERSION)/bin/jsw/conf/wrapper.conf "$(DESTDIR)/opt/nexus/bin/jsw/conf/wrapper.conf"
	cp -r nexus-$(NEXUS_VERSION)/bin/jsw/linux-x86-$(BIT) "$(DESTDIR)/opt/nexus/bin/jsw/"
	mkdir -p "$(DESTDIR)/opt/nexus/bin/jsw/lib"
	cp -r nexus-$(NEXUS_VERSION)/bin/jsw/lib/libwrapper-linux-x86-$(BIT).so "$(DESTDIR)/opt/nexus/bin/jsw/lib/"
	cp -r nexus-$(NEXUS_VERSION)/bin/jsw/lib/wrapper-3.2.3.jar "$(DESTDIR)/opt/nexus/bin/jsw/lib/"
	# service script
	mkdir -p "$(DESTDIR)/etc/init.d"
	cp nexus-$(NEXUS_VERSION)/bin/nexus "$(DESTDIR)/etc/init.d/nexus"
	# patch init script - PID, USER and HOME
	sed -i -e 's;#PIDDIR=.*;PIDDIR="/var/run/nexus";g' $(INITD_FILE)
	sed -i -e 's;#RUN_AS_USER=.*;RUN_AS_USER="nexus";g' $(INITD_FILE)
	sed -i -e 's;NEXUS_HOME=.*;NEXUS_HOME="/opt/nexus";g' $(INITD_FILE)
	# patch nexus.properties file - directories
	sed -i -e 's#nexus-work=.*#nexus-work=/var/lib/nexus/work#g' $(PROPERTY_FILE)
	sed -i -e 's#nexus-webapp=.*#nexus-webapp=/opt/nexus/nexus#g' $(PROPERTY_FILE)
	sed -i -e 's#runtime=.*#runtime=/opt/nexus/nexus/WEB-INF#g' $(PROPERTY_FILE)
	# log directory
	mkdir -p "$(DESTDIR)/var/log/nexus"
	# create PID dir
	mkdir -p "$(DESTDIR)/var/run/nexus"
	# create nexus working directory
	mkdir -p "$(DESTDIR)/var/lib/nexus/work"
	# create tmp and logs dir for wrapperunder /var/lib
	rm -rf "$(DESTDIR)/opt/nexus/logs"
	mkdir -p "$(DESTDIR)/var/lib/nexus/logs"
	ln -s "../../var/lib/nexus/logs" "$(DESTDIR)/opt/nexus/logs"
	rm -rf "$(DESTDIR)/opt/nexus/tmp"
	mkdir -p "$(DESTDIR)/var/lib/nexus/tmp"
	ln -s "../../var/lib/nexus/tmp" "$(DESTDIR)/opt/nexus/tmp"
	# create symlink to nexus conf
	mkdir -p "$(DESTDIR)/etc/nexus"
	ln -s "../../opt/nexus/conf" "$(DESTDIR)/etc/nexus/wrapper"
	ln -s "../../var/lib/nexus/work/conf" "$(DESTDIR)/etc/nexus/nexus"
	# change file mode for all jars
	find "$(DESTDIR)" -name "*.jar" -type f -print0 | xargs -0 chmod a-x
	# copy standard config into working dir
	mkdir -p "$(DESTDIR)/var/lib/nexus/work/conf"
	cp -r conf/* "$(DESTDIR)/var/lib/nexus/work/conf"
