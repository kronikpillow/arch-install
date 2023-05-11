#!/bin/sh
echo "configuring network settings"

touch /etc/hostname

grep -q "susanoo" /etc/hostname || echo "susanoo" >> /etc/hostname

if [ ! -f /etc/hostname.bak ];
then cp /etc/hostname /etc/hostname.bak && echo "/etc/hostname backed up";
else echo "/etc/hostname already backed up";
fi

grep -q "127.0.0.1 localhost" /etc/hosts || echo "127.0.0.1 localhost" >> /etc/hosts
grep -q "::1       localhost" /etc/hosts || echo "::1       localhost" >> /etc/hosts
grep -q "127.0.1.1 susanoo" /etc/hosts || echo "127.0.1.1 susanoo" >> /etc/hosts

if [ ! -f /etc/hosts.bak ];
then cp /etc/hosts /etc/hosts.bak && echo "/etc/hosts backed up";
else echo "/etc/hosts already backed up";
fi

cp -r etc/NetworkManager/conf.d/* /etc/NetworkManager/conf.d

systemctl enable NetworkManager

printf "\e[1;32mDone! \e[0m"
