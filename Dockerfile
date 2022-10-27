ARG IMAGE_VERSION=3.1
FROM assertsecurity.azurecr.io/venari:$IMAGE_VERSION AS base

RUN yum install -y python3 git gcc openssl-devel bzip2-devel libffi-devel zlib-devel xz-devel make

WORKDIR /usr/src
RUN wget https://www.python.org/ftp/python/3.7.11/Python-3.7.11.tgz && tar xzf Python-3.7.11.tgz 

WORKDIR /usr/src/Python-3.7.11
RUN ./configure --enable-optimizations && make altinstall && python3.7 -m pip install semgrep

WORKDIR /app

RUN wget https://opensource.wandisco.com/centos/8/svn-1.14/RPMS/x86_64/libserf-1.3.9-1.el8.x86_64.rpm \ 
    && wget https://opensource.wandisco.com/centos/8/svn-1.14/RPMS/x86_64/subversion-1.14.0-1.x86_64.rpm

RUN dnf install -y libserf-1.3.9-1.el8.x86_64.rpm subversion-1.14.0-1.x86_64.rpm

ENV server__semgrepexecmethod=ci DISPLAY=NONE SSH_ASKPASS=/root/.print_ssh_password.sh
ENV SEMGREP_SEND_METRICS=off
COPY ./.bashrc /root
COPY ./.print_ssh_password.sh /root
RUN chmod 700 /root/.print_ssh_password.sh

######  FOR SSH #######
# Copy a .ssh folder with an id_rsa private key file to support git commands over ssh
# Uncomment out below for ssh support with git or svn

# COPY ./.ssh /root/.ssh
# RUN chmod 700 /root/.ssh/id_rsa


