having fun
Jenkins
=======

Dockerfiles for creating Jenkins master and node based on Fedora image.
Jenkins master, with the help of Docker plugin, able to start jobs on node.

I've tested with the following :

* Docker -  1.0.0 on Fedora 20
* Jenkins - 1.576 (latest image on Docker) on fedora 20
* Docker plugin - 0.7

Make sure to configure Docker host to listen on TCP port
(*/etc/systemd/system/multi-user.target.wants/docker.service*):

    ExecStart=/usr/bin/docker -d --selinux-enabled -H fd://  -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock

Also I suggest to check that your docker can run the images.
__Note__ "PORT" is the mapped port , from Docker host to container's exposed port:

1. Jenkins master

        docker run -d -P -v /path/on/host/jenkins:/shared abraverm/jenkins:master
    * access from browser to localhost:PORT
    * Jenkins files (inside the contanier) will be accessible from host in /path/on/host

2. Jenkins node

        docker run -d -P abraverm/jenkins:node
        ssh root@localhost -p PORT
		    password: 123456

How to use Jenkins with Docker
------------------------------

1. start Jenkins master container (look above for details)
2. install Docker plugin in Jenkins
3. configure Docker plugin:

    1. go to Jenkins > manage jenkins > configure system , scroll down to section 'Cloud'.
    2. add new cloud > docker

        * Name : something
        * URL : http://172.17.42.1:4243
        * test connection

    3. 'Add image'

      a. Simple node
        * ID : abraverm/jenkins:node
        * Labels : something2
        * Credentials: Add
            - Kind: SSH Username with private key
            - Scope: Global
            - Username: root
            - Private Key: From the Jenkins master ~/.ssh
        * Remote Filing System Root: /root
        * Advanced
            - Volumes: /path/on/host/jenkins/ssh/id_rsa.pub:/root/.ssh/authorized_keys

      b. Nested docker node - running docker from inside a docker node
        * ID : abraverm/jenkins:docker
        * Labels : something3
        * Credentials : same as simple node or:
            - Kind: SSH Username with password
            - Scope: Global
            - Username: root
            - Password: 123456
        * Remote Filing System Root: /root
        * Advanced:
            - Volumes: /var/run/docker.sock:/var/run/docker.sock
            - Run container privileged: true
