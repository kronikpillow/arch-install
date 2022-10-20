#!/bin/sh
echo "configuring pacman settings"

if [ ! -f /etc/pacman.conf.bak ]; 
then cp /etc/pacman.conf /etc/pacman.conf.bak && echo "pacman.conf backed up to /etc/pacman.conf.bak";
else echo "pacman.conf already backed up";
fi

if [ ! -f /etc/makepkg.conf.bak ]; 
then cp /etc/makepkg.conf /etc/makepkg.conf.bak && echo "makepkg.conf backed up to /etc/pacman.conf.bak";
else echo "makepkg.conf already backed up";
fi

grep -q "ILoveCandy" /etc/pacman.conf || sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
sed -i "17 s/# *//;
s/^#Color$/Color/;
s/^#VerbosePkgLists$/VerbosePkgLists/;
s/^#ParallelDownloads = 5$/ParallelDownloads = 5/;
94 s/# *//;
95 s/# *//;" /etc/pacman.conf
mkdir -pv /etc/pacman.d/hooks
cp -r etc/pacman.d/hooks/* /etc/pacman.d/hooks/

printf "\e[1;32mDone! \e[0m"
