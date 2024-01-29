function gup --wraps='git pull --rebase --verbose' --description 'alias gup=git pull --rebase --verbose'
  git pull --rebase --verbose $argv; 
end
