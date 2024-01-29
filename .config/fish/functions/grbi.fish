function grbi --wraps='git rebase --interactive' --description 'alias grbi=git rebase --interactive'
  git rebase --interactive $argv
        
end
