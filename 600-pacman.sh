#!/bin/sh
echo "configuring pacman settings"

if [ ! -f /etc/pacman.conf.bak ];
then cp /etc/pacman.conf /etc/pacman.conf.bak && echo "/etc/pacman.conf backed up";
else echo "/etc/pacman.conf already backed up";
fi

if [ ! -f /etc/xdg/reflector/reflector.conf.bak ];
then cp /etc/xdg/reflector/reflector.conf /etc/reflector/reflector.conf.bak && echo "/etc/reflector/reflector.conf backed up";
else echo "/etc/reflector/reflector.conf already backed up";
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
