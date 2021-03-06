#!/bin/sh
echo "configuring pacman settings"
cp /etc/pacman.conf /etc/pacman.conf.bak
cp /etc/makepkg.conf /etc/makepkg.conf.bak
grep -q "ILoveCandy" /etc/pacman.conf || sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
sed -i "17 s/# *//;
s/^#Color$/Color/;
s/^#VerbosePkgLists$/VerbosePkgLists/;
s/^#ParallelDownloads = 5$/ParallelDownloads = 5/;
94 s/# *//;
95 s/# *//;" /etc/pacman.conf
mkdir -pv /etc/pacman.d/hooks

printf "\e[1;32mDone! \e[0m"
