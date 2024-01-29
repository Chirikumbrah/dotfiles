function gsta --wraps='git stash apply' --description 'alias gsta=git stash apply'
  git stash apply $argv; 
end
