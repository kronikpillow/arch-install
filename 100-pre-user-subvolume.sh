#!/bin/sh

echo "Creating a BTRFS flat subvolume layout for Arch"

btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@opt
btrfs su cr /mnt/@root
btrfs su cr /mnt/@srv
btrfs su cr /mnt/@local
btrfs su cr /mnt/@pkg
btrfs su cr /mnt/@log
btrfs su cr /mnt/@tmp
btrfs su cr /mnt/@docker
btrfs su cr /mnt/@flatpak
btrfs su cr /mnt/@libvirt
btrfs su cr /mnt/@machines
btrfs su cr /mnt/@portables
btrfs su cr /mnt/@.snapshots
btrfs su cr /mnt/@home.snapshots

# setup mount points
mkdir -p /mnt/@/{.snapshots,boot,home,mnt/{system,data,usb,windows-c,windows-d},opt,root,srv,usr/local,var/{cache/pacman/pkg,lib/{docker,flatpak,libvirt,machines,portables},log,tmp}}
mkdir -p /mnt/@home/.snapshots

printf "\e[1;32mDone! \e[0m"
