# zsh
#compinit -d ${XDG_CACHE_HOME}/zsh/zcompdump-$ZSH_VERSION
#HISTFILE="${XDG_STATE_HOME}"/zsh/history

# anaconda
#export PATH=$HOME/anaconda/bin:$PATH

# spack
SPACK_SKIP_MODULES="" # speedup sourcing `setup-env.sh`
source $HOME/software/spack/share/spack/setup-env.sh
alias sps="spack spec -Il --reuse"
alias spi="spack install -v --reuse"
alias spf="spack find -lvd"
alias sph="spack help --all"

# fzf
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# vim
alias vim=nvim
alias vl='vim ~/log/$(date "+%Y-%m-%d").md'
alias vt="vim ~/readme/todo.md"

# slurm
alias slq="squeue --me -o \"%10A %10l %10L %10P %10T %6D %z\""
alias slc="scancel -u $(whoami)"
alias sli="sinfo -S P -o \"%10P %6a %10A %20G %7m %z\""
alias sla="sacct -S 2020-01-01 -X --format=Start,JobName%20,JobID%10,NNodes,AllocGRES%20,Elapsed,ExitCode,State"

# lpass
export LPASS_CLIPBOARD_COMMAND="wl-copy"

# direnv
eval "$(direnv hook zsh)"

# open readme file
rme() { fd $1 ~/readme | xargs bat }

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

# other
alias recent='ls -ltch'
alias month='fd $(date +%Y-%m) ~/log | xargs bat'

# print env var one line at a time
#alias lecho='tr ':' '\n' <<< '

# neomutt
alias neomutt='ESCDELAY=0 neomutt'

# pacman
alias pacfindfile='pacman -Fq "/usr/bin/$1"'    # find which package contains the file


# --------------
# oh-my-zsh

# theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# plugins
plugins=(zsh-autosuggestions)

# activate
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# fzf (this has to go after oh-my-zsh)
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh