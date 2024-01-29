function rmi
  if count $argv > /dev/null
    if test "$argv[1]" = "$HOME/" || test "$argv[1]" = "$HOME" || test "$argv[1]" = "/"
      fd . "$argv[1]" --hidden -a -td -tf --color=always | fzf --ansi -m --preview '~/.config/fish/scripts/fzf-preview.sh {}' | xargs -I {} rm -ri {}
    else
      command rm -ri $argv
    end
  else
    fd --hidden -a -td -tf --color=always | fzf --ansi -m --preview '~/.config/fish/scripts/fzf-preview.sh {}' | xargs -I {} rm -ri {}
  end
end

