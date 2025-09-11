[[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] \
    && . "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

autoload edit-command-line; zle -N edit-command-line
setopt extended_glob null_glob histignorealldups sharehistory histignorespace prompt_subst
zstyle ':completion:*' menu select

bindkey -M vicmd "\ev" edit-command-line; bindkey -v "\ev" edit-command-line \
    "^N" history-beginning-search-forward "^P" history-beginning-search-backward

export EDITOR=nvim VISUAL=$EDITOR XDG_CONFIG_HOME="$HOME/.config" \
    GPG_TTY=$(tty) CARGO_HOME=$HOME/.cargo GOPATH=$HOME/.go \
    FZF_DEFAULT_COMMAND='find . -type f ! -path ".git/*"' \
    FZF_DEFAULT_OPTS="--preview '[ -d {} ] && ls -1a --color {}/ || cat -n {}'"\
    HISTSIZE=100000 SAVEHIST=100000 KEYTIMEOUT=1 \
    VIRTUAL_ENV_DISABLE_PROMPT=1 HIST_IGNORE="(&|ls|[bf]g|gp|z|exit|history)"

alias ll='ls -halF' ls='ls -h --color' grep='grep --color' ga='git add' gl='git log' \
    gcl='git clone' gcm='git commit -m' gco='git checkout' gd='git diff' gs='git status'

if [[ "$OSTYPE" == "darwin"* ]]; then
    [[ -r "/opt/homebrew/bin/brew" ]] || /bin/bash -c "$(curl -fsSL \
        https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    [[ -r "/opt/homebrew/share/zsh-completions" ]] \
        || brew install zsh-completions
    fpath+=( "/opt/homebrew/share/zsh-completions" )
    [[ -r "/opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme" ]] \
        || brew install powerlevel10k
    . "/opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme"
    path+=( "$HOME/.local/bin" "$HOME/.config/scripts"
        "/Applications/Postgres.app/Contents/Versions/latest/bin"
        "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$GOPATH/bin"
        "$HOME/.orbstack/bin" "$CARGO_HOME/bin"
    )
fi

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do compinit; done; compinit -C

[[ $commands[zoxide] ]] && eval "$(zoxide init zsh)"
[[ $commands[fzf] ]] && . <(fzf --zsh)
[[ $commands[docker] ]] && . <(docker completion zsh)
[[ -r "$CARGO_HOME/env" ]] && . "$CARGO_HOME/env"
[[ -r "$HOME/.p10k.zsh" ]] && . "$HOME/.p10k.zsh" || p10k configure
