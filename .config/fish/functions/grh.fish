function grh --wraps='git reset --hard' --description 'alias grh=git reset --hard'
  git reset --hard $argv; 
end
