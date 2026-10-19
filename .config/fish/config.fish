# vim: filetype=fish
#
# Environment variables live in conf.d/env.fish, which fish sources before
# this file. Do not restate them here.

# ---- interactive only

status is-interactive; or exit 0

# No "Welcome to fish" banner. Set here rather than `set -U` so it lives in
# the repo instead of fish's machine-local universal variable file.
set -g fish_greeting

# -- key bindings
# Ctrl-arrows and Ctrl-Delete are bound by fish out of the box.
bind \cx\ce edit_command_buffer   # [Ctrl-x Ctrl-e] edit in $EDITOR
# [Ctrl-e] dismiss the completion pager, keeping the line. Matches blink.cmp,
# where <C-e> is 'cancel' too. Escape does this as well, but nvim's terminal
# swallows it. Overrides fish's preset (end-of-line, and accept the
# autosuggestion when already at the end) -- End, Ctrl-f and Right still cover
# both of those.
bind ctrl-e cancel

# -- abbreviations
# Expanded in place on space or enter, so the real command is what runs and
# what lands in history. Each spells out its ls flags: an abbreviation does
# not expand inside another. `..` needs nothing: fish cds into a bare path.
abbr -a cp 'cp -iv'
abbr -a mv 'mv -iv'
abbr -a rm 'rm -vI'
abbr -a ls 'ls -hN --color=auto --group-directories-first'
abbr -a l 'LC_COLLATE=C ls -alhN --color=auto --group-directories-first' # sort dots first
abbr -a recent 'ls -ltchN --color=auto --group-directories-first'
abbr -a grep 'grep --color=auto --exclude-dir=.git'
abbr -a diff 'diff --color=auto'

# xdg-open, quiet. Shadows fish's own `open`, which lets the opened
# application's output through to the terminal.
function open --description 'Open files in their default application'
    xdg-open $argv >/dev/null 2>&1
end

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
