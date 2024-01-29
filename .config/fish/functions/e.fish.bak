function e
    if count $argv >/dev/null
        if test "$argv[1]" = "$HOME/" || test "$argv[1]" = "$HOME" || test "$argv[1]" = /
            set FILE "$(fd . "$argv[1]" \
            --hidden \
            -I \
            --exclude "*venv" \
            --exclude ".git" \
            -tf --color=always | \
            fzf --ansi --preview '~/.config/fish/scripts/fzf-preview.sh {}')"
        else
            set FILE "$argv[1]"
        end
    else
        set FILE "$(fd \
        --hidden \
        -I \
        --exclude "*venv" \
         --exclude ".git" \
        -tf --color=always | \
        fzf --ansi --preview '~/.config/fish/scripts/fzf-preview.sh {}')"
    end
    if test $FILE != ''
        $EDITOR "$FILE"
    end
end
