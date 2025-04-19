# vim: set filetype=sh :

PKGS=(

# --- work: nvidia
git-lfs
ccache
libxcrypt-compat # `ngc` dependency
nvidia       # if nvidia-470xx-dkms is not used
linux-headers
dkms
# webkit2gtk    # dependency of cisco-anyconnect
webkit2gtk-4.1    # dependency of nm-applet for nvidia VPN
gcr  # dependency of nm-applet for nvidia VPN
#cuda-tools    # nsight profiler
vulkan-tools  # vulkaninfo
fuse2 # required for running `appimage`

) # PKGS

pacman -Syu --noconfirm --needed "${PKGS[@]}"
