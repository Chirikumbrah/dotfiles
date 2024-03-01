# Set to superior editing mode
set -o vi

# keybinds
bind -x '"\C-l":clear'

# ~~~~~~~~~~~~~~~ Options ~~~~~~~~~~~~~~~~~~~~~~~~

shopt -s histappend
shopt -s autocd

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

lfcd() {
	command -v z 2 &>/dev/null && cmd="z" || cmd="cd"
	$cmd "$(command lf -print-last-dir "$@")"
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
export HISTIGNORE="&:ls:[bf]g:eb:gp:z:v:dot:exit"

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

__ps1() {
	local branch \
		red='\[\033[31m\]' green='\[\033[32m\]' \
		yellow='\[\033[33m\]' blue='\[\033[34m\]' magenta='\[\033[35m\]' \
		cyan='\[\033[36m\]' reset='\[\033[0m\]'
	[[ $EUID == 0 ]] && sign='#' || sign='$' # root/user sign
	last_cmd_status="if [ \$? = 0 ]; then echo \"$reset$sign\"; else echo \"$red$sign\"; fi"
	branch=$(git branch --show-current 2>/dev/null)
	[[ -n "$branch" ]] && branch="$reset:$yellow$branch"
	[[ -n "$VIRTUAL_ENV" ]] && venv="$magenta$(basename "$VIRTUAL_ENV")$reset:"
	PS1="$venv$green\u@\h$reset:$blue\W$branch\`$last_cmd_status\`$reset "
}

PROMPT_COMMAND="history -a && __ps1"

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v="$EDITOR"

# cd
alias ..="cd .."

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
alias gp='git push'
alias gup='git pull'
alias gs='git status'
alias gt='gitui'

# ricing
alias eb='$EDITOR ~/.bashrc'
alias sb='source ~/.bashrc'

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='$EDITOR $(fp)'

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

if [[ "$OSTYPE" == "darwin"* ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
	# brew install bash-completion@2 fzf zoxide
	[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] &&
		. "/opt/homebrew/etc/profile.d/bash_completion.sh" || :
	[[ -r "/Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash" ]] &&
		. "/Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash" || :
	# /opt/homebrew/opt/fzf/install
	[ -f "$HOME/.fzf.bash" ] && source "$HOME/.fzf.bash" || :
else
	[[ -r "/usr/share/bash-completion/bash_completion" ]] && . \
		"/usr/share/bash-completion/bash_completion" ||
		[[ -f "/etc/bash_completion" ]] &&
		. "/etc/bash_completion" || :
fi

# ~~~~~~~~~~~~~~~ Completions ~~~~~~~~~~~~~~~~~~~~~~~~

_pip_completion() {
	COMPREPLY=($(COMP_WORDS="${COMP_WORDS[*]}" \
		COMP_CWORD=$COMP_CWORD \
		PIP_AUTO_COMPLETE=1 $1 2>/dev/null))
}
complete -o default -F _pip_completion pip3

source "$HOME/.cargo/env"
eval "$(zoxide init bash)"
