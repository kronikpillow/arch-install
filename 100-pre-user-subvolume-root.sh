#!/bin/sh

# Create a BTRFS flat subvolume layout for root
echo "Creating a BTRFS flat subvolume layout for root"

# Create the top-level subvolume for the installation system
btrfs su cr /mnt/@

# Create the necessary directories for the root subvolume
mkdir -p /mnt/@/{boot,usr}

# Create the subvolumes for the various directories
btrfs su cr /mnt/@/var
btrfs su cr /mnt/@/usr/local
btrfs su cr /mnt/@/srv
btrfs su cr /mnt/@/root
btrfs su cr /mnt/@/opt
btrfs su cr /mnt/@/boot/grub
btrfs su cr /mnt/@/home

# Create the subvolume for the kronikpillow user
btrfs su cr /mnt/@/home/kronikpillow/

# Create the subvolumes for the kronikpillow user's directories
btrfs su cr /mnt/@/home/kronikpillow/Documents
btrfs su cr /mnt/@/home/kronikpillow/Downloads
btrfs su cr /mnt/@/home/kronikpillow/Music
btrfs su cr /mnt/@/home/kronikpillow/Pictures
btrfs su cr /mnt/@/home/kronikpillow/Videos
btrfs su cr /mnt/@/home/kronikpillow/.cache
btrfs su cr /mnt/@/home/kronikpillow/.local
btrfs su cr /mnt/@/home/kronikpillow/.steam
btrfs su cr /mnt/@/home/kronikpillow/.var
# btrfs su cr /mnt/@/home/kronikpillow/.snapshots

# Create the snapshot directory and the initial snapshot
btrfs su cr /mnt/@/.snapshots
mkdir -p /mnt/@/.snapshots/1
btrfs su cr /mnt/@/.snapshots/1/snapshot
touch /mnt/@/.snapshots/1/info.xml
cat <<EOF > /mnt/@/.snapshots/1/info.xml
<?xml version="1.0"?>
<snapshot>
  <type>single</type>
  <num>1</num>
  <date>$(date +"%Y-%m-%d %H:%M:%S")</date>
  <description>first root filesystem</description>
</snapshot>
EOF

# Create the necessary directories for the initial file system
mkdir -p /mnt/@/.snapshots/1/snapshot/{.snapshots,boot/{efi,grub},home,mnt/{btrfs,data,windows-c,windows-d,windows-e,usb},opt,root,srv,usr/local,var}

# Set the initial snapshot as the default for the root subvolume
btrfs subvolume set-default $(btrfs subvolume list /mnt | grep "@/.snapshots/1/snapshot" | grep -oP '(?<=ID )[0-9]+') /mnt

# Enable BTRFS quota
btrfs quota enable /mnt

# Display the list of subvolumes
btrfs subvolume list -t /mnt

# Print a success message
printf "\e[1;32m Btrfs subvolume layout with snapper rollback capabilities created. \e[0m"