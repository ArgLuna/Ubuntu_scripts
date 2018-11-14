#!/bin/bash

cp /dev/null /etc/lightdm/lightdm.conf
echo "[Seat:*]" >> /etc/lightdm/lightdm.conf
echo "autologin-guest=false" >> /etc/lightdm/lightdm.conf
echo "autologin-user=ian" >> /etc/lightdm/lightdm.conf
echo "autologin-user-timeout=0" >> /etc/lightdm/lightdm.conf
