#!/bin/sh
echo "configuring mkinitcpio settings"

if [ ! -f /etc/mkinitcpio.conf.bak ];
then cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak && echo "/etc/mkinitcpio.conf backed up";
else echo "/etc/mkinitcpio.conf already backed up";
fi

sed -i "7 c\MODULES=(btrfs)" /etc/mkinitcpio.conf
sed -i "14 c\BINARIES=(/usr/bin/btrfs)" /etc/mkinitcpio.conf
sed -i "52 c\HOOKS=(base systemd autodetect keyboard sd-vconsole modconf block filesystems fsck)" /etc/mkinitcpio.conf

mkinitcpio -P

printf "\e[1;32mDone! \e[0m"
