#!/bin/sh

echo "Mounting the BTRFS flat subvolume layout for Arch to /mnt"

sudo mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=150,space_cache=v2,subvol=data/_cache /dev/sda2 /home/kronikpillow/.cache
sudo mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=150,space_cache=v2,subvol=data/_gnupg /dev/sda2 /home/kronikpillow/.gnupg
sudo mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=150,space_cache=v2,subvol=data/_local /dev/sda2 /home/kronikpillow/.local
sudo mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=150,space_cache=v2,subvol=data/_ssh /dev/sda2 /home/kronikpillow/.ssh
sudo mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=150,space_cache=v2,subvol=data/_pki /dev/sda2 /home/kronikpillow/.pki
sudo mount -o defaults,noatime,nodatacow,autodefrag,commit=150,subvol=data/_var /dev/sdb2 /home/kronikpillow/.var
sudo mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=150,space_cache=v2,subvol=data/dox /dev/sdb1 /home/kronikpillow/Documents
sudo mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=150,space_cache=v2,subvol=data/dwl /dev/sdb1 /home/kronikpillow/Downloads
sudo mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=150,space_cache=v2,subvol=data/muz /dev/sdb1 /home/kronikpillow/Music
sudo mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=150,space_cache=v2,subvol=data/pix /dev/sdb1 /home/kronikpillow/Pictures
sudo mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=150,space_cache=v2,subvol=data/vid /dev/sdb1 /home/kronikpillow/Videos
sudo mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=150,space_cache=v2,subvol=data/pro /dev/sdb1 /home/kronikpillow/projects
sudo mount -o defaults,noatime,nodatacow,autodefrag,commit=150,subvol=data/trt /dev/sdb2 /home/kronikpillow/torrents
sudo mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=150,space_cache=v2,subvol=data/abook /dev/sda2 /home/kronikpillow/.config/abook
sudo mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=150,space_cache=v2,subvol=data/BraveSoftware /dev/sda2 /home/kronikpillow/.config/BraveSoftware
sudo mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=150,space_cache=v2,subvol=data/discord /dev/sda2 /home/kronikpillow/.config/discord
sudo mount -o defaults,noatime,autodefrag,compress=zstd:1,commit=150,space_cache=v2,subvol=data/Popcorn-Time /dev/sda2 /home/kronikpillow/.config/Popcorn-Time
sudo mount -o defaults,noatime,nodatacow,autodefrag,commit=150,subvol=data/transmission-daemon /dev/sdb2 /home/kronikpillow/.config/transmission-daemon

printf "\e[1;32mDone! \e[0m"
