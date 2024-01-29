function reload --wraps='. ~/.config/fish/config.fish' --description 'alias reload=. ~/.config/fish/config.fish'
    . ~/.config/fish/config.fish $argv
end
