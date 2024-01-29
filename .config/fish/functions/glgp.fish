function glgp --wraps='git log --patch --stat' --description 'alias glgp=git log --patch --stat'
  git log --patch --stat $argv; 
end
