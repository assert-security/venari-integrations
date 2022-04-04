# Venari Integrations
Build a customized venari job node image integrated with SemGrep

# Venari repository login

You will need to login to Assert Security's docker repository hosted on Azure. DevOps customers will have been sent the login information.  The login will look like the following:

````
docker login -u <user> -p <token> assertsecurity.azurecr.io
````

# SSH support
If you need to support authenticated access to a git repository over ssh, you should define the following three files in the .ssh folder before running docker build:

1) id_rsa
2) id_rsa.pub
3) known_hosts

In the Dockerfile you will need to un-comment out the commands related to SSH.

Make sure your git repository allows access via the public key defined in id_rsa.pub.  When running the docker image you will need to define a secret called "git-password" with the password to your private id_rsa file.  Defining secrets is out of scope for this document.  See our web site for more information at:

https://github.com/assert-security/venari-devops

# Building the image

````
docker build -t assertsecurity.azurecr.io/venari-integrations:3.5 --build-arg IMAGE_VERSION=3.5 .
````

# Importing Rules

Venari does not ship with SemGrep rules.  Once you have everything setup and running, use the Venari UI connected to the master job node to import SemGrep rules in the "Rules" tab on the sidebar menu.  You can get the open source SemGrep rules from here:

````
git clone https://github.com/returntocorp/semgrep-rules.git
````