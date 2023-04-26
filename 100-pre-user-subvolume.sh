#!/bin/sh
echo "Creating a BTRFS flat subvolume layout for Arch"
btrfs su cr /mnt/@
mkdir -p /mnt/@/{boot,usr,var/{cache/pacman,lib}}
btrfs su cr /mnt/@/var/tmp
btrfs su cr /mnt/@/var/spool
btrfs su cr /mnt/@/var/log
btrfs su cr /mnt/@/var/lib/portables
btrfs su cr /mnt/@/var/lib/machines
btrfs su cr /mnt/@/var/lib/libvirt
btrfs su cr /mnt/@/var/lib/flatpak
btrfs su cr /mnt/@/var/lib/docker
btrfs su cr /mnt/@/var/lib/containers
btrfs su cr /mnt/@/var/cache/pacman/pkg
btrfs su cr /mnt/@/usr/local
btrfs su cr /mnt/@/srv
btrfs su cr /mnt/@/root
btrfs su cr /mnt/@/opt
btrfs su cr /mnt/@/home
btrfs su cr /mnt/@/boot/grub
btrfs su cr /mnt/@/.snapshots
mkdir -p /mnt/@/.snapshots/1
btrfs su cr /mnt/@/.snapshots/1/snapshot
touch /mnt/@/.snapshots/1/info.xml
echo "
<?xml version="1.0"?>
<snapshot>
	<type>single</type>
	<num>1</num>
	<date>$(which date)</date>
	<description>First Root Filesystem Created at Installation</description>
</snapshot>" >> /mnt/@/.snapshots/1/info.xml

btrfs subvolume set-default $(btrfs subvolume list /mnt | grep "@/.snapshots/1/snapshot" | grep -oP '(?<=ID )[0-9]+') /mnt

chattr +C /mnt/@/var/tmp
chattr +C /mnt/@/var/spool
chattr +C /mnt/@/var/log
chattr +C /mnt/@/var/lib/portables
chattr +C /mnt/@/var/lib/machines
chattr +C /mnt/@/var/lib/libvirt
chattr +C /mnt/@/var/lib/flatpak
chattr +C /mnt/@/var/lib/docker
chattr +C /mnt/@/var/lib/containers
chattr +C /mnt/@/var/cache/pacman/pkg

printf "\e[1;32m Remember to go to edit /mnt/@/.snapshots/1/info.xml and move current date and time to the date row between <date></date> and remove the excess date file \e[0m"
