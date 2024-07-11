#!/usr/bin/env bash

set eux

sudo docker image rm -f debian-sid-builder

sudo docker build . -t debian-sid-builder
sudo docker run --rm -t -v $PWD:/shared debian-sid-builder
