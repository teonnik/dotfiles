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
fdisk /dev/sdx

# 6. Format the partitions
mkfs.fat -F32 /dev/sdx1
mkfs.ext4 /dev/sdx2

# 7. Mount partitions:
mount /dev/sdx2 /mnt
mount --mkdir /dev/sdx1 /mnt/boot

# 8. Edit pacman's mirrorlist : /etc/pacman.d/mirrorlist

# 9. Install essential packages
pacstrap -K /mnt base linux linux-firmware

# 10. Generate the fstab file
genfstab -U /mnt >> /mnt/etc/fstab

# 11. Change root
arch-chroot /mnt

# 12. Install all my pacman packages: ~/.config/arch/my_packages.txt
wget -O my_packages.txt pastebin.com/<link> 
pacman -Syu $(sed 's:#.*$::g' my_packages.txt | tr '\n' ' ' | tr -s ' ')

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

# 16. Bootloader (!! in arch chroot)
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# 17. Set pacman's Color option
sed -i '/Color/s/^#//g' /etc/pacman.conf

# 18. Set the root password
passwd

# 19. Add a user
useradd -m -a -G wheel,video -s /usr/bin/zsh teonnik
passwd teonnik

# 20. Edit /etc/sudoers to allow for the wheel group
visudo /etc/sudoers

# 21. Enable services
systemctl enable NetworkManager.service \
                 bluetooth.service \
                 cups.service \
                 atd.service

systemctl --user enable xdg-desktop-portal.service \
                        syncthing.service
                        #pipewire.service
                        #pipewire-pulse.service
                        #pipewire.socket
                        #wireplumber.service

# 22. Reboot and login as user `teonnik`
reboot

# teonnik ---------------------------------------------------------

# 1. Chromium extensions - uBlock Origin, LastPass, BypassPaywalls, PrivacyBadger

# 2. Syncthing
#
# - Open the GUI with chromium at 127.0.0.1:8384 (man syncthing-faq)
# - Delete the default directory "Sync"
rm -rf ~/Sync

# 3. ssh keys
ssh-keygen -t ed25519 -C "teodor.nikolov22@gmail.com"

# 4. Create local folders
mkdir -p ~/code ~/build ~/downloads ~/bin

# 5. dotfiles in $HOME directory
git init
git remote add origin git@github.com:teonnik/dotfiles.git
git config status.showUntrackedFiles no
git fetch
git checkout -f master

# 6. AUR package manager
git clone https://aur.archlinux.org/yay.git
(cd yay; makepkg -si)

# 7. Install all my AUR packages: ~/config/arch/my_aur_packages.txt
wget -O my_aur_packages.txt pastebin.com/<link> 
yay -Syu $(sed 's:#.*$::g' my_aur_packages.txt | tr '\n' ' ' | tr -s ' ')

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

