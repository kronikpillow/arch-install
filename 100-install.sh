#!/bin/bash
set -e

# Interactive prompts for variables
read -rp "Enter the disk to install to (e.g., /dev/sda): " disk
read -rp "Enter the desired hostname: " hostname
read -rp "Enter the desired username: " username
read -rsp "Enter the root password: " root_password
echo
read -rsp "Enter the password for $username: " user_password
echo

target="/mnt"

# Partition disk (assuming GPT partitioning)
echo -e "o\nY\nn\n\n\n+512M\nef00\nn\n\n\n\n\nw\nY\n" | gdisk "$disk"

# Format partitions
mkfs.fat -F32 "${disk}1"
mkfs.btrfs -f "${disk}2"

# Mount the filesystem
mount_flags="defaults,noatime,compress=zstd,ssd,discard=async,space_cache=v2,autodefrag"
mount -o "$mount_flags" --mkdir "${disk}2" $target

# Create required directories before subvolume creation
mkdir -p $target/@/{.snapshots/1,boot,usr,var/{lib/libvirt,cache/pacman}}

# Create Btrfs subvolumes
for subvol in @ @/.snapshots @/.snapshots/1/snapshot @/boot/grub @/root @/usr/local @/var/cache/pacman/pkg @/var/lib/{containers,flatpak,libvirt/images,machines,portables} @/var/log; do
  btrfs subvolume create "$target/$subvol"
done

# Set the default subvolume
btrfs subvolume set-default "$(btrfs subvolume list $target | grep "@/.snapshots/1/snapshot" | grep -oP '(?<=ID )[0-9]+')" $target

# Enable quotas
btrfs quota enable $target
btrfs qgroup create 1/0 $target

# Disable COW on specific subvolumes
for nocow in @/var/cache/pacman/pkg @/var/log @/var/lib/libvirt/images @/var/lib/containers; do
  chattr +C "$target/$nocow"
done

# Remount the default subvolume for installation
umount -R $target
sync
sleep 2
mount -o "$mount_flags" "${disk}2" $target

# Mount additional subvolumes
for subvol in .snapshots boot/grub root usr/local var/cache/pacman/pkg var/log var/lib/{containers,flatpak,libvirt/images,machines,portables}; do
  mount -o "$mount_flags",subvol=@/$subvol --mkdir "${disk}2" "$target/$subvol"
done

# Mount EFI partition separately
mount -o defaults,noatime --mkdir "${disk}1" $target/boot/EFI

# Pacstrap packages
pacstrap_packages=(
  # Base Packages
  base base-devel linux linux-headers linux-firmware btrfs-progs e2fsprogs xfsprogs f2fs-tools nilfs-utils jfsutils dosfstools mkinitcpio lvm2 mdadm cryptsetup device-mapper diffutils texinfo inetutils less logrotate man-db man-pages os-prober perl python s-nail sudo sysfsutils which chwd plymouth efibootmgr grub netctl lsb-release

  # X-System
  libwnck3 mesa-utils xf86-input-libinput xorg-xdpyinfo xorg-server xorg-xinit xorg-xinput xorg-xkill xorg-xrandr

  # Network
  dhclient dnsmasq dnsutils ethtool iwd modemmanager networkmanager networkmanager-openvpn nss-mdns usb_modeswitch wpa_supplicant wireless-regdb xl2tpd netctl openssh

  # Firewall
  iptables-nft firewalld

  # Bluetooth
  bluez bluez-hid2hci bluez-libs bluez-utils

  # Package Management
  pacman-contrib pkgfile rebuild-detector reflector expac rate-mirrors

  # Desktop Integration
  accountservice bash-completion xdg-user-dirs xdg-utils

  # Filesystem Tools
  fsarchiver usbutils mtools sg3_utils hdparm dmraid hwdetect lsscsi dmidecode smartmontools sof-firmware

  # Fonts
  adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts awesome-terminal-fonts noto-fonts-emoji noto-color-emoji noto-color-emoji-fontconfig cantarell-fonts freetype2 noto-fonts noto-fonts-cjk opendesktop-fonts ttf-bitstream-vera ttf-dejavu ttf-liberation ttf-opensans ttf-meslo-nerd

  # Audio
  alsa-firmware alsa-plugins alsa-utils pipewire-pulse pipewire-alsa wireplumber pavucontrol rtkit

  # Hardware
  cpupower power-profiles-daemon upower hwinfo

  # Some Applications
  bat eza fastfetch fish fzf tealdeer btop duf findutils git inxi plocate poppler-glib pv rsync sed unrar unzip xz ffmpegthumbnailer gst-libav gst-plugins-pipewire gst-plugins-bad gst-plugins-ugly libdvdcss libgsf libopenraw wget vi ripgrep vim python-defusedxml python-packaging haveged efitools nfs-utils ntp
)
pacstrap $target "${pacstrap_packages[@]}"

# Generate and modify fstab

# Configure makepkg
cat >$target/etc/makepkg.conf <<EOF
CFLAGS="-march=native -O2 -pipe"
CXXFLAGS="-march=native -O2 -pipe"
MAKEFLAGS="-j$(nproc)"
COMPRESSXZ=(xz -c -T $(nproc) -z -)
EOF

# Backup files before modifying
sed -i 's/PRUNENAMES = ".git .hg .svn"/PRUNENAMES = ".git .hg .svn .snapshots"/' $target/etc/updatedb.conf
for file in /etc/pacman.conf /etc/makepkg.conf /etc/locale.gen /etc/locale.conf /etc/hostname /etc/hosts /etc/fstab /etc/mkinitcpio.conf /etc/default/grub /etc/default/grub-btrfs/config; do
  [ -f "$target\$file" ] && cp "$target\$file" "$target\$file.bak"
done
genfstab -U $target >>$target/etc/fstab
cp $target/etc/fstab $target/etc/fstab.bak

# Create /etc/mkinitcpio.conf.d/btrfs.conf with necessary modules and hooks
mkdir -p /etc/mkinitcpio.conf.d
cat >/etc/mkinitcpio.conf.d/archlinux.conf <<EOF
MODULES=(btrfs amdgpu crc32c-intel)
BINARIES=(/usr/bin/btrfs)
FILES=()
HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block filesystems fsck grub-btrfs-overlayfs)
EOF

# Additional GPU, OpenCL, sysctl, modprobe, and environment config

# Install AMD graphics and 32-bit OpenCL support
pacstrap_packages+=(lib32-mesa lib32-vulkan-radeon mesa vulkan-radeon xf86-video-amdgpu)

# Create /etc/profile.d/opencl.sh
mkdir -p /etc/profile.d
cat >/etc/profile.d/opencl.sh <<EOF
export RUSTICL_ENABLE=radeonsi
EOF

# Create /etc/environment.d/30-opencl.conf
mkdir -p /etc/environment.d
cat >/etc/environment.d/30-opencl.conf <<EOF
RUSTICL_ENABLE=radeonsi
EOF

# Create /etc/modprobe.d/amdgpu.conf
mkdir -p /etc/modprobe.d
cat >/etc/modprobe.d/amdgpu.conf <<EOF
# Force using of the amdgpu driver for Southern Islands (GCN 1.0+) and Sea
# Islands (GCN 2.x) generations.
options amdgpu si_support=1 cik_support=1
options radeon si_support=0 cik_support=0
EOF

# Create /etc/modprobe.d/blacklist.conf
cat >/etc/modprobe.d/blacklist.conf <<EOF
# Blacklist the Intel TCO Watchdog/Timer module
blacklist iTCO_wdt

# Intel VPRO remote access technology driver.
blacklist mei
blacklist mei_me

# Blacklist the AMD SP5100 TCO Watchdog/Timer module (Required for Ryzen cpus)
blacklist sp5100_tco

# Prevent annoying beep from the pc speaker.
blacklist pcspkr

# needed for coga's webcam to work
blacklist option
EOF

# Create /etc/modules-load.d/ntsync.conf
mkdir -p /etc/modules-load.d
echo 'ntsync' >/etc/modules-load.d/ntsync.conf

# Create /etc/NetworkManager/conf.d/dns.conf
mkdir -p /etc/NetworkManager/conf.d
cat >/etc/NetworkManager/conf.d/dns.conf <<EOF
[main]
dns=systemd-resolved
EOF
systemctl enable systemd-resolved

# Create /etc/sddm.conf.d/10-general.conf
mkdir -p /etc/sddm.conf.d
cat >/etc/sddm.conf.d/10-general.conf <<EOF
[Autologin]
Relogin=false
Session=plasma

[General]
HaltCommand=/usr/bin/systemctl poweroff
InputMethod=qtvirtualkeyboard
Numlock=none
RebootCommand=/usr/bin/systemctl reboot

[Theme]
Current=breeze

[Users]
DefaultPath=/usr/local/sbin:/usr/local/bin:/usr/bin
HideShells=
HideUsers=
MaximumUid=60000
MinimumUid=1000
RememberLastSession=true
RememberLastUser=true
ReuseSession=false

[Wayland]
EnableHiDPI=true
SessionCommand=/usr/share/sddm/scripts/wayland-session
SessionDir=/usr/share/wayland-sessions
SessionLogFile=.local/share/sddm/wayland-session.log

[X11]
EnableHiDPI=true
MinimumVT=1
ServerArguments=-nolisten tcp
ServerPath=/usr/bin/X
SessionCommand=/usr/share/sddm/scripts/Xsession
SessionDir=/usr/share/xsessions
SessionLogFile=.local/share/sddm/xorg-session.log
UserAuthFile=.Xauthority
XauthPath=/usr/bin/xauth
XephyrPath=/usr/bin/Xephyr
EOF

# Create /etc/sddm.conf.d/30-zz-wayland.conf
cat >/etc/sddm.conf.d/30-zz-wayland.conf <<EOF
[General]
DisplayServer=wayland
GreeterEnvironment=QT_WAYLAND_SHELL_INTEGRATION=layer-shell

[Wayland]
CompositorCommand=kwin_wayland --drm --no-lockscreen --no-global-shortcuts --locale1
EOF

# Create /etc/sysctl.d/99-archlinux-settings.conf
mkdir -p /etc/sysctl.d
cat >/etc/sysctl.d/99-archlinux-settings.conf <<EOF
vm.swappiness = 100
vm.vfs_cache_pressure = 50
vm.dirty_bytes = 268435456
vm.page-cluster = 0
vm.dirty_background_bytes = 67108864
vm.dirty_writeback_centisecs = 1500
kernel.nmi_watchdog = 0
kernel.unprivileged_userns_clone = 1
kernel.printk = 3 3 3 3
kernel.kptr_restrict = 2
kernel.kexec_load_disabled = 1
net.core.netdev_max_backlog = 4096
fs.file-max = 2097152

# Create /etc/sysctl.d/99-bore-scheduler.conf
cat > /etc/sysctl.d/99-bore-scheduler.conf <<EOF
### Use only if you want to change the default values!
### For more information look here: https://github.com/firelzrd/bore-scheduler#readme

# sched_burst_cache_lifetime (range: 0 - 4294967295, default: 60000000)
#kernel.sched_burst_cache_lifetime = 60000000

# sched_burst_fork_atavistic (range: 0 - 3, default: 2)
#kernel.sched_burst_fork_atavistic = 2

# sched_burst_penalty_offset (range: 0 - 64, default: 22)
#kernel.sched_burst_penalty_offset = 22

# sched_burst_penalty_scale (range: 0 - 4095, default: 1280)
#kernel.sched_burst_penalty_scale = 1280

# sched_burst_smoothness_long  (range: 0 - 1, default: 1)
#kernel.sched_burst_smoothness_long  = 1

# sched_burst_smoothness_short (range: 0 - 1, default: 0)
#kernel.sched_burst_smoothness_short = 0

# sched_burst_exclude_kthreads (range: 0 - 1, default: 1)
#kernel.sched_burst_exclude_kthreads = 1
EOF

# Create /etc/tmpfiles.d/coredump.conf
mkdir -p /etc/tmpfiles.d
cat >/etc/tmpfiles.d/coredump.conf <<EOF
# Clear all coredumps that were created more than 3 days ago
d /var/lib/systemd/coredump 0755 root root 3d
EOF

# Create /etc/tmpfiles.d/disable-zswap.conf
cat >/etc/tmpfiles.d/disable-zswap.conf <<EOF
# We ship using ZRAM by default, and zswap may prevent it from working
# properly or keeping a proper count of compressed pages via zramctl
w! /sys/module/zswap/parameters/enabled - - - - N
EOF

# Create /etc/tmpfiles.d/thp-shrinker.conf
cat >/etc/tmpfiles.d/thp-shrinker.conf <<EOF
# THP Shrinker has been added in the 6.12 Kernel
# Default Value is 511
# THP=always policy vastly overprovisions THPs in sparsely accessed memory areas, resulting in excessive memory pressure and premature OOM killing
# 409 means that any THP that has more than 409 out of 512 (80%) zero filled filled pages will be split.
# This reduces the memory usage, when THP=always used and the memory usage goes down to around the same usage as when madvise is used, while still providing an equal performance improvement
w! /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none - - - - 409
EOF

# Create /etc/thp.conf
cat >/etc/thp.conf <<EOF
# Improve performance for applications that use tcmalloc
# https://github.com/google/tcmalloc/blob/master/docs/tuning.md#system-level-optimizations
w! /sys/kernel/mm/transparent_hugepage/defrag - - - - defer+madvise
EOF

# Create custom udev rules
mkdir -p /etc/udev/rules.d

cat >/etc/udev/rules.d/30-zram.rules <<EOF
SUBSYSTEM=="block", KERNEL=="zram0", ATTR{disksize}="512M"
RUN+="/usr/bin/bash -c 'echo 1 > /sys/block/zram0/comp_algorithm'"
RUN+="/usr/bin/bash -c 'echo lz4 > /sys/block/zram0/comp_algorithm'"
EOF

cat >/etc/udev/rules.d/40-hpet-permissions.rules <<EOF
KERNEL=="hpet", GROUP="wheel", MODE="0660"
EOF

cat >/etc/udev/rules.d/50-sata.rules <<EOF
ACTION=="add|change", SUBSYSTEM=="block", KERNEL=="sd[a-z]", ATTR{queue/scheduler}="mq-deadline"
EOF

cat >/etc/udev/rules.d/60-ioschedulers.rules <<EOF
ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/scheduler}="none"
EOF

cat >/etc/udev/rules.d/69-hdparm.rules <<EOF
ACTION=="add", SUBSYSTEM=="block", KERNEL=="sd[a-z]", RUN+="/usr/bin/hdparm -W1 /dev/%k"
EOF

cat >/etc/udev/rules.d/99-cpu-dma-latency.rules <<EOF
SUBSYSTEM=="misc", KERNEL=="cpu_dma_latency", TAG+="uaccess", GROUP="wheel", MODE="0660"
EOF

# Create /etc/journald.conf.d/00-journal-size.conf
mkdir -p /etc/journald.conf.d
cat >/etc/journald.conf.d/00-journal-size.conf <<EOF
[Journal]
SystemMaxUse=50M
EOF

# Create /etc/system/pci-latency.service
mkdir -p /etc/system

# Create /etc/system/rtkit-daemon.service.d/override.conf
mkdir -p /etc/system/rtkit-daemon.service.d
cat >/etc/system/rtkit-daemon.service.d/override.conf <<EOF
[Service]
LogLevelMax=info
EOF

# Create /etc/system/user@.service.d/delegate.conf
mkdir -p /etc/system/user@.service.d
cat >/etc/system/user@.service.d/delegate.conf <<EOF
[Service]
Delegate=cpu cpuset io memory pids
EOF

# Create /etc/system.conf.d/00-timeout.conf
mkdir -p /etc/system.conf.d
cat >/etc/system.conf.d/00-timeout.conf <<EOF
[Manager]
DefaultTimeoutStartSec=15s
DefaultTimeoutStopSec=10s
EOF

# Create /etc/system.conf.d/limits.conf
cat >/etc/system.conf.d/limits.conf <<EOF
[Manager]
DefaultLimitNOFILE=2048:2097152
EOF

# Create /etc/timesyncd.conf.d/timesyncd.conf
mkdir -p /etc/timesyncd.conf.d
cat >/etc/timesyncd.conf.d/timesyncd.conf <<EOF
[Time]
NTP=time.cloudflare.com
FallbackNTP=time.google.com 0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
#RootDistanceMaxSec=5
#PollIntervalMinSec=32
#PollIntervalMaxSec=2048
#ConnectionRetrySec=30
#SaveIntervalSec=60
EOF

# Create /etc/user.conf.d/limits.conf
mkdir -p /etc/user.conf.d
cat >/etc/user.conf.d/limits.conf <<EOF
[Manager]
DefaultLimitNOFILE=1024:1048576
EOF

# Create /etc/zram-generator.conf.d/zram-generator.conf
mkdir -p /etc/zram-generator.conf.d
cat >/etc/zram-generator.conf.d/zram-generator.conf <<EOF
[zram0] 
compression-algorithm = zstd lz4 (type=huge)
zram-size = ram
swap-priority = 100
fs-type = swap
EOF

# Create /usr/local/bin scripts
mkdir -p /usr/local/bin

cat >/usr/local/bin/game-performance <<EOF
#!/bin/bash
export WINE_FULLSCREEN_FSR=1
export WINE_FULLSCREEN_FSR_STRENGTH=5
export RADV_PERFTEST=gpl
export RADV_FORCE_FMA32=1
export VKD3D_CONFIG=dxr11
game="$1"
shift
$game "$@"
EOF

cat >/usr/local/bin/kerver <<EOF
#!/bin/bash
uname -r
EOF

cat >/usr/local/bin/sbctl-batch-sign <<EOF
#!/bin/bash
#!/bin/sh
find /boot -type f -name '*.efi' -exec sbctl sign {} \;
EOF

cat >/usr/local/bin/topmem <<EOF
#!/bin/bash
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 25
EOF

chmod +x /usr/local/bin/{game-performance,kerver,sbctl-batch-sign,topmem}

# Enable essential services

# Create /etc/zsh/zshenv to set ZDOTDIR
mkdir -p /etc/zsh
cat >/etc/zsh/zshenv <<EOF
ZDOTDIR="\${XDG_CONFIG_HOME:-\${HOME}/.config}/zsh"
EOF

# Create /etc/vconsole.conf
cat >/etc/vconsole.conf <<EOF
KEYMAP=us
XKBLAYOUT=us
XKBMODEL=pc86
XKBOPTIONS=terminate:ctrl_alt_bksp
EOF

# Create /etc/X11/xorg.conf.d/00-keyboard.conf
mkdir -p /etc/X11/xorg.conf.d
cat >/etc/X11/xorg.conf.d/00-keyboard.conf <<EOF
# Written by systemd-localed(8), read by systemd-localed and Xorg. It's
# probably wise not to edit this file manually. Use localectl(1) to
# update this file.
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us"
        Option "XkbModel" "pc86"
        Option "XkbOptions" "terminate:ctrl_alt_bksp"
EndSection
EOF

# Create /etc/X11/xorg.conf.d/20-touchpad.conf
cat >/etc/X11/xorg.conf.d/20-touchpad.conf <<EOF
Section "InputClass"
     Identifier "libinput touchpad catchall"
     MatchIsTouchpad "on"
     MatchDevicePath "/dev/input/event*"
     Driver "libinput"
     Option "Tapping" "True"
EndSection
EOF
systemctl enable NetworkManager
systemctl enable avahi-daemon
systemctl enable systemd-timesyncd
systemctl enable firewalld
systemctl enable bluetooth
systemctl enable fcron
systemctl enable dbus-broker
systemctl enable snapper-timeline.timer
systemctl enable snapper-cleanup.timer
