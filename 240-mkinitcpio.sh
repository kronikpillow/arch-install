#!/bin/sh
echo "configuring mkinitcpio settings"
sed -i "7 c\MODULES=(btrfs)" /etc/mkinitcpio.conf
sed -i "52 c\HOOKS=(base udev autodetect modconf block filesystems keyboard fsck shutdown)" /etc/mkinitcpio.conf

mkinitcpio -P

printf "\e[1;32mDone! \e[0m"
