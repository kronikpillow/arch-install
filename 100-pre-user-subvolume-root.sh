#!/bin/sh

# Create a BTRFS flat subvolume layout for root
echo "Creating a BTRFS flat subvolume layout for root"

# Create the top-level subvolume for the installation system
btrfs su cr /mnt/opensuse/@

# Create the necessary directories for the root subvolume
mkdir -p /mnt/opensuse/@/{boot,usr}

# Create the subvolumes for the various directories
btrfs su cr /mnt/opensuse/@/var
chattr +C   /mnt/opensuse/@/var
btrfs su cr /mnt/opensuse/@/usr/local
btrfs su cr /mnt/opensuse/@/srv
btrfs su cr /mnt/opensuse/@/root
btrfs su cr /mnt/opensuse/@/opt
btrfs su cr /mnt/opensuse/@/home
btrfs su cr /mnt/opensuse/@/boot/grub

# Create the snapshot directory and the initial snapshot
btrfs su cr /mnt/opensuse/@/.snapshots
mkdir -p /mnt/opensuse/@/.snapshots/1
btrfs su cr /mnt/opensuse/@/.snapshots/1/snapshot
touch /mnt/opensuse/@/.snapshots/1/info.xml
cat << EOF >> /mnt/opensuse/@/.snapshots/1/info.xml
<?xml version="1.0"?>
<snapshot>
  <type>single</type>
  <num>1</num>
  <date>$(date +"%Y-%m-%d %H:%M:%S")</date>
  <description>first root filesystem</description>
</snapshot>
EOF
chmod 600 /mnt/@/.snapshots/1/info.xml


# Create the necessary directories for the initial file system
mkdir -p /mnt/opensuse/@/.snapshots/1/snapshot/{.snapshots,boot/grub,efi,home,mnt/{btrfs,data,usb},opt,root,srv,usr/local,var}

# Set the initial snapshot as the default for the root subvolume
btrfs subvolume set-default $(btrfs subvolume list /mnt/opensuse | grep "@/.snapshots/1/snapshot" | grep -oP '(?<=ID )[0-9]+') /mnt/opensuse

# Enable BTRFS quota
btrfs quota enable /mnt/opensuse
btrfs qgroup create 1/0 /mnt/opensuse

# Display the list of subvolumes
btrfs subvolume list -t /mnt/opensuse


# Print a success message
printf "\e[1;32m Btrfs subvolume layout with snapper rollback capabilities created. \e[0m"
