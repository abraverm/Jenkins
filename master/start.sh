#!/bin/bash
. /etc/sysconfig/jenkins

if [ -e "/init" ]; then
	mkdir /root/.ssh
	ssh-keygen -b 1024 -t rsa -N '' -f /root/.ssh/id_rsa
	if [ -d "/shared" ]; then
		function share {
		mv "$1" "$2"
		ln -s "$2" "$1"
		}
		share /var/lib/jenkins /shared/jenkins
		share /etc/sysconfig/jenkins /shared/jenkins.conf
		share /root/.ssh /shared/ssh
	fi
	rm -rf /init
fi
/bin/java $JENKINS_JAVA_OPTIONS -DJENKINS_HOME=$JENKINS_HOME -jar /usr/lib/jenkins/jenkins.war
