#!/bin/sh
echo "configuring network settings"

touch /etc/hostname

grep -q "susanoo" /etc/hostname || echo "susanoo" >> /etc/hostname
grep -q "127.0.0.1 localhost" /etc/hosts || echo "127.0.0.1 localhost" >> /etc/hosts
grep -q "::1       localhost" /etc/hosts || echo "::1       localhost" >> /etc/hosts
grep -q "127.0.1.1 susanoo" /etc/hosts || echo "127.0.1.1 susanoo" >> /etc/hosts

if [ ! -f /etc/hostname.bak ];
then cp /etc/hostname /etc/hostname.bak && echo "/etc/hostname backed up";
else echo "/etc/hostname already backed up";
fi

systemctl enable NetworkManager
printf "\e[1;32mDone! \e[0m"
