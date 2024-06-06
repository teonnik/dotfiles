HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="${XDG_STATE_HOME}"/zsh/history
setopt INC_APPEND_HISTORY_TIME

# Make sure `vi`-bindings are not used
bindkey -e
# [Ctrl-Delete] - delete whole forward-word
bindkey '^[[3;5~' kill-word
# [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey '^[[1;5D' backward-word
# [Ctrl-s] don't freez the terminal
stty stop undef
# [Backspace] - delete backward
bindkey "^?" backward-delete-char
# [Ctrl-x-e] edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# cd - stack old directories
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
# automatically cd into typed directory
setopt autocd

# highlight selected entry from completion menu
zstyle ':completion:*' menu select
# case-insensitive and hiphen-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

# aliases
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# spack
if [ -f "${HOME}/code/spack/share/spack/setup-env.sh" ]; then
  SPACK_SKIP_MODULES="" # speedup sourcing `setup-env.sh`
  source "${HOME}/code/spack/share/spack/setup-env.sh"
fi

# direnv
if type direnv > /dev/null; then
  eval "$(direnv hook zsh)"
fi

# fzf
source "${FZF_SHELL_COMPLETION_DIR:-/usr/share/fzf}/key-bindings.zsh"
source "${FZF_SHELL_COMPLETION_DIR:-/usr/share/fzf}/completion.zsh"

# zsh-autosuggestions
source ${HOME}/code/zsh-autosuggestions/zsh-autosuggestions.zsh
if [ "${XDG_SESSION_TYPE}" = "wayland" ]; then
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240' # fixes suggestion color in foot
fi

# p10k theme
source ${HOME}/code/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
