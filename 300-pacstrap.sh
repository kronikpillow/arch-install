#!/bin/sh

echo "pacstrapping the base system"
pacstrap /mnt base base-devel linux linux-firmware linux-headers mtools dosfstools exfatprogs ntfs-3g btrfs-progs reiserfsprogs man-db man-pages texinfo bash-completion zsh zsh-completions dash fish git rsync wget alsa-firmware alsa-plugins alsa-utils polkit networkmanager neovim reflector snapper cronie efibootmgr grub os-prober grub-btrfs intel-ucode zram-generator

#echo "generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab

printf "\e[1;32mDone! \e[0m"
