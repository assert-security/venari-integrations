ARG IMAGE_VERSION=3.1
FROM assertsecurity.azurecr.io/venari:$IMAGE_VERSION AS base

RUN yum install -y python3 git && python3 -m pip install semgrep

ENV server__semgrepexecmethod=ci DISPLAY=NONE SSH_ASKPASS=/root/.print_ssh_password.sh
COPY ./.bashrc /root
COPY ./.print_ssh_password.sh /root
RUN chmod 700 /root/.print_ssh_password.sh

######  FOR SSH #######
# Copy a .ssh folder with an id_rsa private key file to support git commands over ssh
# Uncomment out below for ssh support with git

# COPY ./.ssh /root/.ssh
# RUN chmod 700 /root/.ssh/id_rsa


