# If not running interactively, don't do anything
case $- in *i*) ;; *) return;; esac

export EDITOR=nvim VISUAL=$EDITOR XDG_CONFIG_HOME="$HOME/.config" \
    GPG_TTY=${GPG_TTY:-$(tty)} CARGO_HOME=$HOME/.cargo GOPATH=$HOME/.go \
    LANG=en_US.UTF-8 LC_ALL=$LANG  \
    HISTSIZE=100000 HISTFILESIZE=$HISTSIZE KEYTIMEOUT=1 CLIPBOARD_NOGUI=1  HISTIGNORE="&:ls:[bf]g:z:exit:history" \
    KUBECONFIG=~/.kube/config:~/Projects/mine/homelab/terraform/generated/kubeconfig \
    TALOSCONFIG=~/Projects/mine/homelab/terraform/generated/talosconfig \
    PATH="$PATH:$HOME/.local/bin:$HOME/.config/scripts:$HOME/.orbstack/bin:$CARGO_HOME/bin:$GOPATH/bin"

    PS1='\[\033[34m\]\w\[\033[00m\]$(__git_ps1 ":\[\033[33m\]%s\[\033[00m\]")\$ '

alias ll='ls -halF' ls='ls -h --color' grep='grep --color' \
    brew-dump='brew bundle dump --file=~/.config/homebrew/Brewfile --force'

if [[ "$OSTYPE" == "darwin"* ]]; then
    . "/opt/homebrew/etc/profile.d/bash_completion.sh"
    . "/opt/homebrew/etc/bash_completion.d/git-prompt.sh"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
    export PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.12/bin"
fi

eval "$(zoxide init bash)"
eval "$(fzf --bash)"
[[ -r  "$CARGO_HOME/env" ]] && . "$CARGO_HOME/env"
