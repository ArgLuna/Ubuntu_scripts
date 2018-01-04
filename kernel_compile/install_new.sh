#!/bin/sh

# This is a generic driver for a graphic framebuffer on intel boxes.
echo vesafb | tee -a /etc/initramfs-tools/modules
echo fbcon | tee -a /etc/initramfs-tools/modules
dpkg -i *image*.deb || exit
dpkg -i *headers*.deb || exit
update-grub2
cat /dev/null > /var/log/kern.log
reboot
