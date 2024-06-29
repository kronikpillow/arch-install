#!/bin/sh

SNAPSHOT_DIR=/home/kronikpillow/.snapshots

# Fixing .snapshots subvolume permissions
fix_snapshots_permissions()
{
	printf "\e[1;34m%s\e[0m\n" "fixing .snapshots subvolume permissions"

	snapper --no-dbus -c home create-config /home/kronikpillow

	chmod 750 "$SNAPSHOT_DIR"
	chmod a+rx "$SNAPSHOT_DIR"
	chown :wheel "$SNAPSHOT_DIR"

	printf "\e[1;32m%s\e[0m\n" "Done!"
}

fix_snapshots_permissions
