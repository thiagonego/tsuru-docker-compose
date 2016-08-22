#!/bin/bash

mkdir -p /data/gandalf/ssh
chown -R git:git /data/gandalf

service ssh start
/usr/sbin/rsyslogd
/usr/bin/gandalf-server -config=/etc/gandalf.conf
