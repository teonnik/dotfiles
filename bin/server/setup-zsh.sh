# zsh config directory and history file
mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}"/zsh && touch $_/history

# install powerlevel10k: `p10k configure`
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${HOME}/.local/share/zsh/powerlevel10k

# install zsh autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${HOME}/.local/share/zsh/zsh-autosuggestions

# zsh syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${HOME}/.local/share/zsh/zsh-syntax-highlighting

# fzf history search
git clone https://github.com/junegunn/fzf ${HOME}/.local/share/zsh/fzf

# XDG base directories and other env vars
cat >> ~/.zprofile <<'EOF'
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export FZF_SHELL_COMPLETION_DIR="$HOME/.local/share/zsh/fzf/shell"
EOF

# make `zsh` the default shell for the user (requires password; updates `/etc/passwd`)
# chsh -s /usr/bin/zsh
