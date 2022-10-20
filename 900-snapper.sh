#!/bin/sh

echo "fixing .snapshots subvolume permissions"

umount /.snapshots
rm -r /.snapshots

umount /home/.snapshots
rm -r /home/.snapshots

snapper -c root create-config /
btrfs subvolume delete /.snapshots

snapper -c home create-config /home/
btrfs subvolume delete /home/.snapshots

mkdir /.snapshots
chmod 750 /.snapshots

mkdir /home/.snapshots
chmod 750 /home/.snapshots

mount -a

chmod a+rx /.snapshots
chown :wheel /.snapshots

chmod a+rx /home/.snapshots
chown :wheel /home/.snapshots

sed -i '22 c\ALLOW_GROUPS="wheel"' /etc/snapper/configs/root
sed -i '51 c\TIMELINE_LIMIT_HOURLY="6"' /etc/snapper/configs/root
sed -i '52 c\TIMELINE_LIMIT_DAILY="4"' /etc/snapper/configs/root
sed -i '53 c\TIMELINE_LIMIT_WEEKLY="2"' /etc/snapper/configs/root
sed -i '54 c\TIMELINE_LIMIT_MONTHLY="1"' /etc/snapper/configs/root
sed -i '55 c\TIMELINE_LIMIT_YEARLY="0"' /etc/snapper/configs/root

sed -i '22 c\ALLOW_GROUPS="wheel"' /etc/snapper/configs/home
sed -i '51 c\TIMELINE_LIMIT_HOURLY="6"' /etc/snapper/configs/home
sed -i '52 c\TIMELINE_LIMIT_DAILY="4"' /etc/snapper/configs/home
sed -i '53 c\TIMELINE_LIMIT_WEEKLY="2"' /etc/snapper/configs/home
sed -i '54 c\TIMELINE_LIMIT_MONTHLY="1"' /etc/snapper/configs/home
sed -i '55 c\TIMELINE_LIMIT_YEARLY="0"' /etc/snapper/configs/home

rm /etc/cron.hourly/snapper
rm /etc/cron.daily/snapper
