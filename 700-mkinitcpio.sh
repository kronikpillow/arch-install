#!/bin/sh
echo "configuring mkinitcpio settings"
cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak
sed -i "7 c\MODULES=(btrfs amdgpu)" /etc/mkinitcpio.conf
sed -i "52 c\HOOKS=(base udev autodetect modconf block filesystems keyboard fsck shutdown)" /etc/mkinitcpio.conf

mkinitcpio -P

printf "\e[1;32mDone! \e[0m"
