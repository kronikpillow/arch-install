#!/bin/sh

echo "Creating a BTRFS flat subvolume layout for Arch"
btrfs su cr /mnt/@subvolumes
btrfs su cr /mnt/@flatpak
btrfs su cr /mnt/@images
btrfs su cr /mnt/@machines
btrfs su cr /mnt/@portables
printf "\e[1;32mDone! \e[0m"
