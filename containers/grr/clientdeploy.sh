#!/bin/bash

# SSH used to deploy new GRR client configuration to clients
sudo dpkg -i /grr-deploy-data/grr_*_amd64.deb
sudo service grr start
