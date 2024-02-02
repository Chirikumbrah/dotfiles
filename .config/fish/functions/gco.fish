function gco --wraps='git checkout $argv' --description 'alias gco=git checkout $argv'
  git checkout $argv 
end
