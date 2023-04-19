#!/bin/sh
echo "creating backups of original installation files from /etc"


if [ ! -f /etc/default/grub-btrfs/config.bak ];
then cp /etc/default/grub-btrfs/config /etc/default/grub-btrfs/config.bak && echo "/etc/default/grub-btrfs/config backed up";
else echo "/etc/default/grub-btrfs/config already backed up";
fi

if [ ! -f /etc/makepkg.conf.bak ];
then cp /etc/makepkg.conf /etc/makepkg.conf.bak && echo "/etc/makepkg.conf backed up";
else echo "/etc/makepkg.conf already backed up";
fi

if [ ! -f /etc/updatedb.conf.bak ];
then cp /etc/updatedb.conf /etc/updatedb.conf.bak && echo "/etc/updatedb.conf backed up";
else echo "/etc/reflector/reflector.conf already backed up";
fi

cp -r etc/* /etc/
cp -r usr/* /usr/

printf "\e[1;32mDone! \e[0m"
