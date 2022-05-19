#!/bin/sh

echo "Creating a BTRFS flat subvolume layout for Arch"

btrfs su cr /mnt/arch
mkdir -p /mnt/arch/{.snapshots,boot,home,opt,mnt/{ssd,hdd-cow,hdd-nocow,usb},root,srv,usr/local,var}
btrfs su cr /mnt/home/
mkdir -p /mnt/home/.snapshots
btrfs su cr /mnt/opt
btrfs su cr /mnt/root
btrfs su cr /mnt/srv
mkdir -p /mnt/usr
btrfs su cr /mnt/usr/local
btrfs su cr /mnt/var
mkdir -p /mnt/var/{cache/pacman/pkg,lib/{docker,flatpak,libvirt,machines,portables},log,tmp}
chattr +C /mnt/var/lib/docker
chattr +C /mnt/var/lib/flatpak
chattr +C /mnt/var/lib/libvirt
chattr +C /mnt/var/lib/machines
chattr +C /mnt/var/lib/portables
btrfs su cr /mnt/var_pkg
btrfs su cr /mnt/var_log
btrfs su cr /mnt/var_tmp
btrfs su cr /mnt/data
btrfs su cr /mnt/data/_cache
btrfs su cr /mnt/data/_gnupg
btrfs su cr /mnt/data/_local
btrfs su cr /mnt/data/_pki
btrfs su cr /mnt/data/_ssh
btrfs su cr /mnt/data/abook
btrfs su cr /mnt/data/BraveSoftware
btrfs su cr /mnt/data/discord
btrfs su cr /mnt/data/Popcorn-Time
btrfs su cr /mnt/snap_ssd/
btrfs su cr /mnt/snap_ssd/_arch
btrfs su cr /mnt/snap_ssd/_home
printf "\e[1;32mDone! \e[0m"
