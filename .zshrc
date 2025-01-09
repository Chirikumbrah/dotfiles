# ~~~~~~~~~~~~~~~ Options ~~~~~~~~~~~~~~~~~~~~~~~~
autoload edit-command-line; zle -N edit-command-line
setopt extended_glob null_glob histignorealldups sharehistory histignorespace prompt_subst auto_pushd
zstyle ':completion:*' menu select

# ~~~~~~~~~~~~~~~ Bindings ~~~~~~~~~~~~~~~~~~~~~~~~
bindkey -v # VI mode
bindkey "^N" history-beginning-search-forward
bindkey "^P" history-beginning-search-backward
bindkey "\ev" edit-command-line
bindkey -M vicmd "\ev" edit-command-line

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~
export \
    EDITOR=nvim \
    VISUAL=$EDITOR \
    XDG_CONFIG_HOME="$HOME/.config" \
    GPG_TTY=$(tty) \
    VIRTUAL_ENV_DISABLE_PROMPT=1 \

    KEYTIMEOUT=1 \
    HISTSIZE=100000 \
    SAVEHIST=100000 \
    HIST_IGNORE="(&|ls|[bf]g|gp|z|exit|history)"

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~
__vi_ins="%(?.%F{green}(:.%F{red}%):)%f"
__vi_cmd="%(?.%F{green}[¦.%F{red}]¦)%f"
__vi_mode=$__vi_ins
function zle-keymap-select { __vi_mode="${${KEYMAP/vicmd/${__vi_cmd}}/(main|viins)/${__vi_ins}}"; zle reset-prompt }; zle -N zle-keymap-select
function zle-line-finish { __vi_mode=$__vi_ins }; zle -N zle-line-finish
# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set __vi_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
function TRAPINT() { __vi_mode=$__vi_ins; return $(( 128 + $1 )) }
precmd() {
    function { v="${VIRTUAL_ENV##*/}"; [[ -n "$v" ]] && __venv="%F{magenta}$v%f" } # get VENV
    function { b=$(cat .git/HEAD 2>/dev/null); [[ -n "$b" ]] && { [[ "$b" =~ refs ]] && b=${b##*/} || b=${b:0:7}; __branch=" %F{yellow}$b%f" } } # get Git branch
}

PS1='${__venv} %F{blue}%~%F{yellow}${__branch} ${__vi_mode} '

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~
# ls
alias \
    l='ls --color=auto' \
    ll='ls -halF' \
    ls='ls -h --color=auto' \
# grep
alias \
    grep='grep --color=auto' \
    fgrep='fgrep --color=auto' \
    egrep='egrep --color=auto' \
# git
alias \
    ga='git add ' \
    gcm='git commit -m ' \
    gd='git diff ' \
    gs='git status' \

# ~~~~~~~~~~~~~~~ Sourcing ~~~~~~~~~~~~~~~~~~~~~~~~
if [[ "$OSTYPE" == "darwin"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    fpath+=( "/opt/homebrew/share/zsh-completions" )
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

[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
[[ $commands[zoxide] ]] && eval "$(zoxide init zsh)"
[[ $commands[fzf] ]] && source <(fzf --zsh)
[[ $commands[docker] ]] && source <(docker completion zsh)
