function trs
    if count $argv >/dev/null
        if test "$argv[1]" = "$HOME/" || test "$argv[1]" = "$HOME" || test "$argv[1]" = /
            fd . "$argv[1]" \
                --hidden \
                -I \
                -tf -td \
                --exclude "*venv" \
                --exclude ".git" \
                --color=always | fzf --ansi -m --preview '~/.config/fish/scripts/fzf-preview.sh {}' | xargs -I {} trash {}
        else
            trash $argv
        end
    else
        fd \
            --hidden \
            -I \
            -tf -td \
            --exclude "*venv" \
            --exclude ".git" \
            --color=always | fzf --ansi -m --preview '~/.config/fish/scripts/fzf-preview.sh {}' | xargs -I {} trash {}
    end
end
