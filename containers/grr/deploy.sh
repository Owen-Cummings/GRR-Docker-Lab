#!/bin/bash

# SSH used to deploy new GRR client configuration to clients
# Set separator to "," for iterating through passed environment variable
IFS=","
for IP in $CLIENT_IPS
do
  ssh-keyscan $IP >> ~/.ssh/known_hosts
  sshpass -p "$SSH_PASS" scp /usr/share/grr-server/executables/installers/grr_*_amd64.deb root@$IP:/tmp/
  sshpass -p "$SSH_PASS" ssh root@$IP "dpkg -i /tmp/grr_*_amd64.deb && dpkg -i /tmp/grr_*_amd64.deb"
  sshpass -p "$SSH_PASS" ssh root@$IP "service grr start"
done
