#!/bin/bash

# Repacking installation .deb with altered post-install script
yes | cp grr-client.postinst.in /usr/share/grr-server/install_data/debian/dpkg_client/debian/grr-client.postinst.in
./usr/share/grr-server/bin/grr_client_build build --output /usr/share/grr-server/grr-response-templates/templates
./usr/share/grr-server/bin/grr_client_build repack --template /usr/share/grr-server/grr-response-templates/templates/*amd64.deb.zip --output_dir /usr/share/grr-server/executables/

#add known_hosts file for client scanning
mkdir ~/.ssh/
touch ~/.ssh/known_hosts
