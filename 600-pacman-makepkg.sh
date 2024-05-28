#!/bin/bash

# Backup pacman.conf
pacman_conf="/etc/pacman.conf"
pacman_conf_bak="/etc/pacman.conf.bak"
if [ ! -f "$pacman_conf_bak" ]; then
  cp "$pacman_conf" "$pacman_conf_bak"
  echo "$pacman_conf backed up"
else
  echo "$pacman_conf already backed up"
fi

sed -i 's|^#DBPath      = /var/lib/pacman/$|DBPath      = /var/lib/pacman/|' "$pacman_conf"
sed -i "s|^#HookDir     = /etc/pacman.d/hooks/$|HookDir     = /etc/pacman.d/hooks/|" "$pacman_conf"
sed -i "s|^#Color$|Color|" "$pacman_conf"
sed -i "/ILoveCandy/!s/^Color$/Color\nILoveCandy/" "$pacman_conf"
sed -i "s|^#VerbosePkgLists$|VerbosePkgLists|" "$pacman_conf"
sed -i "s|^#ParallelDownloads = 5$|ParallelDownloads = 5|" "$pacman_conf"
sed -i "0,/^\[multilib\]$/ s|^#Include = /etc/pacman.d/mirrorlist$|Include = /etc/pacman.d/mirrorlist|" "$pacman_conf"

# Configure reflector
reflector_conf="/etc/xdg/reflector/reflector.conf"
reflector_conf_bak="/etc/xdg/reflector/reflector.conf.bak"
if [ ! -f "$reflector_conf_bak" ]; then
  cp "$reflector_conf" "$reflector_conf_bak"
  echo "$reflector_conf backed up"
else
  echo "$reflector_conf already backed up"
fi

sed -i '24 c\--latest 15' "$reflector_conf"
sed -i '27 c\--sort rate' "$reflector_conf"

# Configure makepkg
makepkg_conf="/etc/makepkg.conf"
makepkg_conf_bak="/etc/makepkg.conf.bak"
if [ ! -f "$makepkg_conf_bak" ]; then
  cp "$makepkg_conf" "$makepkg_conf_bak"
  echo "$makepkg_conf backed up"
else
  echo "$makepkg_conf already backed up"
fi

# sed -i '49 c\MAKEFLAGS="-j4"' "$makepkg_conf"
sed -i '137 c\COMPRESSGZ=(pigz -c -f -n)' "$makepkg_conf"
sed -i '138 c\COMPRESSBZ2=(pbzip2 -c -f)' "$makepkg_conf"
# sed -i '139 c\COMPRESSXZ=(xz -c -z --threads=0 -)' "$makepkg_conf"
# sed -i '140 c\COMPRESSZST=(zstd -c -z -q --threads=0 -)' "$makepkg_conf"

printf "\e[1;32mDone! \e[0m"
