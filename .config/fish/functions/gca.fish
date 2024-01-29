function gca --wraps='git commit -v --amend --no-edit' --description 'alias gca=git commit -v --amend --no-edit'
  git commit -v --amend --no-edit $argv; 
end
