## create these subvolumes as the user
sudo chown -R kronikpillow:wheel /mnt/ssd/data/_cache
sudo chown -R kronikpillow:wheel /mnt/ssd/data/_gnupg
sudo chown -R kronikpillow:wheel /mnt/ssd/data/_local
sudo chown -R kronikpillow:wheel /mnt/ssd/data/_pki
sudo chown -R kronikpillow:wheel /mnt/ssd/data/_ssh
sudo chown -R kronikpillow:wheel /mnt/ssd/data/abook
sudo chown -R kronikpillow:wheel /mnt/ssd/data/BraveSoftware
sudo chown -R kronikpillow:wheel /mnt/ssd/data/discord
sudo chown -R kronikpillow:wheel /mnt/ssd/data/Popcorn-Time

sudo chown -R kronikpillow:wheel /mnt/hdd-cow/data/dox
sudo chown -R kronikpillow:wheel /mnt/hdd-cow/data/dwl
sudo chown -R kronikpillow:wheel /mnt/hdd-cow/data/muz
sudo chown -R kronikpillow:wheel /mnt/hdd-cow/data/pix
sudo chown -R kronikpillow:wheel /mnt/hdd-cow/data/pro
sudo chown -R kronikpillow:wheel /mnt/hdd-cow/data/vid

sudo chown -R kronikpillow:wheel /mnt/hdd-nocow/data/_var
sudo chown -R kronikpillow:wheel /mnt/hdd-nocow/data/transmission-daemon
sudo chown -R kronikpillow:wheel /mnt/hdd-nocow/data/trt

#
# cp -rp --reflink=always /mnt/ssd/home/kronikpillow/.cache/* /mnt/ssd/data/_cache/
# cp -rp --reflink=always /mnt/ssd/home/kronikpillow/.local/* /mnt/ssd/data/_local/
# cp -rp --reflink=always /mnt/ssd/home/kronikpillow/.gnupg/* /mnt/ssd/data/_gnupg/
# cp -rp --reflink=always /mnt/ssd/home/kronikpillow/.ssh/* /mnt/ssd/data/_ssh/
# cp -rp --reflink=always /mnt/ssd/home/kronikpillow/.config/BraveBrowser /mnt/ssd/data/BraveBrowser/
