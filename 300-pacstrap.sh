#!/bin/sh

echo "pacstrapping the base system"
pacstrap /mnt base base-devel linux linux-firmware mtools dosfstools exfatprogs ntfs-3g btrfs-progs reiserfsprogs man-db man-pages texinfo zsh zsh-completions git rsync wget polkit alsa-firmware alsa-plugins alsa-utils wireplumber pipewire-alsa pipewire-jack pipewire-pulse gst-plugin-pipewire networkmanager ufw ufw-extras reflector neovim cronie efibootmgr grub os-prober grub-btrfs intel-ucode snapper zram-generator

#echo "generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab

printf "\e[1;32mDone! \e[0m"
