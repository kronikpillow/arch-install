#!/bin/sh
echo "Mounting the BTRFS flat subvolume layout for Arch to /mnt"

mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,commit=120                      /dev/nvme0n1p6  /mnt
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,commit=120,subvol=@/.snapshots  /dev/nvme0n1p6  /mnt/.snapshots
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,commit=120,subvol=@/boot/grub   /dev/nvme0n1p6  /mnt/boot/grub
mount -o defaults,noatime                                                                                         /dev/nvme0n1p5  /mnt/boot/efi
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,commit=120,subvol=@/home        /dev/nvme0n1p6  /mnt/home
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,commit=120,subvol=@/opt         /dev/nvme0n1p6  /mnt/opt
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,commit=120,subvol=@/root        /dev/nvme0n1p6  /mnt/root
mount -o defatuls,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,commit=120,subvol=@/srv         /dev/nvme0n1p6  /mnt/srv
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,commit=120,subvol=@/usr/local   /dev/nvme0n1p6  /mnt/usr/local
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,commit=120,subvol=@/var         /dev/nvme0n1p6  /mnt/var
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,commit=120,subvolid=5           /dev/sdb1       /mnt/mnt/data
mount -o ntfs,defaults,noatime                                                                                    /dev/sda1       /mnt/mnt/windows-c
mount -o ntfs,defaults,noatime                                                                                    /dev/sda1       /mnt/mnt/windows-d
mount -o ntfs,defaults,noatime                                                                                    /dev/sdb2       /mnt/mnt/windows-e

printf "\e[1;32mDone! \e[0m"
