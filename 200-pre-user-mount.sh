#!/bin/sh
echo "Mounting the BTRFS flat subvolume layout for Arch to /mnt"
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120 /dev/sda2 /mnt
mkdir -p /mnt/{.snapshots,boot/{efi,grub},home/kronikpillow,mnt/{btrfs,data,usb,windows-c,windows-d},opt,root,srv,usr/local,var/{cache,lib/{containers,docker,flatpak,libvirt,machines,portables},log,spool,tmp}}
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/.snapshots /dev/sda2 /mnt/.snapshots
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/boot/grub /dev/sda2 /mnt/boot/grub
mount -o defaults,noatime /dev/sda1 /mnt/boot/efi
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/kronikpillow /dev/sda2 /mnt/home/kronikpillow
mkdir -p /mnt/home/kronikpillow/{.snapshots,.cache,.local/share/Steam,.var,Documents,Downloads,Music,Pictures,Videos,repos,}
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/home/.snapshots /dev/sda2 /mnt/home/kronikpillow/.snapshots
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/home/.cache /dev/sda2 /mnt/home/kronikpillow/.cache
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/home/.local/share/Steam /dev/sda2 /mnt/home/kronikpillow/.local/share/Steam
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/home/.var /dev/sda2 /mnt/home/kronikpillow/.var
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/home/Downloads /dev/sda2 /mnt/home/kronikpillow/Downloads
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/home/Music /dev/sda2 /mnt/home/kronikpillow/Music
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/home/Pictures /dev/sda2 /mnt/home/kronikpillow/Pictures
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/home/Videos /dev/sda2 /mnt/home/kronikpillow/Videos
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/opt /dev/sda2 /mnt/opt
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/root /dev/sda2 /mnt/root
mount -o defatuls,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/srv /dev/sda2 /mnt/srv
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/usr/local /dev/sda2 /mnt/usr/local
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/cache /dev/sda2 /mnt/var/cache
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/lib/containers /dev/sda2 /mnt/var/lib/containers
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/lib/docker /dev/sda2 /mnt/var/lib/docker
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/lib/flatpak /dev/sda2 /mnt/var/lib/flatpak
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/lib/libvirt /dev/sda2 /mnt/var/lib/libvirt
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/lib/machines /dev/sda2 /mnt/var/lib/machines
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/lib/portables /dev/sda2 /mnt/var/lib/portables
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/log /dev/sda2 /mnt/var/log
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/spool /dev/sda2 /mnt/var/spool
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@/var/tmp /dev/sda2 /mnt/var/tmp
mount -o defaults,noatime,compress=zstd:1,space_cache=v2,autodefrag,commit=120,subvol=@data /dev/sdb2 /mnt/mnt/data
mount -o ntfs /dev/sdb1 /mnt/mnt/windows-d
printf "\e[1;32mDone! \e[0m"
