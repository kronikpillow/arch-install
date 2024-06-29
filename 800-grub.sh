#!/bin/bash
printf "\e[1;34m%s\e[0m\n" "configuring grub settings & backing up default configs"

backup_files=("/etc/default/grub" "/etc/default/grub-btrfs/config")

for file in "${backup_files[@]}"; do
	if [ ! -f "$file.bak" ]; then
		cp "$file" "$file.bak" && printf "\e[1;33m%s backed up\e[0m\n" "$file"
	else
		printf "\e[1;33m%s already backed up\e[0m\n" "$file"
	fi
done

sed -i -e "7 c\GRUB_CMDLINE_LINUX=\"nowatchdog zswap.enabled=0 rootfstype=btrfs\";" \
	-e "10 c\GRUB_PRELOAD_MODULES=\"part_gpt part_msdos btrfs\";" \
	-e "s/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/" /etc/default/grub

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --disable-shim-lock
# grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --disable-shim-lock --modules="normal test efi_gop efi_uga search echo linux all_video gfxmenu gfxterm_background gfxterm_menu gfxterm loadenv configfile gzio part_gpt btrfs"
grub-mkconfig -o /boot/grub/grub.cfg

printf "\e[1;32m%s\e[0m\n" "Done!"
