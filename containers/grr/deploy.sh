#!/bin/bash

# Repacking installation .deb with altered post-install script
yes | cp grr-client.postinst.in /usr/share/grr-server/install_data/debian/dpkg_client/debian/grr-client.postinst.in
./usr/share/grr-server/bin/grr_client_build build --output /usr/share/grr-server/grr-response-templates/templates
./usr/share/grr-server/bin/grr_client_build repack --template /usr/share/grr-server/grr-response-templates/templates/*amd64.deb.zip --output_dir /usr/share/grr-server/executables/

# SSH used to deploy new GRR client configuration to clients
mkdir ~/.ssh/
touch ~/.ssh/known_hosts
for (( i=1; i<=$NGINX_CLIENT_COUNT; i++ ))
do
  #j=(2$i)
ssh-keyscan 172.20.1.$i >> ~/.ssh/known_hosts
sshpass -p "$SSH_PASS" scp /usr/share/grr-server/executables/installers/grr_*_amd64.deb root@172.20.1.$i:/tmp/
sshpass -p "$SSH_PASS" ssh root@172.20.1.$i "dpkg -i /tmp/grr_*_amd64.deb && dpkg -i /tmp/grr_*_amd64.deb && service grr start"
sshpass -p "$SSH_PASS" ssh root@172.20.1.$i "service grr start"
done

for (( i=1; i<=$UBUNTU_CLIENT_COUNT; i++ ))
do
  #j=($i)
ssh-keyscan 172.20.2.$i >> ~/.ssh/known_hosts
sshpass -p "$SSH_PASS" scp /usr/share/grr-server/executables/installers/grr_*_amd64.deb root@172.20.2.$i:/tmp/
sshpass -p "$SSH_PASS" ssh root@172.20.2.$i "dpkg -i /tmp/grr_*_amd64.deb && dpkg -i /tmp/grr_*_amd64.deb && service grr start"
sshpass -p "$SSH_PASS" ssh root@172.20.2.$i "service grr start"
done
