FROM fedora
RUN curl -o /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
RUN rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
RUN yum install -y -q jenkins java-1.8.0-openjdk openssh-clients
ADD ./jenkins.config /etc/sysconfig/jenkins
ADD ./start.sh /opt/start.sh
RUN touch /init
CMD /bin/bash /opt/start.sh
EXPOSE 8080
MAINTAINER Alexander Braverman "abraverm@redhat.com"
