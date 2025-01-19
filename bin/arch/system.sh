#!/bin/bash

# Guide: https://wiki.archlinux.org/title/Installation_guide

# 1. Burn live ISO to USB
dd bs=4M if=<path/to/archlinux-version-x86_64.iso> of=</dev/sdx> conv=fsync oflag=direct status=progress

# 2. Stop annoying beeping (if there) : https://wiki.archlinux.org/title/PC_speaker
rmmod pcspkr

# 3. Connect to WiFi : https://wiki.archlinux.org/title/Iwd#iwctl
iwctl
[iwd] device list
[iwd] station <device_name> get-networks
[iwd] station <device_name> connect <network_name>

# 4. Update the system clock
timedatectl set-ntp true

# 5. List and partition disks
#
# Example layout:
#
# /dev/sdx1 : partition for booting
# - size: 512M
# - type: EFI System
#
# /dev/sdx2 : Arch OS partition
# - size: remaining
# - type: Linux Filesystem
fdisk -l /dev/sdx
# Note: `cfdisk` is much easier to use
cfdisk /dev/sdx

# 6. Format the partitions
mkfs.fat -F32 /dev/sdx1
mkfs.ext4 /dev/sdx2

# 7. Mount partitions:
mount /dev/sdx2 /mnt
mount --mkdir /dev/sdx1 /mnt/boot

# 8. Edit pacman's mirrorlist : /etc/pacman.d/mirrorlist
pacman -Syy archlinux-keyring
pacman -Sy reflector
reflector --latest 6 --sort rate --download-timeout 100 --save /etc/pacman.d/mirrorlist 

# 9. Install essential packages
pacstrap -K /mnt base linux linux-firmware

# 10. Generate the fstab file
genfstab -U /mnt > /mnt/etc/fstab

# 11. Change root
arch-chroot /mnt

# 11.2 Clone dotfiles repo in /root/dotfiles
pacman -Syu git
git clone https://github.com/teonnik/dotfiles.git /root/dotfiles

# 12. Install all pacman packages:

# 13. Time zone
ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
hwclock --systohc

# 14. Localization
sed -i '/en_US.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# 15. Network
echo "teonnik" >> /etc/hostname
echo "127.0.1.1 teonnik.localdomain teonnik" >> /etc/hosts

# 16. Bootloader (!! in arch chroot) : systemd-boot
# 
bootctl install
# TODO: Copy required configuration files: https://wiki.archlinux.org/title/systemd-boot#Configuration

# 17. Set pacman's Color option
sed -i '/Color/s/^#//g' /etc/pacman.conf

# 18. Set the root password
passwd

# 19. Add a user
useradd -m -G wheel,video,docker -s /usr/bin/zsh teonnik
passwd teonnik

# 20. Edit /etc/sudoers to allow for the wheel group
visudo /etc/sudoers

# 21. Enable services
systemctl enable NetworkManager.service \
                 bluetooth.service \
                 cups.service \
                 avahi-daemon \
                 atd.service \
                 docker.service \
                 pcscd.service \
                 ly.service \
                 systemd-boot-update.service

# 22. Reboot and login as user `teonnik`
reboot

# teonnik ---------------------------------------------------------

# Connect to network
nmtui

# Sync clock
timedatectl set-ntp true

# Enable user services
systemctl --user enable xdg-desktop-portal.service \
                        syncthing.service \
                        #pipewire.service
                        #pipewire-pulse.service
                        #pipewire.socket
                        #wireplumber.service



# 1. Chromium extensions - uBlock Origin, LastPass, BypassPaywalls, PrivacyBadger
#   - set the downloads folder to `downloads`
#   - save sessions : Settings > On startup > Continue where you left off
#   - Settings > Appearance > Mode > Dark
#   - Settings > Appearance > "Use system title bar and borders"

# 2. Syncthing
#
# - Open the GUI with chromium at 127.0.0.1:8384 (man syncthing-faq)
# - Delete the default directory "Sync"
rm -rf ~/Sync

# 3. ssh keys
ssh-keygen -t ed25519 -C "teodor.nikolov22@gmail.com"
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@remote_server
# TODO: `ssh-add` to add default key to `ssh-agent`

# 4. Create local folders
mkdir -p ~/code ~/build ~/downloads ~/bin

# 5. dotfiles in $HOME directory
git init
git remote add origin https://github.com/teonnik/dotfiles.git
git config status.showUntrackedFiles no
git fetch
git checkout -f master

# 6. AUR package manager
git clone https://aur.archlinux.org/yay.git ~/code/yay
(cd ~/code/yay; makepkg -si)

# 7. Install all my AUR packages: ~/config/arch/my_aur_packages.txt

# 8. Install spack
git clone https://github.com/spack/spack.git ~/code/spack

# 9. neovim
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/keymap/bulgarian-phonetic.vim --create-dirs http://www.math.bas.bg/bantchev/vim/bulgarian-phonetic.vim

# zsh config directory and history file
mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}"/zsh && touch $_/history

# install powerlevel10k: `p10k configure`
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${HOME}/code/powerlevel10k

# install zsh autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${HOME}/code/zsh-autosuggestions

# install fzf-tab
git clone https://github.com/Aloxaf/fzf-tab ${HOME}/code/fzf-tab

# zsh syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${HOME}/code/zsh-syntax-highlighting
