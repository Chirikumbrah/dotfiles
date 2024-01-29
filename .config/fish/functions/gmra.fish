function gmra --wraps='git merge --abort' --description 'alias gmra=git merge --abort'
  git merge --abort $argv
        
end
