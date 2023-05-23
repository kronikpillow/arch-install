#!/bin/sh
echo "Creating a BTRFS flat subvolume layout for root"
btrfs su cr /mnt/@
mkdir -p /mnt/@/{boot,usr,var/lib}
btrfs su cr /mnt/@/var/tmp
btrfs su cr /mnt/@/var/spool
btrfs su cr /mnt/@/var/log
btrfs su cr /mnt/@/var/lib/portables
btrfs su cr /mnt/@/var/lib/machines
btrfs su cr /mnt/@/var/lib/libvirt
btrfs su cr /mnt/@/var/lib/flatpak
btrfs su cr /mnt/@/var/lib/docker
btrfs su cr /mnt/@/var/lib/containers
btrfs su cr /mnt/@/var/cache
btrfs su cr /mnt/@/usr/local
btrfs su cr /mnt/@/srv
btrfs su cr /mnt/@/root
btrfs su cr /mnt/@/opt
btrfs su cr /mnt/@/boot/grub

btrfs su cr /mnt/@/.snapshots
mkdir -p    /mnt/@/.snapshots/1
btrfs su cr /mnt/@/.snapshots/1/snapshot
touch       /mnt/@/.snapshots/1/info.xml
cat <<EOF > /mnt/@/.snapshots/1/info.xml
<?xml version="1.0"?>
<snapshot>
  <type>single</type>
  <num>1</num>
  <date>$(date +"%Y-%m-%d %H:%M:%S")</date>
  <description>first root filesystem</description>
</snapshot>
EOF

btrfs subvolume set-default $(btrfs subvolume list /mnt | grep "@/.snapshots/1/snapshot" | grep -oP '(?<=ID )[0-9]+') /mnt

btrfs quota enable /mnt

btrfs subvolume list -t /mnt
printf "\e[1;32m Btrfs subvolume layout with snapper rollback capabilities created. \e[0m"
