function fcd
  if count $argv > /dev/null
    if test "$argv[1]" = "$HOME" || test "$argv[1]" = "$HOME/" || test "$argv[1]" = "/" 
      set DIR "$(fd . "$argv[1]" --hidden --type=directory --color=always | fzf --ansi)"
    else
      set DIR "$argv[1]"
    end
  else
    set DIR "$(fd --hidden --type=directory --color=always | fzf --ansi)"
  end
  if test $DIR != ''
    z $DIR
  end 
end
