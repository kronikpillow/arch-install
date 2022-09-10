#!/bin/sh

echo "Mounting the BTRFS flat subvolume layout for Arch to /mnt"

mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=root /dev/sda2 /mnt
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=snapshots_root /dev/sda2 /mnt/.snapshots
mount /dev/sda1 /mnt/boot
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=home /dev/sda2 /mnt/home
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=snapshots_home /dev/sda2 /mnt/home/.snapshots
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=opt /dev/sda2 /mnt/opt
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=admin /dev/sda2 /mnt/root
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=srv /dev/sda2 /mnt/srv
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=usr_local /dev/sda2 /mnt/usr/local
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=var_pkg /dev/sda2 /mnt/var/cache/pacman/pkg
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=var_log /dev/sda2 /mnt/var/log
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=var_tmp /dev/sda2 /mnt/var/tmp
mount -o defaults,noatime,nodatacow,commit=120,subvol=docker /dev/sda2 /mnt/var/lib/docker
mount -o defaults,noatime,nodatacow,commit=120,subvol=flatpak /dev/sda2 /mnt/var/lib/flatpak
mount -o defaults,noatime,nodatacow,commit=120,subvol=libvirt /dev/sda2 /mnt/var/lib/libvirt
mount -o defaults,noatime,nodatacow,commit=120,subvol=machines /dev/sda2 /mnt/var/lib/machines
mount -o defaults,noatime,nodatacow,commit=120,subvol=portables /dev/sda2 /mnt/var/lib/portables

#mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvolid=5 /dev/sda2 /mnt/mnt/btrfs
#mount -o defaults,noatime /dev/sdb1 /mnt/mnt/data
#mount -o defaults,noatime,nodatacow,commit=120,subvolid=5 /dev/sdb3 /mnt/mnt/nocow

printf "\e[1;32mDone! \e[0m"
