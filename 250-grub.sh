#!/bin/sh

echo "configuring grub settings"
sed -i "s/GRUB_DEFAULT=0/GRUB_DEFAULT=save/" /etc/default/grub
sed -i '6 c\GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet nowatchdog amdgpu.dc=0 zswap.enabled=0"' /etc/default/grub
sed -i "s/#GRUB_SAVEDEFAULT=true/GRUB_SAVEDEFAULT=true/" /etc/default/grub
sed -i "s/#GRUB_DISABLE_SUBMENU=y/GRUB_DISABLE_SUBMENU=y/" /etc/default/grub
sed -i "s/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=true" /etc/default/grub

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

printf "\e[1;32mDone! \e[0m"
