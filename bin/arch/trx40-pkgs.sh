# vim: set filetype=sh :

PKGS=(

# --- work: nvidia
git-lfs
ccache
libxcrypt-compat
#nvidia       # if nvidia-470xx-dkms is not used
linux-headers
dkms
webkit2gtk    # dependency of cisco-anyconnect
#cuda-tools    # nsight profiler
simplescreemrecorder
vulkan-tools  # vulkaninfo

) # PKGS

pacman -Syu --nonconfirm --needed "${PKGS[@]}"
