#!/bin/sh
echo "Mounting the BTRFS flat subvolume layout for Arch to /mnt"

mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2                      /dev/nvme0n1p2  /mnt/opensuse
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,subvol=@/.snapshots  /dev/nvme0n1p2  /mnt/opensuse/.snapshots
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,subvol=@/boot/grub   /dev/nvme0n1p2  /mnt/opensuse/boot/grub
mount -o defaults,noatime                                                                                   /dev/nvme0n1p1  /mnt/opensuse/efi
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,subvol=@/home        /dev/nvme0n1p2  /mnt/opensuse/home
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,subvol=@/opt         /dev/nvme0n1p2  /mnt/opensuse/opt
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,subvol=@/root        /dev/nvme0n1p2  /mnt/opensuse/root
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,subvol=@/srv         /dev/nvme0n1p2  /mnt/opensuse/srv
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,subvol=@/usr/local   /dev/nvme0n1p2  /mnt/opensuse/usr/local
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,subvol=@/var         /dev/nvme0n1p2  /mnt/opensuse/var

printf "\e[1;32mDone! \e[0m"
