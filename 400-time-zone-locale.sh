#!/bin/sh

echo "configuring time zone and locale"
ln -sf /usr/share/zoneinfo/Europe/Belgrade /etc/localtime
hwclock --systohc

if [ ! -f /etc/locale.gen.bak ];
then cp /etc/locale.gen /etc/locale.gen.bak && echo "locale.gen backed up to /etc/locale.gen.bak";
else echo "locale.gen already backed up";
fi

sed -i '154 s/# *//' /etc/locale.gen
sed -i '171 s/# *//' /etc/locale.gen
sed -i '431 s/# *//' /etc/locale.gen
sed -i '432 s/# *//' /etc/locale.gen

locale-gen

touch /etc/locale.conf

grep -q "LANG=en_US.UTF-8" /etc/locale.conf || echo "LANG=en_US.UTF-8" >> /etc/locale.conf
grep -q "LC_TIME=en_GB.UTF-8" /etc/locale.conf || echo "LC_TIME=en_GB.UTF-8" >> /etc/locale.conf
grep -q "LC_COLLATE=C" /etc/locale.conf || echo "LC_COLLATE=C" >> /etc/locale.conf

printf "\e[1;32mDone! \e[0m"
