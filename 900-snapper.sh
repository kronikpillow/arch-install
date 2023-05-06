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
printf "\e[1;32mDone! \e[0m"

echo "configuring root snapper config"
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
printf "\e[1;32mDone! \e[0m"

#echo "configuring home snapper config"
#sed -i '10 c\QGROUP="2/0"' /etc/snapper/configs/home
#sed -i '22 c\ALLOW_GROUPS="wheel"' /etc/snapper/configs/home
#sed -i '39 c\NUMBER_LIMIT="2-10"' /etc/snapper/configs/home
#sed -i '40 c\NUMBER_LIMIT_IMPORTANT="4-10"' /etc/snapper/configs/home
#sed -i '44 c\TIMELINE_CREATE="no"' /etc/snapper/configs/home
#sed -i '51 c\TIMELINE_LIMIT_HOURLY="10"' /etc/snapper/configs/home
#sed -i '52 c\TIMELINE_LIMIT_DAILY="10"' /etc/snapper/configs/home
#sed -i '53 c\TIMELINE_LIMIT_WEEKLY="0"' /etc/snapper/configs/home
#sed -i '54 c\TIMELINE_LIMIT_MONTHLY="10"' /etc/snapper/configs/home
#sed -i '55 c\TIMELINE_LIMIT_YEARLY="10"' /etc/snapper/configs/home
#printf "\e[1;32mDone! \e[0m"

#rm /etc/cron.hourly/snapper
#rm /etc/cron.daily/snapper

echo "configuring mlocate to exclude snapshots from updatedb"
if [ ! -f /etc/updatedb.conf.bak ];
then cp /etc/updatedb.conf /etc/updatedb.conf.bak && echo "/etc/updatedb.conf backed up";
else echo "/etc/reflector/reflector.conf already backed up";
fi

sed -i '3 c\PRUNENAMES = ".git .hg .svn .snapshots"' /etc/updatedb.conf

printf "\e[1;32mDone! \e[0m"
