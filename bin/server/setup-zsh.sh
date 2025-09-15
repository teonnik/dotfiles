# zsh config directory and history file
mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}"/zsh && touch $_/history

# update environment variables
echo 'export FZF_SHELL_COMPLETION_DIR="$HOME/code/fzf/shell"' >> ~/.zprofile
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zprofile

# install powerlevel10k: `p10k configure`
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${HOME}/code/powerlevel10k

# install zsh autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${HOME}/code/zsh-autosuggestions

# zsh syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${HOME}/code/zsh-syntax-highlighting

# fzf history search
git clone https://github.com/junegunn/fzf ${HOME}/code/fzf

# make `zsh` the default shell for the user (requires password; updates `/etc/passwd`)
# chsh -s /usr/bin/zsh
