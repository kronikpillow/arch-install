#!/bin/sh

echo "Creating a BTRFS flat subvolume layout for Arch"

btrfs su cr /mnt/@
mkdir -p /mnt/@/{.snapshots,boot,home,opt,mnt/{systm,nocow,snaps,data,usb},root,srv,usr/local,var}
btrfs su cr /mnt/@opt
btrfs su cr /mnt/@root
btrfs su cr /mnt/@srv
btrfs su cr /mnt/@usr_local
btrfs su cr /mnt/@var
mkdir -p /mnt/@var/{cache/pacman/pkg,lib/{docker/btrfs/subvolumes,flatpak,libvirt/images,machines,portables},log,tmp}
chattr +C /mnt/@var/lib/docker/btrfs/subvolumes
chattr +C /mnt/@var/lib/flatpak
chattr +C /mnt/@var/lib/libvirt/images
chattr +C /mnt/@var/lib/machines
chattr +C /mnt/@var/lib/portables
btrfs su cr /mnt/@snapshots
printf "\e[1;32mDone! \e[0m"
