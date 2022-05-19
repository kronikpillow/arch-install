#!/bin/sh

echo "Creating a BTRFS flat subvolume layout for Arch"

btrfs su cr /mnt/hdd-cow/data
btrfs su cr /mnt/hdd-cow/data/dox
btrfs su cr /mnt/hdd-cow/data/dwl
btrfs su cr /mnt/hdd-cow/data/muz
btrfs su cr /mnt/hdd-cow/data/pix
btrfs su cr /mnt/hdd-cow/data/pro
btrfs su cr /mnt/hdd-cow/data/vid
btrfs su cr /mnt/hdd-cow/snap_hdd
btrfs su cr /mnt/hdd-cow/snap_hdd/_arch
btrfs su cr /mnt/hdd-cow/snap_hdd/_home
btrfs su cr /mnt/hdd-cow/snap_hdd/_dox
btrfs su cr /mnt/hdd-cow/snap_hdd/_muz
btrfs su cr /mnt/hdd-cow/snap_hdd/_pix
btrfs su cr /mnt/hdd-cow/snap_hdd/_pro
btrfs su cr /mnt/hdd-cow/snap_hdd/_vid
printf "\e[1;32mDone! \e[0m"
