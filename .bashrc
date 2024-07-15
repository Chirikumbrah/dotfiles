# Set to superior editing mode
set -o vi

# keybinds
bind -x '"\C-l":clear'

# ~~~~~~~~~~~~~~~ Options ~~~~~~~~~~~~~~~~~~~~~~~~

shopt -s globstar
shopt -s dotglob
shopt -s histappend
shopt -s autocd

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

_is_cmd_exist() { type "$1" &>/dev/null; }
_source_if_exist() { [[ -r "$1" ]] && source "$1"; }

lfcd() {
    _is_cmd_exist z && cmd="z" || cmd="cd"
    _is_cmd_exist lf && $cmd "$(command lf -print-last-dir "$@")" || echo "Please install lf."
}

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

export EDITOR=nvim
export VISUAL=$EDITOR
export BASH_SILENCE_DEPRECATION_WARNING=1
export XDG_CONFIG_HOME="$HOME/.config"

export PATH="$PATH:$HOME/.local/bin:$HOME/.config/scripts:$HOME/.cargo/bin:/Applications/Postgres.app/Contents/Versions/latest/bin:/Library/Frameworks/Python.framework/Versions/3.12/bin"
export PATH="$PATH:$HOME/.orbstack/bin"

export HISTSIZE=50000
export SAVEHIST=50000
export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=10000
export HISTIGNORE="&:ls:[bf]g:eb:gp:z:v:dot:exit:history"

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

__ps1() {
    local red='\[\033[31m\]' green='\[\033[32m\]' \
        yellow='\[\033[33m\]' blue='\[\033[34m\]' magenta='\[\033[35m\]' \
        cyan='\[\033[36m\]' reset='\[\033[0m\]'
    [[ $EUID == 0 ]] && sign='#' || sign='$' # root/user sign
    last_cmd_status="if [ \$? = 0 ]; then echo \"$reset$sign\"; else echo \"$red$sign\"; fi"
    branch=$(git branch --show-current 2>/dev/null)
    venv=$(basename "$VIRTUAL_ENV")
    [[ -n "$branch" ]] && branch="$reset:$yellow$branch"
    [[ -n "$venv" ]] && venv="$cyan$venv$reset:"
    PS1="$venv$green\u@\h$reset:$blue\W$branch\`$last_cmd_status\`$reset "
}

PROMPT_COMMAND="history -a ; __ps1"
# _is_cmd_exist starship && eval "$(starship init bash)"

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v="$EDITOR"

# cd
# alias ..="cd .."

# directories
alias dot="cd ~/Projects/mine/dotfiles"

# ls
alias l='ls --color=auto'
alias ll='ls -halF'
alias ls='ls -h --color=auto'

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# git
# alias gp='git push'
# alias gup='git pull'
# alias gs='git status'
# alias gt='gitui'

# ricing
alias eb='$EDITOR ~/.bashrc'
alias sb='source ~/.bashrc'

# finds all files recursively and sorts by last modification, ignore hidden files
# alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

# fzf aliases
# use fp to do a fzf search and preview the files
# alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
# alias vf='$EDITOR $(fp)'

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

if [[ "$OSTYPE" == "darwin"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    # brew install bash-completion@2 fzf zoxide
    _source_if_exist "/opt/homebrew/etc/profile.d/bash_completion.sh"
    # on mac you don't need to install new git version with brew 'cause needed files are exist :)
    _source_if_exist "/Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash"
    _source_if_exist "/Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh"
else
    _source_if_exist "/usr/share/bash-completion/bash_completion" &&
        _source_if_exist "/etc/bash_completion"
fi

# ~~~~~~~~~~~~~~~ Completions ~~~~~~~~~~~~~~~~~~~~~~~~

_pip_completion() {
    COMPREPLY=($(COMP_WORDS="${COMP_WORDS[*]}" \
        COMP_CWORD=$COMP_CWORD \
        PIP_AUTO_COMPLETE=1 $1 2>/dev/null))
}
complete -o default -F _pip_completion pip3

_source_if_exist "$HOME/.cargo/env"
_is_cmd_exist zoxide && eval "$(zoxide init bash)"
_is_cmd_exist fzf && eval "$(fzf --bash)"
# _is_cmd_exist starship && eval "$(starship init bash)"
