#!/bin/sh

echo "fixing .snapshots subvolume permissions"
umount /.snapshots
rm -r /.snapshots

#umount /home/.snapshots
#rm -r /home/.snapshots

snapper --no-dbus -c root create-config /
btrfs subvolume delete /.snapshots

#snapper -c home create-config /home/
#btrfs subvolume delete /home/.snapshots

mkdir /.snapshots

#mkdir /home/.snapshots
#chmod 750 /home/.snapshots

mount -a

chmod 750 /.snapshots
chmod a+rx /.snapshots
chown :wheel /.snapshots

#chmod a+rx /home/.snapshots
#chown :wheel /home/.snapshots

sed -i '10 c\QGROUP="1/0"' /etc/snapper/configs/root
sed -i '22 c\ALLOW_GROUPS="wheel"' /etc/snapper/configs/root
sed -i '39 c\NUMBER_LIMIT="2-10"' /etc/snapper/configs/root
sed -i '40 c\NUMBER_LIMIT_IMPORTANT="4-10"' /etc/snapper/configs/root
sed -i '44 c\TIMELINE_CREATE="no"' /etc/snapper/configs/root
sed -i '51 c\TIMELINE_LIMIT_HOURLY="10"' /etc/snapper/configs/root
sed -i '52 c\TIMELINE_LIMIT_DAILY="10"' /etc/snapper/configs/root
sed -i '53 c\TIMELINE_LIMIT_WEEKLY="0"' /etc/snapper/configs/root
sed -i '54 c\TIMELINE_LIMIT_MONTHLY="10"' /etc/snapper/configs/root
sed -i '55 c\TIMELINE_LIMIT_YEARLY="10"' /etc/snapper/configs/root

#sed -i '22 c\ALLOW_GROUPS="wheel"' /etc/snapper/configs/home
#sed -i '51 c\TIMELINE_LIMIT_HOURLY="6"' /etc/snapper/configs/home
#sed -i '52 c\TIMELINE_LIMIT_DAILY="4"' /etc/snapper/configs/home
#sed -i '53 c\TIMELINE_LIMIT_WEEKLY="2"' /etc/snapper/configs/home
#sed -i '54 c\TIMELINE_LIMIT_MONTHLY="1"' /etc/snapper/configs/home
#sed -i '55 c\TIMELINE_LIMIT_YEARLY="0"' /etc/snapper/configs/home

#rm /etc/cron.hourly/snapper
#rm /etc/cron.daily/snapper
