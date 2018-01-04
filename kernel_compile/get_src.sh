#!/bin/bash
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
    echo -e "\E[1;31mPlease run as root."
	exit
fi

echo -e "\E[1;35m*****updating..."
tput init
apt-get update
# dpkg-dev is required to execute apt-get source linux-image-$(uname -r).
echo -e "\E[1;35m*****Installing dpkg-dev and git..."
tput init
apt-get install -y dpkg-dev git

echo -e "\E[1;35m*****Entering directory /usr/src"
tput init
cd /usr/src
pwd

# Get the source code.
if [ -d "/usr/src/ubuntu-$(lsb_release --codename | cut -f2)" ]; then
	echo -e "\E[1;35mFound source code directory. Start checking..."
	tput init
	cd ubuntu-$(lsb_release --codename | cut -f2)
	git fsck --full || echo -e "\E[1;31mIntegrity check fail..." && exit
	cd ..
else
	echo -e "\E[1;35m*****getting source code..."
	tput init
	git clone git://kernel.ubuntu.com/ubuntu/ubuntu-$(lsb_release --codename | cut -f2).git || echo -e "\E[1;31mError: get source code fail" && exit
fi

# Install packages that is required for compiling the file (linux-image-$(uname -r)).
echo -e "\E[1;35m*****checking dependent packages..."
tput init
apt-get build-dep -y linux-image-$(uname -r) || exit

# Copy install.sh and uninstall.sh
echo -e "\E[1;35m*****Copying install and uninstall scripts..."
tput init
cp ~/Ubuntu_scripts/kernel_compile/install_new.sh ./
cp ~/Ubuntu_scripts/kernel_compile/uninstall.sh ./

# Enter the image diectory.
echo -e "\E[1;35m*****Entering directory of source code"
tput init
cd ubuntu-$(lsb_release --codename | cut -f2)

# Copy start_compile.sh
echo -e "\E[1;35m*****Copying start_compile.sh..."
tput init
cp ~/Ubuntu_scripts/kernel_compile/start_compile.sh ./

# Copy the compile config of current OS.
echo -e "\E[1;35m*****copying current .config"
tput init
cp /boot/config* .config -v || exit

# Required package for make menuconfig.
echo -e "\E[1;35m*****Installing libncurses5-dev"
tput init
apt-get install -y libncurses5-dev || exit

## Required step to compile without a lot of questions.
## may not necessary
#make menuconfig

# Required for make-kpkg.
echo -e "\E[1;35m*****Installing kernel-package..."
tput init
apt-get install -y kernel-package || exit
echo -e "\E[1;35m*****Installing libssl-dev..."
tput init
apt-get install -y libssl-dev || exit
echo -e "\E[1;35m*****Installing llvm..."
tput init
apt-get install -y llvm || exit
echo -e "\E[1;35m*****Installing clang..."
tput init
apt-get install -y clang || exit

echo -e "\E[1;35m*****Getting source complete"

# checkinstall ubuntu-dev-tools bzr-builddeb git

# git clone git://kernel.ubuntu.com/ubuntu/ubuntu-$(lsb_release --codename | cut -f2).git
