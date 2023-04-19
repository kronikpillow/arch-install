#!/bin/sh
echo "Creating a BTRFS flat subvolume layout for Arch"
btrfs su cr /mnt/@arch
btrfs su cr /mnt/@arch/.snapshots
mkdir -p /mnt/@arch/.snapshots/1
btrfs su cr /mnt/@arch/.snapshots/1/snapshot
touch /mnt/@arch/.snapshots/1/info.xml
echo "
<?xml version="1.0"?>
<snapshot>
	<type>single</type>
	<num>1</num>
	<date></date>
	<description>First Root Filesystem Created at Installation</description>
</snapshot>" >> /mnt/@arch/.snapshots/1/info.xml

btrfs su cr /mnt/@arch/boot/grub

btrfs su cr /mnt/@arch/home
btrfs su cr /mnt/@arch/home/.snapshots

mkdir -p /mnt/@arch/{boot,usr,var/{cache/pacman/pkg,lib}

btrfs su cr /mnt/@arch/opt
btrfs su cr /mnt/@arch/root
btrfs su cr /mnt/@arch/srv
btrfs su cr /mnt/@arch/usr/local
btrfs su cr /mnt/@arch/var/cache/pacman/pkg
btrfs su cr /mnt/@arch/var/lib/containers
btrfs su cr /mnt/@arch/var/lib/docker
btrfs su cr /mnt/@arch/var/lib/flatpak
btrfs su cr /mnt/@arch/var/lib/libvirt
btrfs su cr /mnt/@arch/var/lib/machines
btrfs su cr /mnt/@arch/var/lib/portables
btrfs su cr /mnt/@arch/var/log
btrfs su cr /mnt/@arch/var/spool
btrfs su cr /mnt/@arch/var/tmp

btrfs subvolume set-default $(btrfs subvolume list /mnt | grep "@arch/.snapshots/1/snapshot" | grep -oP '(?<=ID )[0-9]+') /mnt

printf "\e[1;32m Remember to go to edit /mnt/@/.snapshots/1/info.xml and move current date and time to the date row between <date></date> and remove the excess date file \e[0m"
printf "\e[1;32m Remember to go to edit /mnt/@home/.snapshots/1/info.xml and move current date and time to the date row between <date></date> and remove the excess date file \e[0m"
