function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l normal (set_color --reset)
    set -l status_color (set_color brgreen)
    set -l cwd_color (set_color $fish_color_cwd)
    set -l vcs_color (set_color brpurple)
    set -l prompt_status ""

    # Since we display the prompt on a new line allow the directory names to be longer.
    set -q fish_prompt_pwd_dir_length
    or set -lx fish_prompt_pwd_dir_length 0

    # Color the prompt differently when we're root
    set -l suffix '❯'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set cwd_color (set_color $fish_color_cwd_root)
        end
        set suffix '#'
    end

    # Color the prompt in red on error
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
        set prompt_status $status_color "[" $last_status "]" $normal
    end

    # $HOME is itself a git repo (dotfiles), so without this every directory
    # under it that isn't its own repo reports a branch. GIT_CEILING_DIRECTORIES
    # stops git walking up past $HOME; $PWD is always probed regardless of the
    # ceiling, so $HOME itself needs the explicit test. Scoped to the prompt --
    # git commands typed by hand still see the dotfiles repo.
    set -l vcs
    if test "$PWD" != "$HOME"
        set -lx GIT_CEILING_DIRECTORIES $HOME
        set vcs (fish_vcs_prompt)
    end

    echo -s $cwd_color (prompt_pwd) $vcs_color $vcs $normal ' ' $prompt_status
    echo -n -s $status_color $suffix ' ' $normal
end
