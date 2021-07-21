#!/bin/bash

export PATH=$PATH:/usr/bin

sudo apt-get update

sudo apt-get install -y vim htop build-essential \
    libssl-dev libffi-dev net-tools \
    python3-dev python3-pip python-setuptools
