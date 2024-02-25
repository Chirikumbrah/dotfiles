# Set to superior editing mode
set -o vi

# keybinds
bind -x '"\C-l":clear'

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

lfcd() {
	tmp="$(mktemp -uq)"
	trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM EXIT'
	lf -last-dir-path="$tmp" "$@"
	if [ -f "$tmp" ]; then
		dir="$(cat "$tmp")"
		[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir" || :
	fi
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
export HISTCONTROL=ignoreboth
export HISTFILESIZE=10000
shopt -s histappend

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT_LONG=20
PROMPT_MAX=95

__ps1() {
	local branch \
		red='\[\e[31m\]' green='\[\033[32m\]' \
		yellow='\[\e[33m\]' blue='\[\e[34m\]' magenta='\[\e[35m\]' \
		cyan='\[\e[36m\]' reset='\[\e[0m\]'

	[[ $EUID == 0 ]] && sign='#' || sign='$' # root/user sign
	last_cmd_status="if [ \$? = 0 ]; then echo \"$reset$sign\"; else echo \"$red$sign\"; fi"
	branch=$(git branch --show-current 2>/dev/null)
	[[ -n "$branch" ]] && branch="$reset:$cyan$branch"

	PS1="$green\u@\h$reset:$blue\w$branch$blue\`$last_cmd_status\`$reset "

}

PROMPT_COMMAND="__ps1"

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v="$EDITOR"

# cd
alias ..="cd .."

# directories
alias dot="cd ~/Projects/mine/dotfiles"

# ls
alias l='ls -CF'
alias la='ls -A'
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

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~
if [[ "$OSTYPE" == "darwin"* ]]; then
	# brew install bash-completion@2
	[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] &&
		. "/opt/homebrew/etc/profile.d/bash_completion.sh" || :
	[[ -r "/Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash" ]] &&
		. "/Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash" || :
	eval "$(/opt/homebrew/bin/brew shellenv)"
else
	[[ -r /usr/share/bash-completion/bash_completion ]] && . \
		/usr/share/bash-completion/bash_completion ||
		[[ -f /etc/bash_completion ]] &&
		. /etc/bash_completion || :
fi

_pip_completion() {
	COMPREPLY="($(COMP_WORDS="${COMP_WORDS[*]}" \
		COMP_CWORD=$COMP_CWORD \
		PIP_AUTO_COMPLETE=1 $1 2>/dev/null))"
}
complete -o default -F _pip_completion pip3

source "$HOME/.cargo/env"
eval "$(zoxide init bash)"
