apt-get purge -y linux-image-4.4.98+ || exit

rm -v linux-headers-4.4.98+_4.4.98+-10.00.Custom_amd64.deb
rm -v linux-image-4.4.98+_4.4.98+-10.00.Custom_amd64.deb

update-grub2
