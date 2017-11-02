#!/bin/sh
# This script can download ubuntu source code and relative packages.
# 2017.09.13
# No copy now.
# cd /usr/src
# 2017.09.08
# Add headers check and copy.
# 2017.09.07
# Only suit to Ubuntu 14.04.
# Add comments.
# Remove some commands or parameters that are not necessary.
# The package "debhelper" will be installed with apt-get build-dep linux-image-$(uname -r).
# apt-get source linux-image-$(uname -r) gets the lastest version, not current version.
#
# Future work: 
# Find image diectory by parameters.

# check permission
if [ $EUID != 0 ]; then
    echo 'Please run as root.'
	exit
fi

apt-get update
# dpkg-dev is required to execute apt-get source linux-image-$(uname -r).
apt-get install -y dpkg-dev git

echo *****Entering directory /usr/src
cd /usr/src
pwd

# Get the source code.
git clone git://kernel.ubuntu.com/ubuntu/ubuntu-$(lsb_release --codename | cut -f2).git
# Install packages that is required for compiling the file (linux-image-$(uname -r)).
apt-get build-dep -y linux-image-$(uname -r)
# Enter the image diectory.
cd ubuntu-$(lsb_release --codename | cut -f2)
# Copy the compile config of current OS. 
cp /boot/config* .config -v
# Required package for make menuconfig.
apt-get install -y libncurses5-dev
# Required step to compile without a lot of questions.
make menuconfig
# Required for make-kpkg.
apt-get install -y kernel-package
apt-get install -y libssl-dev llvm clang

echo *****Getting source complete
# checkinstall ubuntu-dev-tools bzr-builddeb git

# git clone git://kernel.ubuntu.com/ubuntu/ubuntu-$(lsb_release --codename | cut -f2).git
