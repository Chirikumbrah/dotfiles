function gupa --wraps='git pull --rebase --verbose --autostash' --description 'alias gupa=git pull --rebase --verbose --autostash'
  git pull --rebase --verbose --autostash $argv; 
end
