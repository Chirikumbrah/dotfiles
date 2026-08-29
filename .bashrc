case $- in *i*) ;; *) return;; esac
_gp(){ b=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); [[ $b == HEAD ]]&&b=$(git rev-parse --short HEAD 2>/dev/null); [[ $b ]]&&printf ':\033[33m%s\033[00m' "$b"; }
shopt -s histappend

export EDITOR=nvim VISUAL=nvim GPG_TTY=${GPG_TTY:-$(tty)} \
  PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }history -a" \
  PS1='\[\033[34m\]\w\[\033[00m\]$(_gp)\$ ' \
  CARGO_HOME=$HOME/.cargo GOPATH=$HOME/.go KEYTIMEOUT=1 CLIPBOARD_NOGUI=1 \
  LANG=en_US.UTF-8 GIT_COMPLETION_SHOW_ALL_COMMANDS=1 \
  HISTCONTROL=erasedups:ignoreboth HISTSIZE=100000 HISTFILESIZE=100000 \
  HISTIGNORE="ls:ls -la:ls -l:ls -a:pwd:clear:exit:history:bg:fg:jobs:cd:cd -:cd ..:cd ~" \
  KUBECONFIG=~/.kube/config:~/Documents/mine/homelab/talos-k8s/generated/kubeconfig \
  TALOSCONFIG=~/Documents/mine/homelab/talos-k8s/generated/talosconfig \
  PATH="$PATH:$HOME/.local/bin:$HOME/.config/scripts:$HOME/.orbstack/bin:$HOME/.cargo/bin:$HOME/.go/bin"

alias ll='ls -halF' ls='ls -h --color' grep='grep --color' k9s='TERM=xterm-256color k9s' \
  brew-dump='brew bundle dump --file=~/.config/homebrew/Brewfile --force'

if [[ "$OSTYPE" == "darwin"* ]]; then
  . "/opt/homebrew/etc/profile.d/bash_completion.sh"
  . "/opt/homebrew/etc/profile.d/bash-preexec.sh"
  . "/Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash"
  PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
  export PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.12/bin"
else
    . /usr/share/bash-completion/bash_completion || . /etc/bash_completion || :
fi

eval "$(zoxide init bash)" && eval "$(fzf --bash)"
eval "$(atuin init bash --disable-up-arrow --disable-ai)"
[[ -r  "$CARGO_HOME/env" ]] && . "$CARGO_HOME/env"
