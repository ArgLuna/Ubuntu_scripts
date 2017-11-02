#!/bin/bash

apt-get update
apt-get install -y python-pip || exit
pip install pwntools
pip install --upgrade capstone

