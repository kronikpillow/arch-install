#!/bin/sh
cp -r etc/docker /etc/
cp -r etc/polkit-1/* /etc/polkit-1/
cp -r etc/sudoers.d/* /etc/sudoers.d/
cp -r etc/sysctl.d/* /etc/sysctl.d/
cp -r etc/systemd/* /etc/systemd/
chmod +x usr/local/bin/powertune
cp -r usr/* /usr/

timedatectl set-timezone Europe/Belgrade
timedatectl set-ntp true

systemctl enable dbus-broker.service
systemctl start dbus-broker.service

systemctl enable rtkit-daemon.service
systemctl start rtkit-daemon.service

systemctl enable cronie.service
systemctl start cronie.service

systemctl enable grub-btrfsd.service
systemctl start grub-btrfsd.service

# systemctl enable fstrim.timer
# systemctl start fstrim.timer

systemctl enable pkgfile-update.timer
systemctl start pkgfile-update.timer

systemctl enable reflector.timer
systemctl start reflector.timer
systemctl start reflector.service

systemctl enable powertune.service
systemctl start powertune.service

# systemctl enable avahi-daemon.service
# systemctl start avahi-daemon.service

systemctl enable firewalld.service
systemctl start firewalld.service
firewall-cmd --set-default-zone=home
# firewall-cmd --add-port=1025-65535/tcp --permanent
# firewall-cmd --add-port=1025-65535/udp --permanent
firewall-cmd --reload

# systemctl enable snapper-timeline.timer
# systemctl start snapper-timeline.timer

# systemctl enable snapper-cleanup.timer
# systemctl start snapper-cleanup.timer
