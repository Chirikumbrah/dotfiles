export EDITOR=nvim
export VISUAL=$EDITOR
export XDG_CONFIG_HOME="$HOME/.config"
export HOMEBREW_NO_ANALYTICS=1

export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.config/scripts"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
export PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.12/bin"

export HISTSIZE=25000
export SAVEHIST=25000


