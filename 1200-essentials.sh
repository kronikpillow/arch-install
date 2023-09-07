
### audio
sudo pacman -Syy --needed alsa-firmware \
alsa-plugins \
alsa-utils \
wireplumber \
pipewire-alsa \
pipewire-jack \
pipewire-pulse \
rtkit

sudo pacman -Syy --needed gst-libav \
gst-plugins-bad \
gst-plugins-base \
gst-plugins-good \
gst-plugins-ugly \
gst-plugin-pipewire \
gst-plugin-gtk \
gst-plugin-libcamera \
gstreamer \
gstreamer-vaapi \
libdvdcss \
noise-suppression-for-voice \
helvum \
pavucontrol \
pulsemixer \

sudo pacman -Syy --needed --noconfirm lib32-pipewire \
 lib32-pipewire-jack \
 lib32-gst-plugins-base \
 lib32-gst-plugins-base-libs \
 lib32-gst-plugins-good \
 lib32-gstreamer

### file management
sudo pacman -Syy --needed gvfs \
gvfs-afc \
gvfs-gphoto2 \
gvfs-mtp \
gvfs-nfs \
gvfs-smb \
xdg-user-dirs-gtk
mtpfs \
# udisks2 \
# udiskie \

# ## printers
# yay -Sy --needed cups \
#   cups-filters \
#   cups-pdf \
#   ghostscript \
#   gsfonts \
#   gutenprint \
#   system-config-printer

### tumbler
sudo pacman -Syy --needed tumbler \
ffmpegthumbnailer \
freetype2 \
libgsf \
libopenraw \
poppler-glib \
poppler-qt5

sudo pacman -Sy --needed lf \
  pacman-contrib \
  pacutils \
  inxi \
  radeontop \
  iotop \
  schedtool \
  usbutils \
  lsof \
  strace \
  hdparm \
  pigz \
  pbzip2 \
  lrzip \
  ncompress \
  lzip \
  quota-tools \
  plocate \
  expac \
  atool \
  cpio \
  lhasa \
  lzop \
  p7zip \
  unace \
  unrar \
  zip \
  unzip \
  lynx \
  fd \
  ripgrep \
  autoconf-archive \
  cmake \
  jsoncpp \
  rhash
  # powertop \
  # linux-tools \

pacman -Sy --noconfirm mpd \
  mpv \
  mpc \
  ncmpcpp \
  newsboat \
  xclip \
  wl-clipboard \
  xdotool \
  yt-dlp \
  zathura \
  zathura-pdf-mupdf \
  poppler \
  mediainfo \
  fzf \
  bat \
  task-spooler \
  socat \
  moreutils \
  viewnior
