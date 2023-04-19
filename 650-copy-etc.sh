#!/bin/sh
echo "creating backups of original installation files from /etc"

if [ ! -f /etc/locale.gen.bak ];
then cp /etc/locale.gen /etc/locale.gen.bak && echo "/etc/locale.gen backed up";
else echo "/etc/locale.gen already backed up";
fi

if [ ! -f /etc/locale.conf.bak ];
then cp /etc/locale.conf /etc/locale.conf.bak && echo "/etc/locale.conf backed up";
else echo "/etc/locale.conf already backed up";
fi

if [ ! -f /etc/hostname.bak ];
then cp /etc/hostname /etc/hostname.bak && echo "/etc/hostname backed up";
else echo "/etc/hostname already backed up";
fi

if [ ! -f /etc/pacman.conf.bak ];
then cp /etc/pacman.conf /etc/pacman.conf.bak && echo "/etc/pacman.conf backed up";
else echo "/etc/pacman.conf already backed up";
fi

if [ ! -f /etc/mkinitcpio.conf.bak ];
then cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak && echo "/etc/mkinitcpio.conf backed up";
else echo "/etc/mkinitcpio.conf already backed up";
fi

if [ ! -f /etc/default/grub.bak ];
then cp /etc/default/grub /etc/default/grub.bak && echo "/etc/default/grub backed up";
else echo "/etc/default/grub already backed up";
fi

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
else echo "/etc/updatedb.conf already backed up";
fi

if [ ! -f /etc/xdg/reflector/reflector.conf.bak ];
then cp /etc/xdg/reflector/reflector.conf /etc/reflector/reflector.conf.bak && echo "/etc/reflector/reflector.conf backed up";
else echo "/etc/reflector/reflector.conf already backed up";
fi

cp -r etc/* /etc/
cp -r usr/* /usr/

printf "\e[1;32mDone! \e[0m"
