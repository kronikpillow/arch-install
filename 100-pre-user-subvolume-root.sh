#!/bin/sh
echo "Creating a BTRFS flat subvolume layout for root"
btrfs su cr /mnt/@ # this subvolume is not mounted in fstab, the subvolumes of this subvolume are mounted in to @/.snapshots/1/snapshot which will be the first root filesystem
mkdir -p /mnt/@/{boot,usr,var/lib}
btrfs su cr /mnt/@/var/tmp
btrfs su cr /mnt/@/var/spool
btrfs su cr /mnt/@/var/log
btrfs su cr /mnt/@/var/lib/portables
btrfs su cr /mnt/@/var/lib/machines
btrfs su cr /mnt/@/var/lib/libvirt
btrfs su cr /mnt/@/var/lib/flatpak
# btrfs su cr /mnt/@/var/lib/docker
btrfs su cr /mnt/@/var/lib/containers
btrfs su cr /mnt/@/var/crash
btrfs su cr /mnt/@/var/cache
btrfs su cr /mnt/@/usr/local
btrfs su cr /mnt/@/srv
btrfs su cr /mnt/@/root
btrfs su cr /mnt/@/opt
btrfs su cr /mnt/@/boot/grub
btrfs su cr /mnt/@/home/
btrfs su cr /mnt/@/home/.snapshots
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

mkdir -p /mnt/@/.snapshots/1/snapshot/{.snapshots,boot/{efi,grub},home,mnt/{btrfs,data,usb},opt,root,srv,usr/local,var/{cache,crash,lib/{containers,docker,flatpak,libvirt,machines,portables},log,tmp}}

btrfs subvolume set-default $(btrfs subvolume list /mnt | grep "@/.snapshots/1/snapshot" | grep -oP '(?<=ID )[0-9]+') /mnt
btrfs quota enable /mnt
btrfs subvolume list -t /mnt
printf "\e[1;32m Btrfs subvolume layout with snapper rollback capabilities created. \e[0m"

# btrfs su cr /mnt/@/home/kronikpillow/.cache
# btrfs su cr /mnt/@/home/kronikpillow/.local/share/containers
# btrfs su cr /mnt/@/home/kronikpillow/.local/share/flatpak
# btrfs su cr /mnt/@/home/kronikpillow/.local/share/Steam
# btrfs su cr /mnt/@/home/kronikpillow/.var
# btrfs su cr /mnt/@/home/kronikpillow/Documents
# btrfs su cr /mnt/@/home/kronikpillow/Downloads
# btrfs su cr /mnt/@/home/kronikpillow/Music
# btrfs su cr /mnt/@/home/kronikpillow/Pictures
# btrfs su cr /mnt/@/home/kronikpillow/Videos
# btrfs su cr /mnt/@/home/kronikpillow/repos
