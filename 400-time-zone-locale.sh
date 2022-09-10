#!/bin/sh

echo "configuring time zone and locale"
ln -sf /usr/share/zoneinfo/Europe/Belgrade /etc/localtime
hwclock --systohc
cp /etc/locale.gen /etc/locale.gen.bak
sed -i '160 s/# *//' /etc/locale.gen
sed -i '177 s/# *//' /etc/locale.gen
sed -i '437 s/# *//' /etc/locale.gen
sed -i '438 s/# *//' /etc/locale.gen
locale-gen
touch /etc/locale.conf
grep -q "LANG=en_US.UTF-8" /etc/locale.conf || echo "LANG=en_US.UTF-8" >> /etc/locale.conf
grep -q "LC_COLLATE=C" /etc/locale.conf || echo "LC_COLLATE=C" >> /etc/locale.conf

printf "\e[1;32mDone! \e[0m"
