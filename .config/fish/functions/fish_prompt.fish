function fish_prompt --description 'Write out the prompt'
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

    set -l __pwd (set_color blue) (fish_prompt_pwd_dir_length=0 prompt_pwd)

    set -l __suffix (set_color green) ' (:'
    if test $__fish_last_status -ne 0
        set __suffix (set_color red) ' ):'
    end

    set -l __vcs (set_color yellow) (fish_vcs_prompt ' %s' 2>/dev/null)

    set -q VIRTUAL_ENV_DISABLE_PROMPT
    or set -g VIRTUAL_ENV_DISABLE_PROMPT true
    set -q VIRTUAL_ENV
    and set -l __venv (set_color magenta) (string replace -r '.*/' ' ' -- "$VIRTUAL_ENV")

    echo -n -s $__pwd $__venv $__vcs $__suffix " "
end
