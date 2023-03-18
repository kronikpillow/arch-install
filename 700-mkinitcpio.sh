#!/bin/sh
echo "configuring mkinitcpio settings"
if [ ! -f /etc/mkinitcpio.conf.bak ]; 
then cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak && echo "mkinitcpio.conf backed up to /etc/mkinitcpio.conf.bak";
else echo "pacman.conf already backed up";
fi

sed -i "7 c\MODULES=(btrfs)" /etc/mkinitcpio.conf
sed -i "14 c\BINARIES=(/usr/bin/btrfs)" /etc/mkinitcpio.conf
# sed -i "52 c\HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)" /etc/mkinitcpio.conf

mkinitcpio -P

printf "\e[1;32mDone! \e[0m"
