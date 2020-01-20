#!/bin/bash

# Configure SSH to allow GRR server to deploy client .deb
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "root:$SSH_PASS" | chpasswd root
echo "root:$SSH_PASS" | chpasswd root

service ssh stop
service ssh start
