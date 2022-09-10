#!/bin/sh

echo "Creating a BTRFS flat subvolume layout for Arch"

btrfs su cr /mnt/root
btrfs su cr /mnt/home
btrfs su cr /mnt/opt
btrfs su cr /mnt/admin
btrfs su cr /mnt/srv
btrfs su cr /mnt/usr_local
btrfs su cr /mnt/var_pkg
btrfs su cr /mnt/var_log
btrfs su cr /mnt/var_tmp
btrfs su cr /mnt/docker
btrfs su cr /mnt/flatpak
btrfs su cr /mnt/libvirt
btrfs su cr /mnt/machines
btrfs su cr /mnt/portables
btrfs su cr /mnt/snapshots_arch
btrfs su cr /mnt/snapshots_home

# setup mount points
mkdir -p /mnt/root/{.snapshots,boot,home/{.snapshots,kronikpillow},mnt/{btrfs,c,d,data,nocow,usb},opt,root,srv,usr/local,var/{cache/pacman/pkg,lib/{docker,flatpak,libvirt,machines,portables},log,tmp}}

# nodatacow, wondering if this is really needed?

# chattr +C /mnt/@docker
# chattr +C /mnt/@flatpak
# chattr +C /mnt/@libvirt
# chattr +C /mnt/@machines
# chattr +C /mnt/@portables

printf "\e[1;32mDone! \e[0m"
