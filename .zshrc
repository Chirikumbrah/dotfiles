# ~~~~~~~~~~~~~~~ Options ~~~~~~~~~~~~~~~~~~~~~~~~

zmodload -i zsh/complist

setopt extended_glob
setopt null_glob
setopt histignorealldups
setopt sharehistory
setopt histignorespace
setopt prompt_subst
setopt auto_pushd
bindkey -v
bindkey -M menuselect '^[[Z' reverse-menu-complete
zstyle ':completion:*' menu select

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

export \
    EDITOR=nvim \
    VISUAL=$EDITOR \
    XDG_CONFIG_HOME="$HOME/.config" \
    # Fix for GPG password prompt on git commit -S
    GPG_TTY=$(tty) \
    VIRTUAL_ENV_DISABLE_PROMPT=1 \

    PATH="$PATH:$HOME/.local/bin" \
    PATH="$PATH:$HOME/.config/scripts" \
    PATH="$PATH:$HOME/.cargo/bin" \
    PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin" \
    PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.12/bin" \
    PATH="$PATH:$HOME/.orbstack/bin" \

    KEYTIMEOUT=1 \
    HISTSIZE=100000 \
    SAVEHIST=100000 \
    HIST_IGNORE="(&|ls|[bf]g|eb|gp|z|v|dot|exit|history)"

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*' formats " %F{yellow}%b"
zstyle ':vcs_info:git*' actionformats " %F{yellow}%b%f:%F{yellow}%a"
precmd() { vcs_info }

vim_ins_mode="%(?.%F{green}(:.%F{red}%):)%f"
vim_cmd_mode="%(?.%F{green}[¦.%F{red}]¦)%f"
vim_mode=$vim_ins_mode

function zle-keymap-select { vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"; zle reset-prompt }
zle -N zle-keymap-select

function zle-line-finish { vim_mode=$vim_ins_mode }; zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
# Thanks Ron! (see comments)
function TRAPINT() { vim_mode=$vim_ins_mode; return $(( 128 + $1 )) }
function __venv_info(){ venv="${VIRTUAL_ENV##*/}"; [[ -n "$venv" ]] && echo "%F{magenta}$venv%f" }

PS1='$(__venv_info) %F{blue}%~${vcs_info_msg_0_} ${vim_mode} '

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
    if [[ $commands[brew] ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        FPATH="/opt/homebrew/share/zsh-completions":$FPATH
        FPATH="/opt/homebrew/share/zsh/site-functions":$FPATH
    fi
fi

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
    compinit
done
compinit -C

[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
[[ $commands[zoxide] ]] && eval "$(zoxide init zsh)"
[[ $commands[fzf] ]] && source <(fzf --zsh)
[[ $commands[docker] ]] && source <(docker completion zsh)
[[ $commands[orbctl] ]] && source <(orbctl completion zsh)
