#!/bin/sh

systemctl enable fstrim.timer
systemctl start fstrim.timer
systemctl enable NetworkManager.service
systemctl start NetworkManager.service
systemctl enable cronie.service
systemctl start cronie.service
systemctl enable snapper-cleanup.timer
systemctl start snapper-cleanup.timer
systemctl enable grub-btrfs.path
systemctl start grub-btrfs.path
systemctl enable powertune.service
systemctl start powertune.service
