#!/bin/bash

docker rmi -f nginx-grr-client
docker rmi -f ubuntu-grr-client
docker rmi -f grr-server
yes | docker image prune
