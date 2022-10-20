#!/bin/sh

echo "pacstrapping the base system"
pacstrap /mnt base base-devel linux linux-firmware mtools dosfstools exfatprogs ntfs-3g btrfs-progs reiserfsprogs alsa-firmware alsa-utils networkmanager neovim man-db man-pages texinfo zsh git rsync wget reflector snapper cronie efibootmgr grub os-prober grub-btrfs intel-ucode zram-generator polkit

#echo "generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab

printf "\e[1;32mDone! \e[0m"
