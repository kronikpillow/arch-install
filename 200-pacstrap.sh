#!/bin/sh

echo "pacstrapping the base system"
pacstrap /mnt base base-devel linux linux-firmware btrfs-progs xfsprogs dosfstools exfatprogs ntfs-3g alsa-firmware alsa-utils networkmanager neovim man-db man-pages texinfo zsh git rsync reflector snapper cronie efibootmgr grub os-prober grub-btrfs intel-ucode zram-generator

#echo "generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab

printf "\e[1;32mDone! \e[0m"
