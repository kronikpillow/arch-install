#!/bin/sh
echo "configuring pacman settings"

if [ ! -f /etc/pacman.conf.bak ];
then cp /etc/pacman.conf /etc/pacman.conf.bak && echo "/etc/pacman.conf backed up";
else echo "/etc/pacman.conf already backed up";
fi

grep -q "ILoveCandy" /etc/pacman.conf || sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
sed -i "17 s/# *//;
s/^#Color$/Color/;
s/^#VerbosePkgLists$/VerbosePkgLists/;
s/^#ParallelDownloads = 5$/ParallelDownloads = 5/;
91 s/# *//;
92 s/# *//;" /etc/pacman.conf

mkdir -pv /etc/pacman.d/hooks
#cp -r etc/pacman.d/hooks/* /etc/pacman.d/hooks/

echo "configuring reflector settings"
if [ ! -f /etc/pacman.d/mirrorlist.bak ];
then cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak && echo "/etc/pacman.d/mirrorlist backed up";
else echo "/etc/pacman.d/mirrorlist already backed up";
fi

if [ ! -f /etc/xdg/reflector/reflector.conf.bak ];
then cp /etc/xdg/reflector/reflector.conf /etc/xdg/reflector/reflector.conf.bak && echo "/etc/xdg/reflector/reflector.conf backed up";
else echo "/etc/xdg/reflector/reflector.conf already backed up";
fi

sed -i '24 c\--latest 25' /etc/xdg/reflector/reflector.conf
sed -i '27 c\--sort rate' /etc/xdg/reflector/reflector.conf

echo "configuring makepkg settings"
if [ ! -f /etc/makepkg.conf.bak ];
then cp /etc/makepkg.conf /etc/makepkg.conf.bak && echo "/etc/makepkg.conf backed up";
else echo "/etc/makepkg.conf already backed up";
fi

sed -i '49 c\MAKEFLAGS="-j4"' /etc/makepkg.conf
sed -i '137 c\COMPRESSGZ=(pigz -c -f -n)' /etc/makepkg.conf
sed -i '138 c\COMPRESSBZ2=(pbzip2 -c -f)' /etc/makepkg.conf
sed -i '139 c\COMPRESSXZ=(xz -c -z --threads=0 -)' /etc/makepkg.conf
sed -i '140 c\COMPRESSZST=(zstd -c -z -q --threads=0 -)' /etc/makepkg.conf

printf "\e[1;32mDone! \e[0m"
