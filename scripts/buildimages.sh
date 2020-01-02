#!/bin/bash

docker build --rm -t nginx-grr-client containers/nginx/
docker build --rm -t ubuntu-grr-client containers/ubuntu/
docker build --rm -t grr-server containers/grr/
