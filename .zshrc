[[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] && \
    . "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

autoload edit-command-line; zle -N edit-command-line
setopt extended_glob null_glob histignorealldups sharehistory histignorespace prompt_subst
zstyle ':completion:*' menu select

bindkey -M vicmd "^X^E" edit-command-line; bindkey -v "^X^E" edit-command-line \
    "^N" history-beginning-search-forward "^P" history-beginning-search-backward

export EDITOR=nvim VISUAL=$EDITOR XDG_CONFIG_HOME="$HOME/.config" \
    GPG_TTY=$(tty) CARGO_HOME=$HOME/.cargo GOPATH=$HOME/.go \
    HISTSIZE=100000 SAVEHIST=100000 KEYTIMEOUT=1 CLIPBOARD_NOGUI=1 \
    VIRTUAL_ENV_DISABLE_PROMPT=1 HIST_IGNORE="(&|ls|[bf]g|gp|z|exit|history)" \
    KUBECONFIG=~/.kube/config:~/Projects/mine/homelab/terraform/generated/kubeconfig \
    TALOSCONFIG=~/Projects/mine/homelab/terraform/generated/talosconfig

alias ll='ls -halF' ls='ls -h --color' grep='grep --color' \
    brew-dump='brew bundle dump --file=~/.config/homebrew/Brewfile --force'

_lazy_load() {
    local cmd=$1 loader=$2
    eval "_${cmd}_completion_loader() {
    unfunction _${cmd}_completion_loader
    eval \"$loader\"
    }"
    compdef _${cmd}_completion_loader "$cmd"
}

if [[ "$OSTYPE" == "darwin"* ]]; then
    [[ -r /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme ]] && \
        . /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
    eval "$(/opt/homebrew/bin/brew shellenv)"
    fpath+=( "/opt/homebrew/share/zsh-completions" )
    path+=( "$HOME/.local/bin" "$HOME/.config/scripts" "$HOME/.orbstack/bin"
        "/Applications/Postgres.app/Contents/Versions/latest/bin" "$CARGO_HOME/bin"
        "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$GOPATH/bin"
    )
fi

autoload -Uz compinit
ZSH_COMPDUMP=${ZDOTDIR:-$HOME}/.zcompdump
[[ ${ZSH_COMPDUMP}(#qN.mh+24) ]] && compinit -d "$ZSH_COMPDUMP" || compinit -C -d "$ZSH_COMPDUMP"

[[ $commands[zoxide] ]] && eval "$(zoxide init zsh)"
[[ $commands[docker] ]] && _lazy_load docker '. <(docker completion zsh)'
_lazy_load terraform 'autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform'
[[ $commands[fzf] ]] && . <(fzf --zsh)
[[ -r "$CARGO_HOME/env" ]] && . "$CARGO_HOME/env"
[[ ! -f ~/.p10k.zsh ]] || . ~/.p10k.zsh
