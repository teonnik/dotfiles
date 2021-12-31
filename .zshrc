# ---- aliases

alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vI"
alias ls="ls -hN --color=auto --group-directories-first"
alias ll="LC_COLLATE=C ls -al" # sort dots first
alias grep="grep --color=auto --exclude-dir=.git"
alias diff="diff --color=auto"

# spack
alias sps="spack spec -Il --reuse"
alias spi="spack install -v --reuse"
alias spf="spack find -lvd"
alias sph="spack help --all"

# vim
alias vim=nvim
alias vl='vim ~/log/$(date "+%Y-%m-%d").md'
alias vt="vim ~/readme/todo.md"

# slurm
alias slq="squeue --me -o \"%10A %10l %10L %10P %10T %6D %z\""
alias slc="scancel -u $(whoami)"
alias sli="sinfo -S P -o \"%10P %6a %10A %20G %7m %z\""
alias sla="sacct -S 2020-01-01 -X --format=Start,JobName%20,JobID%10,NNodes,AllocGRES%20,Elapsed,ExitCode,State"

# git
alias ga="git add --all"
alias gb="git branch"
alias gc='git checkout'
alias gd='git diff'
alias gg='git status -sb'
alias gl="git log --oneline --graph"
alias gm="git commit"
alias gpush='git push'
alias gpull='git pull'

alias neomutt='ESCDELAY=0 neomutt'
alias recent='ls -ltch'
alias month='fd $(date +%Y-%m) ~/log | xargs bat'
alias pacfindfile='pacman -Fq "/usr/bin/$1"'    # find which package contains the file
rme() { fd $1 ~/readme | xargs bat } # open readme file

# ------ zsh
#
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="${XDG_STATE_HOME}"/zsh/history
#compinit -d ${XDG_CACHE_HOME}/zsh/zcompdump-$ZSH_VERSION

# vi mode
bindkey -v
export KEYTIMEOUT=1

# [Ctrl-Delete] - delete whole forward-word
bindkey -M viins '^[[3;5~' kill-word
bindkey -M vicmd '^[[3;5~' kill-word
# [Ctrl-RightArrow] - move forward one word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word

# ------ plugins

# spack
SPACK_SKIP_MODULES="" # speedup sourcing `setup-env.sh`
source $HOME/software/spack/share/spack/setup-env.sh

# direnv
eval "$(direnv hook zsh)"

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# zsh-autosuggestions
source ${HOME}/code/zsh-autosuggestions/zsh-autosuggestions.zsh

# p10k theme
source ${HOME}/code/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
