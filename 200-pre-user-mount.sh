#!/bin/sh
echo "Mounting the BTRFS flat subvolume layout for Arch to /mnt"

mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,commit=120                      /dev/nvme0n1p2  /mnt/opensuse
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,commit=120,subvol=@/.snapshots  /dev/nvme0n1p2  /mnt/opensuse/.snapshots
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,commit=120,subvol=@/boot/grub   /dev/nvme0n1p2  /mnt/opensuse/boot/grub
mount -o defaults,noatime                                                                                         /dev/nvme0n1p1  /mnt/opensuse/boot/efi
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,subvol=@/home                   /dev/nvme0n1p2  /mnt/opensuse/home
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,subvol=@/opt                    /dev/nvme0n1p2  /mnt/opensuse/opt
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,subvol=@/root                   /dev/nvme0n1p2  /mnt/opensuse/root
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,subvol=@/srv                    /dev/nvme0n1p2  /mnt/opensuse/srv
mount -o defaults,noatime,compress=zstd:1,discard=async,space_cache=v2,autodefrag,subvol=@/usr/local              /dev/nvme0n1p2  /mnt/opensuse/usr/local
mount -o defaults,noatime,nodatacow,subvol=@/var                                                                  /dev/nvme0n1p2  /mnt/opensuse/var
#mount -o defaults,noatime,nodatacow,subvol=@/containers       /dev/sda1       /mnt/opensuse/var/lib/containers
#mount -o defaults,noatime,nodatacow,subvol=@/libvirt          /dev/sda1       /mnt/opensuse/var/lib/libvirt
#mount -o defaults,noatime,nodatacow,subvol=@/machines         /dev/sda1       /mnt/opensuse/var/lib/machines
#mount -o defaults,noatime,nodatacow,subvol=@/podman           /dev/sda1       /mnt/opensuse/var/lib/podman

printf "\e[1;32mDone! \e[0m"
