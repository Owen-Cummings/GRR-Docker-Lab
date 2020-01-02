#!/bin/bash

# SSH used to deploy new GRR client configuration to clients

ssh-keyscan $IP >> ~/.ssh/known_hosts
sshpass -p "$SSH_PASS" scp /usr/share/grr-server/executables/installers/grr_*_amd64.deb root@$IP:/tmp/
sshpass -p "$SSH_PASS" ssh root@$IP "dpkg -i /tmp/grr_*_amd64.deb && dpkg -i /tmp/grr_*_amd64.deb && service grr start"
sshpass -p "$SSH_PASS" ssh root@$IP "service grr start"
