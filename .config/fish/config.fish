# vim: filetype=fish
#
# Environment lives in one place: .config/shell/profile, in POSIX sh, so
# sh/bash/zsh and ly's session setup all read the same file. fish cannot
# source it, so it is run in sh and the resulting environment imported.
# Costs ~2 ms. Do not restate variables here -- edit the profile.

if not set -q __profile_imported
    set -gx __profile_imported 1
    sh -c '. "$HOME/.config/shell/profile" >/dev/null 2>&1; env -0' \
        | while read -lz entry
            set -l parts (string split -m 1 = -- $entry)
            test (count $parts) -eq 2; or continue
            # Shell bookkeeping belongs to this shell, not the subprocess.
            contains -- $parts[1] _ SHLVL PWD OLDPWD SHELL; and continue
            set -gx $parts[1] $parts[2]
        end
    # The profile prepends to PATH, so an inherited entry can appear twice.
    set -l seen
    for d in $PATH
        contains -- $d $seen; or set -a seen $d
    end
    set -gx PATH $seen
end

# ---- interactive only

status is-interactive; or exit 0

# -- key bindings
# Ctrl-arrows and Ctrl-Delete are bound by fish out of the box.
bind \cx\ce edit_command_buffer   # [Ctrl-x Ctrl-e] edit in $EDITOR

# -- aliases
# Shared with zsh. The file is written so that both can parse it; anything
# that cannot be spelled in both (printpath) is a script in ~/bin instead.
source "$XDG_CONFIG_HOME/shell/aliasrc"

# -- gpg
# Must be the current terminal, so it cannot live in the profile: that is
# sourced once at login with the login tty. pinentry needs it to prompt.
isatty; and set -gx GPG_TTY (tty)

# -- integrations
type -q direnv; and direnv hook fish | source
type -q zoxide; and zoxide init fish | source
type -q fzf; and fzf --fish | source

# -- prompt
# Dirty-tree marker in the vcs segment. Tracked changes only: adding
# showuntrackedfiles makes git walk the whole working tree, which costs
# ~20ms in spack and ladybird against ~5ms for this.
set -g __fish_git_prompt_showdirtystate 1

# Transient prompt is native in fish 4.x: prompt functions are re-run with
# --final-rendering before the command runs, so scrollback stays clean.
set -g fish_transient_prompt 1

# Prompt itself: one of fish's built-ins, selected with
#   fish_config prompt list | show | save <name>
# `save` writes functions/fish_prompt.fish, so nothing is needed here.
# It refuses to overwrite a fish_prompt defined elsewhere -- if you later
# want starship or tide, drop that file first and source the tool here.
