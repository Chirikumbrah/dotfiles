# Set to superior editing mode
set -o vi

# keybinds
bind -x '"\C-l":clear'

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

export EDITOR=nvim
export VISUAL=$EDITOR
export BASH_SILENCE_DEPRECATION_WARNING=1
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export XDG_CONFIG_HOME="$HOME/.config"

# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~
#
# https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path
# PATH="${PATH:+${PATH}:}~/opt/bin"   # appending
# PATH="~/opt/bin${PATH:+:${PATH}}"   # prepending

PATH="${PATH:+${PATH}:}:$HOME/.local/bin:/opt/homebrew/bin:/Applications/Postgres.app/Contents/Versions/latest/bin:/Library/Frameworks/Python.framework/Versions/3.12/bin" # appending
# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.cache/.bash_history
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_DESCRIBE_STYLE="branch"
# export GIT_PS1_SHOWUPSTREAM="auto git"

# colorized prompt
RESET='\[\e[0m\]'
PINK="\[\e[35m\]"
GREEN='\[\e[38;5;10m\]'
RED="\[\033[31;1m\]"
OK="${GREEN}\$${RESET}"
ERR="${RED}\$${RESET}"
STATUS="if [ \$? = 0 ]; then echo \"${OK}\"; else echo \"${ERR}\"; fi"

PROMPT_COMMAND="__git_ps1 '${PINK}\w${RESET}' ' \`${STATUS}\` '"

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v="$EDITOR"

# cd
alias ..="cd .."

# directories
alias dot="cd ~/Projects/mine/dotfiles"

# ls
# alias l='ls -lah --color=always'
# alias ls='ls -lah --color=always'

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias se='sudo -e'
alias t='tmux'

# git
alias gp='git push'
alias gup='git pull'
alias gs='git status'
alias lg='lazygit'

# python
alias pip="pip3"

# ricing
alias eb='v ~/.bashrc'
alias sbr='source ~/.bashrc'

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

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

if [[ "$OSTYPE" == "darwin"* ]]; then
    # . source ~/.fzf.bash 2>/dev/null || :
    # echo "I'm on Mac!"

    # brew bash completion
    [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh" || :

    # Added by OrbStack: command-line tools and integration
    . "${HOME}/.orbstack/shell/init.bash" 2>/dev/null || :

    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

. "$XDG_CONFIG_HOME/bash/git-prompt.sh"
. "$XDG_CONFIG_HOME/bash/git-completion.bash"
. "$HOME/.cargo/env"
eval "$(zoxide init bash)"
