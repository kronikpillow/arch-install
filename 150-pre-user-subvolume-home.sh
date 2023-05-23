#!/bin/sh
echo "Creating a BTRFS flat subvolume layout for home"
btrfs su cr /mnt/@kronikpillow/
btrfs su cr /mnt/@kronikpillow/.cache
mkdir -p    /mnt/@kronikpillow/.local/share
btrfs su cr /mnt/@kronikpillow/.local/share/Steam
btrfs su cr /mnt/@kronikpillow/.var
btrfs su cr /mnt/@kronikpillow/Documents
# btrfs su cr /mnt/@kronikpillow/Downloads
# btrfs su cr /mnt/@kronikpillow/Music
# btrfs su cr /mnt/@kronikpillow/Pictures
# btrfs su cr /mnt/@kronikpillow/Videos
btrfs su cr /mnt/@kronikpillow/repos

btrfs su cr /mnt/@kronikpillow/.snapshots
mkdir -p    /mnt/@kronikpillow/.snapshots/1
btrfs su cr /mnt/@kronikpillow/.snapshots/1/snapshot
touch       /mnt/@kronikpillow/.snapshots/1/info.xml
cat <<EOF > /mnt/@kronikpillow/.snapshots/1/info.xml
<?xml version="1.0"?>
<snapshot>
  <type>single</type>
  <num>1</num>
  <date>$(date +"%Y-%m-%d %H:%M:%S")</date>
  <description>first home filesystem</description>
</snapshot>
EOF

btrfs subvolume set-default $(btrfs subvolume list /mnt | grep "@kronikpillow/.snapshots/1/snapshot" | grep -oP '(?<=ID )[0-9]+') /mnt

btrfs quota enable /mnt

btrfs subvolume list -t /mnt
printf "\e[1;32m Btrfs subvolume layout with snapper rollback capabilities created. \e[0m"
