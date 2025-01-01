# Set to superior editing mode
set -o vi

# keybinds
bind -x '"\C-l":clear'

# ~~~~~~~~~~~~~~~ Options ~~~~~~~~~~~~~~~~~~~~~~~~

shopt -s dotglob
shopt -s histappend

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

_is_cmd_exist() { type "$1" &>/dev/null; }
_source_if_exist() { [[ -r "$1" ]] && source "$1"; }

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

export \
    EDITOR=nvim \
    VISUAL=$EDITOR \
    BASH_SILENCE_DEPRECATION_WARNING=1 \
    XDG_CONFIG_HOME="$HOME/.config" \
    # Fix for GPG password prompt on git commit -S
    GPG_TTY=$(tty) \

    PATH="$PATH:$HOME/.local/bin" \
    PATH="$PATH:$HOME/.config/scripts" \
    PATH="$PATH:$HOME/.cargo/bin" \
    PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin" \
    PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.12/bin" \
    PATH="$PATH:$HOME/.orbstack/bin" \

    HISTSIZE=50000 \
    SAVEHIST=50000 \
    HISTCONTROL=ignoreboth:erasedups \
    HISTFILESIZE=10000 \
    HISTIGNORE="&:ls:[bf]g:eb:gp:z:v:dot:exit:history" \
    HISTTIMEFORMAT="%F %T " \


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
    PS1="$venv$blue\w$branch\`$last_cmd_status\`$reset "
}

PROMPT_COMMAND="history -a ; __ps1"

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias \
    l='ls --color=auto' \
    ll='ls -halF' \
    ls='ls -h --color=auto' \
    grep='grep --color=auto' \
    fgrep='fgrep --color=auto' \
    egrep='egrep --color=auto'

# ~~~~~~~~~~~~~~~ Sourcing ~~~~~~~~~~~~~~~~~~~~~~~~

if [[ "$OSTYPE" == "darwin"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    # brew install bash-completion@2
    _source_if_exist "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
    _source_if_exist "/usr/share/bash-completion/bash_completion" && \
        _source_if_exist "/etc/bash_completion"
fi

_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 2>/dev/null ) )
}
_is_cmd_exist pip3 && complete -o default -F _pip_completion pip3

_source_if_exist "$HOME/.cargo/env"
_is_cmd_exist zoxide && eval "$(zoxide init bash)"
_is_cmd_exist fzf && eval "$(fzf --bash)"
