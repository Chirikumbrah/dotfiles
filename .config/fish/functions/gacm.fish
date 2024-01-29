function gacm --wraps='git add . && git commit --all --message' --description 'alias gacm=git add . && git commit --all --message'
  git add . && git commit --all --message $argv; 
end
