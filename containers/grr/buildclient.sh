#!/bin/bash

sleep 20;

yes | cp grr-client.postinst.in /usr/share/grr-server/install_data/debian/dpkg_client/debian/grr-client.postinst.in

mv /clientdeploy.sh /grr-deploy-data

# Changing server keys and repacking installation .deb with altered post-install script
source /usr/share/grr-server/bin/activate
grr_config_updater rotate_server_key
grr_client_build build --output /usr/share/grr-server/grr-response-templates/templates
grr_client_build repack --template /usr/share/grr-server/grr-response-templates/templates/*amd64.deb.zip --output_dir /grr-deploy-data/
