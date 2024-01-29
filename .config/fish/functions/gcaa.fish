function gcaa --wraps='git add . && git commit -v -a --amend --no-edit' --description 'alias gcaa=git add . && git commit -v -a --amend --no-edit'
  git add . && git commit -v -a --amend --no-edit $argv; 
end
