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
btrfs su cr /mnt/@/home/kronikpillow
btrfs su cr /mnt/@/home/.cache
btrfs su cr /mnt/@/home/.snapshots
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
	<date></date>
	<description>First Root Filesystem Created at Installation</description>
</snapshot>" >> /mnt/@/.snapshoto/1/info.xml
btrfs su cr /mnt/@home/.snapshots/1/snapshot


btrfs subvolume set-default $(btrfs subvolume list /mnt | grep "@/.snapshots/1/snapshot" | grep -oP '(?<=ID )[0-9]+') /mnt

printf "\e[1;32m Remember to go to edit /mnt/@/.snapshots/1/info.xml and move current date and time to the date row between <date></date> and remove the excess date file \e[0m"
printf "\e[1;32m Remember to go to edit /mnt/@home/.snapshots/1/info.xml and move current date and time to the date row between <date></date> and remove the excess date file \e[0m"
