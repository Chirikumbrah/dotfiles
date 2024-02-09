function rm
    if count $argv >/dev/null
        if test "$argv[1]" = "$HOME/" || test "$argv[1]" = "$HOME" || test "$argv[1]" = /
            fd . "$argv[1]" \
                --hidden \
                -I \
                -tf -td \
                --exclude "*venv" \
                --exclude ".git" \
                --color=always | fzf --ansi -m --preview '~/.config/scripts/fzf-preview {}' | xargs -I {} rm -fr {}
        else
            command rm -rf $argv
        end
    else
        fd \
            --hidden \
            -I \
            -tf -td \
            --exclude "*venv" \
            --exclude ".git" \
            --color=always | fzf --ansi -m --preview '~/.config/scripts/fzf-preview {}' | xargs -I {} rm -fr {}
    end
end
