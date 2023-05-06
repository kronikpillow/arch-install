#!/bin/sh
echo "configuring grub settings & backing up default configs"

if [ ! -f /etc/default/grub.bak ];
then cp /etc/default/grub /etc/default/grub.bak && echo "/etc/default/grub backed up";
else echo "/etc/default/grub already backed up";
fi

if [ ! -f /etc/default/grub-btrfs/config.bak ];
then cp /etc/default/grub-btrfs/config /etc/default/grub-btrfs/config.bak && echo "/etc/default/grub-btrfs/config backed up";
else echo "/etc/default/grub-btrfs/config already backed up";
fi

#sed -i "s/GRUB_DEFAULT=0/GRUB_DEFAULT=save/" /etc/default/grub
sed -i '6 c\GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet nowatchdog amdgpu.dc=0"' /etc/default/grub
#sed -i "s/#GRUB_SAVEDEFAULT=true/GRUB_SAVEDEFAULT=true/" /etc/default/grub
sed -i "s/#GRUB_DISABLE_SUBMENU=y/GRUB_DISABLE_SUBMENU=y/" /etc/default/grub
sed -i "s/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/" /etc/default/grub

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

#rsync -a --delete /boot /.bootbackup

printf "\e[1;32mDone! \e[0m"
