[[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] && source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

# ~~~~~~~~~~~~~~~ Options ~~~~~~~~~~~~~~~~~~~~~~~~
autoload edit-command-line; zle -N edit-command-line
setopt extended_glob null_glob histignorealldups sharehistory histignorespace prompt_subst
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive completion
zstyle ':completion:*' menu select

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~
function __fzf-urls-tmux { echo && [[ $commands[fzf-urls-tmux] ]] && fzf-urls-tmux ; zle reset-prompt }; zle -N __fzf-urls-tmux

# ~~~~~~~~~~~~~~~ Bindings ~~~~~~~~~~~~~~~~~~~~~~~~
bindkey -v # VI mode
bindkey "^N" history-beginning-search-forward
bindkey "^P" history-beginning-search-backward
bindkey "\ev" edit-command-line
bindkey -M vicmd "\ev" edit-command-line
bindkey "\eu" __fzf-urls-tmux
bindkey -M vicmd "\eu" __fzf-urls-tmux

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~
export \
    EDITOR=nvim \
    VISUAL=$EDITOR \
    XDG_CONFIG_HOME="$HOME/.config" \
    GPG_TTY=$(tty) \
    VIRTUAL_ENV_DISABLE_PROMPT=1 \
    FZF_DEFAULT_COMMAND='find . -type f ! -path ".git/*"' \
    FZF_DEFAULT_OPTS="--preview '[ -d {} ] && ls -1a --color {}/ || cat -n {}'" \
    KEYTIMEOUT=1 \
    HISTSIZE=100000 \
    SAVEHIST=100000 \
    HIST_IGNORE="(&|ls|[bf]g|gp|z|exit|history)"

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~
# ls
alias \
    l='ls --color' \
    ll='ls -halF' \
    ls='ls -h --color' \
# grep
alias \
    grep='grep --color' \
    fgrep='fgrep --color' \
    egrep='egrep --color' \
# git
alias \
    ga='git add' \
    gcl='git clone' \
    gcm='git commit -m' \
    gco='git checkout' \
    gd='git diff' \
    gs='git status' \

# ~~~~~~~~~~~~~~~ Sourcing ~~~~~~~~~~~~~~~~~~~~~~~~
if [[ "$OSTYPE" == "darwin"* ]]; then
    [[ -r "/opt/homebrew/bin/brew" ]] \
        && eval "$(/opt/homebrew/bin/brew shellenv)" \
        || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" ; eval "$(/opt/homebrew/bin/brew shellenv)"
    [[ -r "/opt/homebrew/share/zsh-completions" ]] \
        && fpath+=( "/opt/homebrew/share/zsh-completions" ) \
        || brew install zsh-completions ; fpath+=( "/opt/homebrew/share/zsh-completions" )
    [[ -r "/opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme" ]] \
        && source "/opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme" \
        || brew install powerlevel10k ; source "/opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme"
    path+=(
        "$HOME/.local/bin"
        "$HOME/.config/scripts"
        "$HOME/.cargo/bin"
        "/Applications/Postgres.app/Contents/Versions/latest/bin"
        "/Library/Frameworks/Python.framework/Versions/3.12/bin"
        "$HOME/.orbstack/bin"
    )
fi

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do compinit; done; compinit -C

[[ $commands[zoxide] ]] && eval "$(zoxide init zsh)"
[[ $commands[fzf] ]] && source <(fzf --zsh)
[[ $commands[docker] ]] && source <(docker completion zsh)
[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
[[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh" || p10k configure
