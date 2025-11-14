set -e

DOWNLOAD_DIR="$HOME/downloads"
INSTALL_DIR="$HOME/installs"

mkdir -p "$DOWNLOAD_DIR"
mkdir -p "$INSTALL_DIR"

# Function to get the latest asset URL for a given repo and asset identifier
get_latest_asset_url() {
  local repo="$1"
  local asset_id="$2"
  curl -s "https://api.github.com/repos/$repo/releases/latest" \
    | grep browser_download_url \
    | grep "$asset_id" \
    | cut -d '"' -f 4 \
    | head -n 1
}

# Define tools: repo and asset identifier
declare -A tools
tools[neovim]="neovim/neovim nvim-linux-x86_64.tar.gz"
tools[fd]="sharkdp/fd x86_64-unknown-linux-musl.tar.gz"
tools[fzf]="junegunn/fzf linux_amd64.tar.gz"
tools[ripgrep]="BurntSushi/ripgrep x86_64-unknown-linux-musl.tar.gz"
tools[fastfetch]="fastfetch-cli/fastfetch linux-amd64.tar.gz"
tools[lazygit]="jesseduffield/lazygit linux_x86_64.tar.gz"
tools[lazydocker]="jesseduffield/lazydocker Linux_x86_64.tar.gz"
tools[btop]="aristocratos/btop x86_64-linux-musl.tbz"
tools[yazi]="sxyazi/yazi x86_64-unknown-linux-musl.zip"
tools[bat]="sharkdp/bat x86_64-unknown-linux-musl.tar.gz"
tools[delta]="dandavison/delta x86_64-unknown-linux-musl.tar.gz"
tools[direnv]="direnv/direnv direnv.linux.amd64"

for tool in "${!tools[@]}"; do
  repo=$(echo "${tools[$tool]}" | awk '{print $1}')
  asset_id=$(echo "${tools[$tool]}" | awk '{print $2}')
  url=$(get_latest_asset_url "$repo" "$asset_id")
  filename="$DOWNLOAD_DIR/${url##*/}"

  echo "Downloading $tool from $url..."
  curl -L "$url" -o "$filename"

  echo "Unpacking $tool into $INSTALL_DIR..."
  case "$filename" in
    *.tar.gz)
      tar -xzf "$filename" -C "$INSTALL_DIR"
      ;;
    *.tbz)
      tar -xjf "$filename" -C "$INSTALL_DIR"
      ;;
    *.zip)
      unzip -d "$INSTALL_DIR" "$filename"
      ;;
    *)
      cp "$filename" "$INSTALL_DIR/"
      ;;
  esac
done

echo "All tools downloaded and unpacked into $INSTALL_DIR"
