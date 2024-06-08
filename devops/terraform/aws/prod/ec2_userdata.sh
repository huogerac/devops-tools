#!/bin/bash

# Update the apt package index:
sudo apt-get update --fix-missing

## Install Ansible requirements
sudo apt-get install -y --no-install-recommends build-essential libbz2-dev python3-pip wget curl vim locales zip unzip apt-utils vim
sudo python3 -m pip config --global set global.break-system-packages true
sudo python3 -m pip install --user ansible-core
# sudo pip install docker
