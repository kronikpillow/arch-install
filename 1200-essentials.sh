#!/bin/bash

# Audio packages
audio_packages=(
  wireplumber
  pipewire-alsa
  pipewire-jack
  pipewire-pulse
  rtkit
  gst-libav
  gst-plugins-bad
  gst-plugins-base
  gst-plugins-good
  gst-plugins-ugly
  gst-plugin-pipewire
  gst-plugin-gtk
  gst-plugin-libcamera
  gstreamer
  gstreamer-vaapi
  libdvdcss
  noise-suppression-for-voice
  helvum
  pulsemixer
  lib32-pipewire
  lib32-pipewire-jack
  lib32-gst-plugins-base
  lib32-gst-plugins-base-libs
  lib32-gst-plugins-good
  lib32-gstreamer
)

# System and utility packages
system_utility_packages=(
  lf
  pacman-contrib
  pacutils
  inxi
  radeontop
  iotop
  schedtool
  usbutils
  lsof
  strace
  hdparm
  pigz
  pbzip2
  lrzip
  ncompress
  lzip
  quota-tools
  plocate
  expac
  atool
  cpio
  lhasa
  lzop
  p7zip
  unace
  unrar
  zip
  unzip
  lynx
  fd
  ripgrep
  autoconf-archive
  cmake
  jsoncpp
  rhash
)

# Media and productivity packages
media_productivity_packages=(
  wl-clipboard
  yt-dlp
  fzf
  bat
  socat
)
#  mpd
#  mpv
#  mpc
#  ncmpcpp
#  newsboat
#  xclip
#  xdotool
#  zathura
#  zathura-pdf-mupdf
#  poppler
#  mediainfo
#  task-spooler
#  moreutils
#  viewnior

# Install packages using arrays
sudo pacman -Sy --needed --noconfirm \
"${audio_packages[@]}" \
"${system_utility_packages[@]}" \
"${media_productivity_packages[@]}"
#"${file_management_packages[@]}" \
#"${tumbler_packages[@]}" \
