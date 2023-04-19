#!/bin/sh

echo "pacstrapping the base system"
pacstrap /mnt base base-devel linux-zen linux-firmware intel-ucode mtools dosfstools exfatprogs ntfs-3g btrfs-progs reiserfsprogs efibootmgr grub os-prober grub-btrfs man-db man-pages texinfo neovim zsh git rsync wget mlocate reflector cronie zram-generator alsa-firmware alsa-plugins alsa-utils wireplumber pipewire-alsa pipewire-jack pipewire-pulse gst-plugin-pipewire polkit networkmanager ufw snapper snap-pac

#echo "generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab

printf "\e[1;32mDone! \e[0m"
