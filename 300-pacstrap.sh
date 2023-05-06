#!/bin/sh

echo "pacstrapping the base system"
pacstrap /mnt base base-devel linux linux-firmware intel-ucode exfatprogs ntfs-3g btrfs-progs efibootmgr grub os-prober grub-btrfs inotify-tools man-db man-pages texinfo zsh neovim lf git rsync wget mlocate pkgfile reflector cronie dbus-broker polkit zram-generator pigz pbzip2 alsa-firmware alsa-plugins alsa-utils wireplumber pipewire-alsa pipewire-jack pipewire-pulse gst-plugin-pipewire networkmanager xf86-video-amdgpu snapper snap-pac
#pacstrap /mnt base base-devel linux linux-firmware intel-ucode mtools dosfstools exfatprogs ntfs-3g btrfs-progs reiserfsprogs efibootmgr grub os-prober grub-btrfs inotify-tools man-db man-pages texinfo zsh neovim lf git rsync wget mlocate pkgfile reflector cronie dbus-broker polkit zram-generator pigz pbzip2 alsa-firmware alsa-plugins alsa-utils wireplumber pipewire-alsa pipewire-jack pipewire-pulse gst-plugin-pipewire networkmanager xf86-video-amdgpu snapper snap-pac

#echo "generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab

printf "\e[1;32mDone! \e[0m"
