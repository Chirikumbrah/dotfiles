alias v="nvim"

# cd
alias ..="cd .."

# directories
alias dot="cd ~/Projects/mine/dotfiles"

# ls
alias ls='ls --color=auto'
alias la='ls -lah --color=auto'

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

# git
alias gp='git push'
alias gup='git pull'
alias gs='git status'
alias lg='lazygit'
alias gt='gitui'

# ricing
alias et='$EDITOR ~/.config/tmux/tmux.conf'
alias ez='$EDITOR ~/.config/zsh/.zshrc'
alias sz='exec zsh'

# terraform
alias tp='terraform plan'

# kubectl
alias k='kubectl'
# source <(kubectl completion bash)
alias kgp='kubectl get pods'
# complete -o default -F __start_kubectl k
alias kc='kubectx'
alias kn='kubens'

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='$EDITOR $(fp)'

