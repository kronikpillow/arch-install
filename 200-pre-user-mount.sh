#!/bin/sh

echo "Mounting the BTRFS flat subvolume layout for Arch to /mnt"

mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=@ /dev/sda2 /mnt
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=@.snapshots /dev/sda2 /mnt/.snapshots
mount /dev/sda1 /mnt/boot
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=@home /dev/sda2 /mnt/home
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=@home.snapshots /dev/sda2 /mnt/home/.snapshots
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=@opt /dev/sda2 /mnt/opt
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=@root /dev/sda2 /mnt/root
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=@srv /dev/sda2 /mnt/srv
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=@local /dev/sda2 /mnt/usr/local
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=@pkg /dev/sda2 /mnt/var/cache/pacman/pkg
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=@docker /dev/sda2 /mnt/var/lib/docker
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=@flatpak /dev/sda2 /mnt/var/lib/flatpak
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=@libvirt /dev/sda2 /mnt/var/lib/libvirt
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=@machines /dev/sda2 /mnt/var/lib/machines
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=@portables /dev/sda2 /mnt/var/lib/portables
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=@log /dev/sda2 /mnt/var/log
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvol=@tmp /dev/sda2 /mnt/var/tmp
mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=120,space_cache=v2,subvolid=5 /dev/sda2 /mnt/mnt/system

printf "\e[1;32mDone! \e[0m"
