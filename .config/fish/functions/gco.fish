function gco --wraps='git checkout $argv || git checkout -b $argv' --description 'alias gco=git checkout $argv || git checkout -b $argv'
  git checkout $argv || git checkout -b $argv; 
end
