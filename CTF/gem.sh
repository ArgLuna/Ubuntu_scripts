#!/bin/bash

# general
apt-get install -y ruby gem

# for ruby pwntools, rake
apt-get install -y ruby-dev

gem install one_gadget

gem install rake
gem install pwntools
