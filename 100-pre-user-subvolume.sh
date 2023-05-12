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
btrfs su cr /mnt/@/kronikpillow
btrfs su cr /mnt/@/home
btrfs su cr /mnt/@/home/.cache
mkdir -p /mnt/@/home/.local/share
btrfs su cr /mnt/@/home/.local/share/Steam
btrfs su cr /mnt/@/home/.var
btrfs su cr /mnt/@/home/Downloads
btrfs su cr /mnt/@/home/Music
btrfs su cr /mnt/@/home/Pictures
btrfs su cr /mnt/@/home/Videos
btrfs su cr /mnt/@/home/.snapshots
btrfs su cr /mnt/@/.snapshots
mkdir -p /mnt/@/.snapshots/1
btrfs su cr /mnt/@/.snapshots/1/snapshot
touch /mnt/@/.snapshots/1/info.xml
cat <<EOF > /mnt/@/.snapshots/1/info.xml
"<?xml version="1.0"?>
<snapshot>
  <type>single</type>
  <num>1</num>
  <date>$(date +"%Y-%m-%d %H:%M:%S")</date>
  <description>first root filesystem</description>
</snapshot>
EOF

btrfs subvolume set-default $(btrfs subvolume list /mnt | grep "@/.snapshots/1/snapshot" | grep -oP '(?<=ID )[0-9]+') /mnt

btrfs quota enable /mnt

chattr +C /mnt/@/var/tmp
chattr +C /mnt/@/var/spool
chattr +C /mnt/@/var/log
#chattr +C /mnt/@/var/lib/portables
#chattr +C /mnt/@/var/lib/machines
#chattr +C /mnt/@/var/lib/libvirt
#chattr +C /mnt/@/var/lib/flatpak
#chattr +C /mnt/@/var/lib/docker
#chattr +C /mnt/@/var/lib/containers
chattr +C /mnt/@/var/cache
chattr +C /mnt/@/kronikpillow/.cache

btrfs subvolume list -t /mnt
printf "\e[1;32m Btrfs subvolume layout with snapper rollback capabilities created. \e[0m"
