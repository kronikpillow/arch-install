#!/bin/sh

echo "pacstrapping the base system"
pacstrap /mnt base base-devel linux-zen linux-firmware intel-ucode mtools dosfstools exfatprogs ntfs-3g btrfs-progs reiserfsprogs efibootmgr grub os-prober grub-btrfs man-db man-pages texinfo zsh zsh-completions git rsync wget mlocate polkit networkmanager reflector neovim cronie zram-generator snapper snap-pac

#echo "generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab

printf "\e[1;32mDone! \e[0m"
