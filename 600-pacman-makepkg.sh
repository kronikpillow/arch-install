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

sed -i 's|^#DBPath      = /var/lib/pacman/$|DBPath      = /usr/lib/pacman/|' "$pacman_conf"
sed -i "s|^#HookDir     = /etc/pacman.d/hooks/$|HookDir     = /etc/pacman.d/hooks/|" "$pacman_conf"
sed -i "s|^#Color$|Color|" "$pacman_conf"
sed -i "/ILoveCandy/!s/^Color$/Color\nILoveCandy/" "$pacman_conf"
sed -i "s|^#VerbosePkgLists$|VerbosePkgLists|" "$pacman_conf"
sed -i "s|^#ParallelDownloads = 5$|ParallelDownloads = 5|" "$pacman_conf"

if [ -d /var/lib/pacman ]; then
mv /var/lib/pacman /usr/lib/pacman
else
  echo "/var/lib/pacman already moved to /usr/lib/pacman"
fi

# Configure makepkg
makepkg_conf="/etc/makepkg.conf"
makepkg_conf_bak="/etc/makepkg.conf.bak"
if [ ! -f "$makepkg_conf_bak" ]; then
  cp "$makepkg_conf" "$makepkg_conf_bak"
  echo "$makepkg_conf backed up"
else
  echo "$makepkg_conf already backed up"
fi

numberofcores=$(grep -c ^processor /proc/cpuinfo)


case $numberofcores in
    16|8|6|4|2)
        echo "You have $numberofcores cores."
        echo "Changing the makeflags for $numberofcores cores."
        sudo sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$((numberofcores+1))\"/g" /etc/makepkg.conf
        echo "Changing the compression settings for $numberofcores cores."
        sudo sed -i "s/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T $numberofcores -z -)/g" /etc/makepkg.conf
        ;;
    *)
        echo "We do not know how many cores you have."
        echo "Do it manually."
        ;;
esac

printf "\e[1;32mDone! \e[0m"
