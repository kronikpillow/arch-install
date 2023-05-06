#!/bin/sh
echo "Mounting the BTRFS flat subvolume layout for Arch to /mnt"
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120 /dev/sda2 /mnt
mkdir -p /mnt/{.snapshots,boot/{efi,grub},home,mnt/{btrfs,data,usb,windows-c,windows-d},opt,root,srv,usr/local,var/{cache/pacman/pkg,lib/{containers,docker,flatpak,libvirt,machines,portables},log,spool,tmp}}
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/.snapshots /dev/sda2 /mnt/.snapshots
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/boot/grub /dev/sda2 /mnt/boot/grub
mount -o defaults,noatime /dev/sda1 /mnt/boot/efi
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/home /dev/sda2 /mnt/home
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/opt /dev/sda2 /mnt/opt
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/root /dev/sda2 /mnt/root
mount -o defatuls,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/srv /dev/sda2 /mnt/srv
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/usr/local /dev/sda2 /mnt/usr/local
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/cache/pacman/pkg /dev/sda2 /mnt/var/cache/pacman/pkg
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/lib/containers /dev/sda2 /mnt/var/lib/containers
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/lib/docker /dev/sda2 /mnt/var/lib/docker
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/lib/flatpak /dev/sda2 /mnt/var/lib/flatpak
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/lib/libvirt /dev/sda2 /mnt/var/lib/libvirt
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/lib/machines /dev/sda2 /mnt/var/lib/machines
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/lib/portables /dev/sda2 /mnt/var/lib/portables
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/log /dev/sda2 /mnt/var/log
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/spool /dev/sda2 /mnt/var/spool
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/tmp /dev/sda2 /mnt/var/tmp
# mount -o ntfs /dev/sdb1 /mnt/mnt/windows-d
printf "\e[1;32mDone! \e[0m"
