function fish_right_prompt --description 'Context that only matters sometimes'
    # Transient prompt re-runs this before the command; drop it so scrollback
    # keeps only the command, as p10k does.
    contains -- --final-rendering $argv; and return

    set -l parts

    # Duration of the last command, only once it was slow enough to notice.
    # p10k's threshold was 3s with 0 decimal places; $CMD_DURATION is in ms.
    if test $CMD_DURATION -ge 3000
        set -l s (math --scale=0 "floor($CMD_DURATION / 1000)")
        set -l out
        set -l d (math --scale=0 "floor($s / 86400)"); test $d -gt 0; and set -a out {$d}d
        set -l h (math --scale=0 "floor($s % 86400 / 3600)"); test $h -gt 0; and set -a out {$h}h
        set -l m (math --scale=0 "floor($s % 3600 / 60)"); test $m -gt 0; and set -a out {$m}m
        set -a out (math --scale=0 "$s % 60")s
        set -a parts (set_color yellow)(string join ' ' $out)(set_color normal)
    end

    # Background jobs, icon only -- p10k had BACKGROUND_JOBS_VERBOSE=false.
    if jobs -q
        set -a parts (set_color cyan)''(set_color normal)
    end

    # direnv exports DIRENV_DIR while an .envrc is loaded, and unsets it on
    # leaving the directory. (Not DIRENV_IN_ENVRC -- that exists only while
    # the .envrc is being evaluated.)
    if set -q DIRENV_DIR
        set -a parts (set_color yellow)▼(set_color normal)
    end

    # Only worth screen space when not a local session, like p10k's context.
    if set -q SSH_CONNECTION; or set -q SSH_TTY
        set -a parts (set_color brred)$USER@(prompt_hostname)(set_color normal)
    end

    set -a parts (set_color brblack)(date +'%I:%M:%S %p')(set_color normal)

    string join ' ' $parts
end
