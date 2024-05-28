#!/bin/sh

echo "configuring time zone and locale"
ln -sf /usr/share/zoneinfo/Europe/Belgrade /etc/localtime
hwclock --systohc

if [ ! -f /etc/locale.gen.bak ];
then cp /etc/locale.gen /etc/locale.gen.bak && echo "/etc/locale.gen backed up";
else echo "/etc/locale.gen already backed up";
fi

sed -i '154 s/# *//' /etc/locale.gen
sed -i '171 s/# *//' /etc/locale.gen
sed -i '433 s/# *//' /etc/locale.gen
sed -i '434 s/# *//' /etc/locale.gen

locale-gen

touch /etc/locale.conf

grep -q "LANG=en_US.UTF-8" /etc/locale.conf || echo "LANG=en_US.UTF-8" >> /etc/locale.conf
grep -q "LC_COLLATE=C" /etc/locale.conf || echo "LC_COLLATE=C" >> /etc/locale.conf
grep -q "LC_TIME=sr_RS@latin" /etc/locale.conf || echo "LC_TIME=sr_RS@latin" >> /etc/locale.conf

if [ ! -f /etc/locale.conf.bak ];
then cp /etc/locale.conf /etc/locale.conf.bak && echo "/etc/locale.conf backed up";
else echo "/etc/locale.conf already backed up";
fi

printf "\e[1;32mDone! \e[0m"
