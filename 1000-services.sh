#!/bin/sh

timedatectl set-timezone Europe/Belgrade
timedatectl set-ntp true

systemctl enable fcron.service
systemctl start fcron.service

systemctl enable grub-btrfsd.service
systemctl start grub-btrfsd.service

systemctl enable avahi-daemon.service
systemctl start avahi-daemon.service

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
