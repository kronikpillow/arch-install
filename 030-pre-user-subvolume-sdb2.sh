#!/bin/sh

echo "Creating a BTRFS flat subvolume layout for Arch"
btrfs su cr /mnt/hdd-nocow/docker
btrfs su cr /mnt/hdd-nocow/flatpak
btrfs su cr /mnt/hdd-nocow/libvirt
btrfs su cr /mnt/hdd-nocow/machines
btrfs su cr /mnt/hdd-nocow/portables
btrfs su cr /mnt/hdd-nocow/data
btrfs su cr /mnt/hdd-nocow/data/transmission-daemon
btrfs su cr /mnt/hdd-nocow/data/_var
btrfs su cr /mnt/hdd-nocow/data/trt

printf "\e[1;32mDone! \e[0m"
