#
# ~/.bashrc
#

if [[ "$OSTYPE" == "darwin"* ]]; then
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
    # echo "I'm on Mac!"

    # brew bash completion
    [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

__save_last_path() {
    echo "$PWD" >~/.cache/.last_bash_dir
}

# Check if the file exists and change to the last exited directory
if [ -f ~/.cache/.last_bash_dir ]; then
    cd "$(cat ~/.cache/.last_bash_dir)" || __save_last_path
fi
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set to superior editing mode
set -o vi

# keybinds
bind -x '"\C-l":clear'
bind -x '"\el":l'

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

# env variables
export EDITOR=hx
export VISUAL=$EDITOR
export BASH_SILENCE_DEPRECATION_WARNING=1
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~

PATH="${PATH:+${PATH}:}:$HOME/.local/bin:/opt/homebrew/bin:/Applications/Postgres.app/Contents/Versions/latest/bin:/Library/Frameworks/Python.framework/Versions/3.12/bin" # appending

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.cache/.bash_history
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
# Explicitly unset color (default anyhow). Use 1 to set it.
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_DESCRIBE_STYLE="branch"
# export GIT_PS1_SHOWUPSTREAM="auto git"

# colorized prompt
RESET='\[\e[0m\]'
PINK="\[\e[35m\]"
PURPLE="\[\e[31;34m\]"
GREEN='\[\e[38;5;10m\]'
RED="\[\033[31;1m\]"
SMILEY="${GREEN}:)${NORMAL}"
FROWNY="${RED}:(${NORMAL}"
STATUS="if [ \$? = 0 ]; then echo \"${SMILEY}\"; else echo \"${FROWNY}\"; fi"

PROMPT_COMMAND="__save_last_path && __git_ps1 '${PINK}\w${RESET}' ' \`${STATUS}\` ${PURPLE}>${RESET} '"

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v="$EDITOR"

# cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# ls
alias l='ls -lah --color=always'
alias ls='ls -ah --color=always'
alias la='ls -lathr --color=always'
# alias l='eza --git -alb --icons --classify || ls -lah --color=always'
# alias ls='eza --git -alb --icons --classify || ls -lah --color=always'
# alias lt='eza --git -Talb --icons --classify || tree || echo Please install "tree" or "eza"'

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias se='sudo -e'
alias t='tmux'
alias q='exit'

# git
alias gp='git push'
alias gco='git checkout'
alias gup='git pull'
alias gupa='git pull --rebase --verbose --autostash'
alias gs='git status'
alias gst='git stash'
alias glg='git log --stat'
alias grh='git reset --hard'
alias gt='gitui'

# ricing
alias eb='v ~/.bashrc'
alias sbr='source ~/.bashrc'

# terraform
alias tp='terraform plan'

# kubectl
alias k='kubectl'
# source <(kubectl completion bash)
# complete -o default -F __start_kubectl k
alias kgp='kubectl get pods'
alias kc='kubectx'
alias kn='kubens'

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='$EDITOR $(fp)'

eval "$(zoxide init bash)"
