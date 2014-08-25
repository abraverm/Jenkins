Jenkins
=======
The Dockerfile builds image for latest
[Jenkins](http://pkg.jenkins-ci.org/redhat/) based on Fedora.

Exposed ports :
---------------
  - 8080

Options:
--------
1. Access the Jenkins files from host

    Upon container creation,  it is possible to share Jenkins files with host.
    The files will be accessable from :

      - Host - */path/on/host*
      - Container - */shared*

      - **/var/lib/jenknis** - "home" folder of jenkins (plugins, logs,  etc)
      - **/etc/sysconfig/jenkins** - jenkins configuration
      - **/root/.ssh** - root ssh keys should be used for the ssh plugin

    Docker command :

        docker run -d -P -v /path/on/host:/shared abraverm/jenkins:master
