function lsk --wraps='ssh-add -l' --description 'alias lsk=ssh-add -l'
  ssh-add -l $argv
        
end
