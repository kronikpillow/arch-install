#!/bin/sh

echo "fixing .snapshots subvolume permissions"

umount /.snapshots
rm -r /.snapshots

umount /home/.snapshots
rm -r /home/.snapshots

snapper -c arch create-config /
snapper -c home create-config /home/

btrfs subvolume delete /.snapshots
btrfs subvolume delete /home/.snapshots

mkdir /.snapshots
mkdir /home/.snapshots

chmod 750 /.snapshots
chmod 750 /home/.snapshots

mount -a

chmod a+rx /.snapshots
chown :wheel /.snapshots
chmod a+rx /home/.snapshots
chown :wheel /home/.snapshots


sed -i '22 c\ALLOW_GROUPS="wheel"' /etc/snapper/configs/arch
sed -i '51 c\TIMELINE_LIMIT_HOURLY="6"' /etc/snapper/configs/arch
sed -i '52 c\TIMELINE_LIMIT_DAILY="5"' /etc/snapper/configs/arch
sed -i '53 c\TIMELINE_LIMIT_WEEKLY="2"' /etc/snapper/configs/arch
sed -i '54 c\TIMELINE_LIMIT_MONTHLY="1"' /etc/snapper/configs/arch
sed -i '55 c\TIMELINE_LIMIT_YEARLY="0"' /etc/snapper/configs/arch

sed -i '22 c\ALLOW_GROUPS="wheel"' /etc/snapper/configs/home
sed -i '51 c\TIMELINE_LIMIT_HOURLY="6"' /etc/snapper/configs/home
sed -i '52 c\TIMELINE_LIMIT_DAILY="5"' /etc/snapper/configs/home
sed -i '53 c\TIMELINE_LIMIT_WEEKLY="2"' /etc/snapper/configs/home
sed -i '54 c\TIMELINE_LIMIT_MONTHLY="1"' /etc/snapper/configs/home
sed -i '55 c\TIMELINE_LIMIT_YEARLY="0"' /etc/snapper/configs/home
