#!/bin/bash

apt-get install -y ipython python-tk

apt-get install -y ipython3 python3-tk

# install pwntools
apt-get install -y python-pip || exit
pip install pwntools
pip install --upgrade capstone
