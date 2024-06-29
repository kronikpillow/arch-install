#!/bin/sh

SNAPSHOT_DIR=/.snapshots
UPDATEDB_CONF=/etc/updatedb.conf
SNAPPER_CONFIG=/etc/snapper/configs/root

# Fixing .snapshots subvolume permissions
fix_snapshots_permissions()
{
	printf "\e[1;34m%s\e[0m\n" "fixing .snapshots subvolume permissions"
	umount "$SNAPSHOT_DIR"
	rm -r "$SNAPSHOT_DIR"

	snapper --no-dbus -c root create-config /
	btrfs subvolume delete "$SNAPSHOT_DIR"

	mkdir -p "$SNAPSHOT_DIR"
	mount -a

	chmod 750 "$SNAPSHOT_DIR"
	chmod a+rx "$SNAPSHOT_DIR"
	chown :wheel "$SNAPSHOT_DIR"

	printf "\e[1;32m%s\e[0m\n" "Done!"
}

# Configuring root snapper config
configure_snapper()
{
	printf "\e[1;34m%s\e[0m\n" "configuring root snapper config"
	sed -i -e '10s/.*/QGROUP="1\/0"/' \
		-e '22s/.*/ALLOW_GROUPS="wheel"/' \
		-e '39s/.*/NUMBER_LIMIT="2-10"/' \
		-e '40s/.*/NUMBER_LIMIT_IMPORTANT="4-10"/' \
		-e '44s/.*/TIMELINE_CREATE="no"/' \
		-e '51s/.*/TIMELINE_LIMIT_HOURLY="10"/' \
		-e '52s/.*/TIMELINE_LIMIT_DAILY="10"/' \
		-e '53s/.*/TIMELINE_LIMIT_WEEKLY="0"/' \
		-e '54s/.*/TIMELINE_LIMIT_MONTHLY="10"/' \
		-e '55s/.*/TIMELINE_LIMIT_YEARLY="10"/' "$SNAPPER_CONFIG"

	printf "\e[1;32m%s\e[0m\n" "Done!"
}

# Configuring mlocate to exclude snapshots from updatedb
configure_mlocate()
{
	printf "\e[1;34m%s\e[0m\n" "configuring mlocate to exclude snapshots from updatedb"
	if [ ! -f "$UPDATEDB_CONF".bak ]; then
		cp "$UPDATEDB_CONF" "$UPDATEDB_CONF".bak && printf "\e[1;36m%s\e[0m\n" "$UPDATEDB_CONF backed up"
	else
		printf "\e[1;36m%s\e[0m\n" "$UPDATEDB_CONF already backed up"
	fi

	sed -i '3s/.*/PRUNENAMES = ".git .hg .svn .snapshots"/' "$UPDATEDB_CONF"

	printf "\e[1;32m%s\e[0m\n" "Done!"
}

fix_snapshots_permissions
configure_snapper
configure_mlocate
