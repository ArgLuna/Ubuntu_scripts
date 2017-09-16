#!/bin/sh

# This is a generic driver for a graphic framebuffer on intel boxes.
echo vesafb | tee -a /etc/initramfs-tools/modules
echo fbcon | tee -a /etc/initramfs-tools/modules
dpkg -i *image*.deb
dpkg -i *headers*.deb
update-grub
cat /dev/null > /var/log/kern.log
reboot
